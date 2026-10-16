# codesys-framework
Framework to use with plc's in Codesys or TwinCAT

> Status: in opbouw. Dit document beschrijft de doelarchitectuur. Niet alles is al zo geïmplementeerd.

## Libraries

| Library     | Inhoud |
|-------------|--------|
| **Utils**   | Algemene bouwstenen zonder framework-kennis: timestamp, timer, blink, ... |
| **Core**    | Het framework: Mode, Module, Hardware, Component, Command, services en alle interfaces die het framework nodig heeft. |
| **IO**      | Eenvoudige IO: DI, DO, AI, AO. |
| **General** | Algemene modules en services: EmergencyStop, AirPressure, UserRequest, SignalLamp, ... |
| **Motion**  | (gepland) Assen en drives. |
| **Visu**    | Controllers en frames voor de visualisatie. |

### Afhankelijkheden

```
Application ──► Visu ──► General ──► Core ──► Utils
                         IO ──────► Core
                         Motion ──► Core
```

**Regel:** afhankelijkheden wijzen altijd naar Core, nooit weg van Core. Core kent General, IO of Motion niet.

**Interfaces staan in de laagste library die het concept nodig heeft.** Heeft Core iets uit een hogere library nodig, dan definieert Core de interface en implementeert de hogere library ze (dependency inversion). Voorbeelden:

| Interface        | Gedefinieerd in | Geïmplementeerd in      | Gebruikt door            |
|------------------|-----------------|-------------------------|--------------------------|
| `I_SafetyModule` | Core            | General (EmergencyStop, lichtscherm, lidar, ...) | Core (`FB_SafetyService`) |
| `I_ModeRequest`  | Core            | Core (`FB_ModeService`) | General (`FB_UserRequestModule`) |
| `I_Module`       | Core            | elke module             | Core (`FB_Mode`, `FB_ModuleGroup`) |

De **applicatie** is de enige plek die alle libraries kent. Daar gebeurt de bedrading: instanties aanmaken en via `FB_Init` aan elkaar doorgeven.

## Services

Er zijn twee services die ervoor kunnen zorgen dat modules stoppen. Ze **melden**, maar sturen zelf geen modules aan.

### EventService: gewone modules

- Elke module kan een event raisen (`RaiseEvent`) met een level: info, warning, alarm, ...
- Een alarm leidt tot een **Stop** (gecontroleerd stoppen).
- Alarmen worden gelatched tot de operator ze bevestigt. Zolang de oorzaak blijft (bv. te lage luchtdruk), raist de module het event opnieuw, zodat herstarten na een ack niet lukt.
- Events dragen hun bron mee (`eSubMachine`, `iSubMachineId`), zodat een ouder kan filteren op zijn eigen subboom.

### SafetyService: safety-modules

- Safety-modules (noodstop, lichtschermen, lidars, ...) implementeren `I_SafetyModule`.
- De SafetyService aggregeert ze en geeft één toestand: `Ok`, `QuickStop` of `ResetRequired`.
- Een NOK leidt tot een **QuickStop**.
- De **latch** zit in de SafetyService: na een NOK blijft de toestand `ResetRequired`, ook als de oorzaak weg is, tot er een expliciete `Reset` komt. Die reset lukt alleen als alle safety-modules weer `Ok` zijn.
- Een SafetyService wordt via `FB_Init` doorgegeven en is niet globaal. Zo kunnen er later meerdere zijn, bijvoorbeeld één per zone.

```iecst
// Core
INTERFACE I_SafetyModule
    PROPERTY Ok    : BOOL      // live toestand
    PROPERTY Name  : STRING
    METHOD   Reset : BOOL

INTERFACE I_SafetyService
    PROPERTY State : E_SafetyState   // Ok, QuickStop, ResetRequired
    METHOD   Reset : BOOL
```

> Dit is de **functionele** reactie op safety: netjes stoppen, de state machine bijhouden en meldingen geven. De eigenlijke veiligheidsfunctie (STO, contactors) blijft in de safety-PLC of het safety relay.

## Modeboom

Modes en modules vormen een **boom**. De Mode is de wortel. Een module met kinderen gedraagt zich voor die kinderen zoals de Mode voor zijn modules.

```
FB_AutoMode                     ← leest SafetySrv + EventSrv (hele machine)
 ├─ FB_FeedStation             ← leest SafetySrv zone "Feed" (lidar)
 │   ├─ FB_Conveyor
 │   └─ FB_Gripper
 └─ FB_PressStation
     ├─ FB_Press
     └─ FB_Clamp
```

### Regels

1. **Eén ouder.** Elke module heeft precies één ouder. Alleen die geeft commando's als `Execute`, `Enable` of `Home`.
2. **Stop is dominant.** `Stop()` en `QuickStop()` gaan altijd naar beneden, nooit naar opzij. Een module in (Quick)Stop weigert andere commando's tot ze een `Reset` krijgt. Stoppen wint altijd.
3. **Commando's gaan naar beneden, status gaat naar boven.** Een ouder meldt pas "gestopt" als al zijn kinderen `NOT Busy` zijn.
4. **Services lezen binnen je eigen scope.** De wortel (Mode) reageert op alles. Een tussenliggende module leest een service alleen als ze iets lokaals moet afhandelen, zoals de safety van haar zone of alarmen uit haar subboom. Anders blijven de services in `FB_Init` op 0.
5. **Modules stoppen elkaar niet via events.** Een module raist een event, en de ouder beslist wat er gebeurt.
6. **Bladmodules kennen geen services.** Ze voeren `Stop()` of `QuickStop()` uit als hun ouder dat vraagt, en raisen hoogstens zelf een event. Zo blijven ze herbruikbaar.

### Reactie in de Mode

| Trigger                    | Mode-state  | Actie op de kinderen | Daarna |
|----------------------------|-------------|----------------------|--------|
| SafetyService ≠ `Ok`       | `QuickStop` | `QuickStop()`        | als alle kinderen gestopt zijn: `Invalid`, wacht op ResetSafety |
| Alarm via EventService     | `Stop`      | `Stop()`             | als alle kinderen gestopt zijn: `Standby` of `Invalid` |
| StopRequest van gebruiker  | `Stop`      | `Stop()`             | `Standby` |

- Een commando wordt **elke cyclus herhaald** zolang de state actief is, niet alleen bij het binnenkomen. Dat volgt de semantiek van `FB_Command`: blijven `Invoke`n is pollen.
- De base-implementatie stopt alle kinderen **parallel**. Een concrete mode of module mag `ProcessStop` overriden als de volgorde belangrijk is (eerst de transportband, dan de robot).

### `FB_ModuleGroup`

`FB_Mode` en `FB_Module` hebben elk hun eigen state machine. De stoplogica voor kinderen zit daarom in een hulp-FB in Core, die beide gebruiken (compositie, geen overerving):

```iecst
FUNCTION_BLOCK FB_ModuleGroup
VAR
    _aChildren : ARRAY[0..cMaxChildren] OF I_Module;
END_VAR

METHOD Stop      : BOOL   // Stop() op alle kinderen, TRUE = allemaal gestopt
METHOD QuickStop : BOOL
METHOD Reset     : BOOL
PROPERTY Busy    : BOOL   // OR van alle kinderen
```

```iecst
// in ProcessQuickStop van een Mode of module
IF _fbChildren.QuickStop() THEN
    _eState := ...;   // volgende state
END_IF
```

## User requests

Start, stop, reset, ... zijn **commando's naar Core**. Ze lopen niet via de EventService: events betekenen "dit is gebeurd", requests betekenen "doe dit" en hebben feedback nodig.

```
Visu / drukknoppen / remote
        │
        ▼
FB_UserRequestModule (General) ──► I_ModeRequest (Core) ──► FB_ModeService ──► actieve FB_Mode
```

### Core: `I_ModeRequest`

Core legt vast welke requests er bestaan. De Mode beslist via zijn state machine of een request in de huidige state toegelaten is.

```iecst
INTERFACE I_ModeRequest
    METHOD StartRequest         : BOOL   // TRUE = geaccepteerd
    METHOD StopRequest          : BOOL
    METHOD QuickStopRequest     : BOOL
    METHOD ResetSequenceRequest : BOOL
    METHOD ResetSafetyRequest   : BOOL
    METHOD SetRequest           : BOOL   // iRequest, pData, pSize: mode-specifiek

INTERFACE I_ModeService EXTENDS I_ModeRequest
    METHOD   RequestMode
    PROPERTY ActiveMode
    PROPERTY ActiveState
```

- Een geweigerde request wordt gelogd via de EventService.
- `SetRequest` is een generiek kanaal. De concrete request-ID's worden gedefinieerd in de applicatie of bij de concrete Mode. Core routeert ze alleen naar de actieve mode.

### General: `FB_UserRequestModule`

Hier zit alles over **waar** een request vandaan komt en **hoe** het binnenkomt:

- **Bronnen:** visu, hardware-drukknoppen, remote/OPC UA.
- **Arbitrage:** local/remote, welke bron mag bedienen.
- **Gebaren:** 2× stop binnen 500 ms wordt een QuickStop, stop lang ingedrukt wordt een ResetSequence.
- **Logging** met `sSource`.
- **Routering:** `ResetSafety` gaat naar de SafetyService en naar de Mode.

De visu-controllers kennen alleen `I_UserRequestModule` en bevatten zelf geen logica.

## Bedrading in de applicatie

```iecst
fbEventSrv      : FB_EventService(...);
fbSafetySrv     : FB_SafetyService(aSafetyModules := [fbEmergencyStop, fbLightCurtain]);

fbAutoMode      : FB_AutoMode(
                      eMode       := E_Modes.Auto,
                      fbEventSrv  := fbEventSrv,
                      fbSafetySrv := fbSafetySrv,
                      aModules    := [fbFeedStation, fbPressStation]);

fbModeSrv       : FB_ModeService(fbEventSrv := fbEventSrv, afbModes := [...]);
fbUserRequest   : FB_UserRequestModule(fbModeRequest := fbModeSrv, fbSafetySrv := fbSafetySrv);
```

### Volgorde in de taak

1. Hardware / IO inlezen
2. SafetyService
3. ModeService / Mode
4. Modules (van ouder naar kind)
5. Hardware / IO schrijven

Een andere volgorde werkt ook, maar dan reageer je een cyclus later.
