# CLAUDE.md

Guidance for Claude when working in this repository.

## What this is

A personal PLC framework for CODESYS (and later TwinCAT), written in IEC 61131-3 Structured Text with OOP (FBs, interfaces, properties, methods). It grew out of a framework built at Gilbos and is now being restructured into separate libraries.

- **Status: work in progress.** [README.md](README.md) describes the *target* architecture. The code is mid-refactor and **does not compile**: many FBs still reference old members (`_fbLogger`, `I_EventHandlerService`, `_fbEmergencyStopMod`, ...) that no longer exist. Do not assume something in the code is the intended design; check the README first.
- **Current focus:** building out **WeVe Core**, especially the **event system** (see [Events: current state](#events-current-state-vs-target)).
- The user communicates in Dutch. Reply in Dutch unless asked otherwise. The README and identifiers are in English; some code comments (e.g. `FB_Command`) are in Dutch.

## Purpose and layers

The framework sets down **one clear structure for how a machine program is built**: layers that work together, each with its own responsibility. Overview and dependencies: [docs/layers/layers.svg](docs/layers/layers.svg) (source: `layers.drawio`). Arrows in the diagram: Mode → Module, Service, Event, Safety; Module → Hardware, Service, Event, Safety; Service → Event.

| Layer | Role |
|---|---|
| **Mode** | Top layer: *how* the machine operates. The machine always does the same thing, the mode decides who drives it. **Auto**: runs autonomously. **Manual**: the operator requests (sub)tasks. **Maintenance**: the operator drives components directly. **Test modes** (user-defined): e.g. run the machine in a test cycle. The mode decides whether and which modules are stopped when an error occurs. |
| **Module** | The machine is split into as many **self-contained modules** as possible. A module has a state and executes tasks. It contains hardware and/or submodules (tree). |
| **Hardware** | Abstraction layer over components. The module calls a functional method (e.g. `Open`), so swapping a cylinder for a motor only changes the hardware implementation, never the module. **Hardware has no events of its own**; it exposes status/errors and the owning module raises the event. |
| **Service** | Calculations and data processing, usually in a **slower PLC task**. Also the cross-cutting EventService and SafetyService (see README). |
| **Event** | Used by Mode, Module and Service (not Hardware). Two uses: **logging** (start, stop, reset pressed, ...) and **errors** that are reported up to the Mode, which decides what to stop. |
| **Safety** | Functional reaction to safety (QuickStop, latch, reset). The real safety function stays in the safety PLC/relay. |

### Events (design intent of the user, leading over the README where they differ)

- **`FB_Event`** is the single event block. Two kinds of events: a **one-shot** (log only, e.g. start/stop/reset button pressed) and a **warning/alarm** (has an active state).
- **Every event can be logged.** `FB_Event` uses **`I_Logger`** (not a separate event logger), so the same logger can also be used for debugging. Implementations: a txt file, an array of strings, Hyperion (Gilbos).
- **The event builds the log string itself** (message + payload filled in) and passes it to the logger.
- **Decided `I_Logger`**, one interface with two methods:
  - `LogMessage(eLevel, sMessage)`: free text, for debugging.
  - `LogEvent(scEvent, scPayload, sMessage)`: called by `FB_Event`. Text loggers (txt file, string array) only write `sMessage`; the Hyperion logger uses ID, level and payload (Hyperion needs structured data, see `ToDo/Hyperion/Struct/SC_Hyperion_EventStruct`).
  - The logger knows nothing about event transitions (raised, cleared, reset, ...): it only sends the text somewhere. The event puts everything in the text.
  - Timestamp and counter are added by the logger, not by the event.
- `FB_Event` holds an `SC_Event` / `SC_EventConfig` (ID, level, message, resetable, ...).
- **Ownership:** the event instances belong to the mode, module or service that raises them.
- **Configuration:** not in the module (modules already have enough responsibilities), but in an **EventGroup per owner**.
- **`FB_EventService`**: returns the active warnings and alarms, and can drive other things based on them (e.g. status lights).

#### Decided: EventGroup per owner

- Every module, mode or service that has events gets its own **EventGroup** (`FB_XxxEvents EXTENDS FB_EventGroup`). The group **holds the `FB_Event` instances**, initializes their config, and injects the logger.
- **Index = enum per owner**, not the event ID: `E_AirPressureEvent : (PressureNok := 0, ..., Count)`, `_afbEvents : ARRAY[0..E_AirPressureEvent.Count] OF FB_Event`. The event ID (`cEv_...`) is only a field in the config.
- The owner receives the group **through an interface** (`itfEvents : I_EventGroup` in `FB_Init`), **not a pointer to the array**: there is no bounds check on `ADR`, a pointer that is 0 crashes the PLC, and pointers are fragile on online change.
- The owner calls **forwarding methods on the group**: `_itfEvents.Condition(E_AirPressureEvent.PressureNok, xCond)`, `_itfEvents.Log(E_..., scPayload)`. The group does the bounds check. `Event(n) : I_Event` may exist for edge cases (local variable + `<> 0` check).
- **`FB_EventService` registers groups, not individual events**, and aggregates `HasAlarm` / `HasWarning` over them. A mode or intermediate module can look only at the groups of its own subtree.
- Wiring happens in `FB_Application`: create the logger, service and groups, pass the group to the owner via `FB_Init`, and register the groups with the service in `Initialize`.

#### CODESYS limitations to keep in mind

- **No method chaining:** `a.GetX().Method()` is not possible. Use forwarding methods or a local variable.
- **Optional inputs:** an input can only be left out of a call when it has an initial value in its declaration, e.g. `scPayload : SC_EventPayload := (asPayload := [10('')]);`. Interface and implementation must declare the same default.

### Dependency injection

As much as possible via **`FB_Init`** parameters or via **setters called from `FB_Application`**. `FB_Application` is the composition root where everything is created and wired.

## Repository layout

| Path | What |
|---|---|
| [plc/Example.project](plc/Example.project) | The CODESYS project, **source of truth** (binary). |
| [txt/application/](txt/application/) | **Claude's working folder**: plain-text copy of the code, tracked in git. Read and write only here. |
| `plc/Example/Device/application/` | PLC Designer (CODESYS-based) export/import folder, gitignored. The user syncs it with `txt/`. **Claude does not read or touch it.** |
| [core/core.library](core/core.library) | Compiled/packaged Core library (binary). |
| [docs/layers/](docs/layers/) | Layer diagram (`layers.drawio` + exported `layers.svg`). |

Inside `application/`, the top-level folders are the future libraries:

| Folder | Becomes |
|---|---|
| `WeVe Core (library)/` | Core: Application, Mode, Service, Module/Hardware, Safety, Component, Event, Logger, Command (numbered folders `00`–`80`). |
| `WeVe General (library)/` | General modules: AirPressure, Blink, EmergencyStop, ... |
| `WeVe IO (library)/` | DI, DO, AI, AO. |
| `WeVe Utils (library)/` | TimeStamp, ... |
| `WeVe Visu (library)/` | Visu controllers (`.pou.st`) and frames/dialogs (`.xml`). |
| `ToDo/` | **Legacy code** from the old Gilbos framework (global-variable based event handling, Hyperion, Camera, Cylinder, Utils). Reference for behaviour, still to be migrated into the libraries. Do not extend it. |
| `PLC_PRG`, `GVL_ComponentHardware*` | Application entry; `GVL_ComponentHardware*` is generated, do not change. |

### Export format

- Files are UTF-8 without BOM, **CRLF** line endings, tabs for indentation. Check CRLF after every write or `sed -i` (Git Bash `sed` can drop the CR).
- One file per object. Suffix = object type: `.pou.st` (FB/function/program), `.method.st`, `.prop.st`, `.interface.st`, `.dut.st` (enum/struct), `.gvl.st`, `.xml` (visu, task config).
- A method or property of `FB_X` lives in folder `FB_X/` (subfolders like `States/`, `Private/`, `Properties/` are just CODESYS folders, not namespaces).
- `// --- BEGIN IMPLEMENTATION ---` separates declaration from body. Properties additionally have `// ----------- GET -----------` / `SET` sections with `// -- BEGIN IMPLEMENTATION GET --`.
- `{warning 'Add method implementation '}` marks auto-generated stubs that are still empty.

### Editing workflow

- There is no build, compile or test tooling outside the CODESYS IDE. Claude cannot compile; check code carefully by hand (types, declared members, interface conformance).
- Code only becomes real once the user imports it into PLC Designer. **By default, propose code in chat**, split the same way as the export (declaration block + implementation, per POU/method/property). When the user asks to write files, write them in `txt/application/`, in the export format. Never touch `plc/`.
- `.gitignore` ignores everything with an extension and whitelists specific types/folders. A new file type or folder outside the whitelist must be added there to be tracked.
- After editing `docs/layers/layers.drawio`, re-export the SVG with the command in the README.

## Architecture (summary, details in README)

- **Dependencies point towards Core:** `Application → Visu → General → Core → Utils`, `IO → Core`, `Motion → Core`. Core never knows General/IO/Motion/application.
- **An interface lives in the lowest library that needs the concept** (dependency inversion), e.g. `I_SafetyModule` in Core, implemented in General.
- **Wiring only in the application**, via `FB_Init` parameters. No globals for services.
- **`FB_Init` only stores references.** Never call methods on other FBs there. Registration and setup happen in `Initialize()` on the first cycle.
- **Mode tree:** Mode is the root, modules form a tree. One parent per module; commands go down, status goes up; Stop/QuickStop are dominant; modules don't stop each other via events; leaf modules don't know services. Child handling is shared via `FB_ModuleGroup` (composition).
- **Services report, they never command:** EventService (alarm → Stop) and SafetyService (NOK → QuickStop, latched until Reset).
- **Requests are not events:** start/stop/reset go `FB_UserRequestModule (General) → I_ModeRequest (Core) → FB_ModeService → active FB_Mode`.
- **Commands:** `FB_Command` + `Async`/`Await` for step chains. One active command per module (parallel work → submodules). Calling `Invoke` repeatedly = polling: `Busy` ..., then the end result (`Done`/`Error`/`Aborted`) is delivered **once** (`_xDelivered`); the next `Invoke` of the same command starts it again (so the same command in two consecutive steps works). Call at most once per cycle. Fire-and-forget: `Async`, later `ResultOf()` (never starts anything). `iCmd <= 0` → `Rejected`; rejected commands are never silently ignored. On `Abort` the module itself puts its outputs in a safe state. **Timeout** per command: `Invoke(..., tTimeout := T#3S)` (`T#0S` = none); `Cyclic` runs a TON while `Busy`, on expiry the result becomes `Error` and `TimedOut` is TRUE until the next start; the module raises an event with `Condition(..., _fbCmd.TimedOut)`. Finer per-step timeouts stay in the module. **In `FB_Module` (2026-11-20):** one `_fbCmd` per module; body calls `_fbCmd.Cyclic()` before `ProcessState`; derived modules use protected `InvokeCommand(iCmd, tTimeout, xStart=>)` (allowed in Standby/Execute, start → state Execute) and override protected `ExecuteCommand(iCmd)`; `ProcessExecute` returns to Standby when `Active = 0`; `ProcessStop`/`ProcessQuickStop` call `_fbCmd.Abort()`; public `CommandResult(iCmd)` for fire-and-forget. `FB_Command.Last` = last started command (also after timeout).
- **Task order:** read IO → SafetyService → ModeService/Mode → modules (parent before child) → write IO.
- Keep Core portable between CODESYS and TwinCAT: avoid vendor-specific libraries in Core where possible.

## Events: current state vs target

(Paths below are relative to `txt/application/`.)

Target design as written in the README (*Events*; note the open point on a separate init service above): `FB_Event` (edge detection, latch, reset rules, logs itself, only knows the logger) / `FB_EventGroup` per module (enum + array of `FB_Event`, `Configure(...)` lines in `Initialize`, `RegisterEvents(srv)`) / `FB_EventService` (list of `I_Event` references, summary state, global reset, hands out the logger via `Bind`) / `FB_EventLogger` (ring buffer, async write-out to Hyperion/file/visu, overflow counter). Event IDs are unique constants per library with their own range; instances are distinguished by `nSubMachine`/`nSubMachineId`, never by a different ID.

What exists in `WeVe Core (library)/60 Event` and `70 Logger` today:

- `SC_Event` (id, submachine, level, resetable, message), `SC_EventPayload` (10 strings), `SC_EventState` (warning/alarm).
- **Interfaces defined (2026-11-20):**
  - `I_Logger`: `LogMessage(eLevel, sMessage)`, `LogEvent(scEvent, scPayload, sMessage)`.
  - `I_Event`: `Condition(xCondition, scPayload)`, `Log(scPayload)`, `Reset`, `Config` (GET/SET), `Logger` (SET), `Disabled` (GET/SET), `Active` (GET), `Level` (GET).
  - `I_EventGroup`: `Initialize`, `Condition(iEvent, xCondition, scPayload)`, `Log(iEvent, scPayload)`, `Reset`, `GetEvent(iEvent)`, `Count`, `HasWarning`, `HasAlarm`.
  - `I_EventService.Register` takes an `I_EventGroup`.
  - Supporting constant: `GVL_Logger.cMaxMessageLength`.
- **`FB_Event` implemented (2026-11-20):** edge detection, latch via `xResetable`, reset only when the condition is gone, log line `<level> [raised|cleared|reset] | <id> | <subMachine>.<subMachineId> | <message>`. Placeholders are `%0`..`%9` (decided), filled from `SC_EventPayload.asPayload[0..9]`.
- **`FB_EventGroup` implemented (2026-11-20):** ABSTRACT base. Derived group supplies the enum, the `FB_Event` array, `GetEvent` (bounds check), `Count` and `ConfigureEvents` (one `Configure(...)` line per event). `FB_Init(fbLogger, nSubMachine, nSubMachineId)`. `Initialize` (once, at startup) passes the logger and calls `ConfigureEvents`. `Config` is only set at startup, never cyclically; cyclic code uses `I_Event.Level`. `HasAlarm` = Operator or Supervisor level (`OnlyLogLevel` does not count).
- **`FB_EventService` implemented (2026-11-20):** `FB_Init(fbLogger)`, `Register(group)` (stores, duplicate check, logs when `cMaxGroups` is full; initializes the group at once if the service is already initialized), `Initialize` (initializes all groups), cyclic body builds `SC_EventState` over all groups (call in the same task as the Mode, before the Mode), `Reset` resets all groups. `I_Service.Initialize`/`Reset` now return BOOL; `I_EventService.State` is GET only.
- **`FB_CsvFileLogger` implemented (2026-11-20)** in `WeVe General (library)/CsvFileLogger/` (moved out of Core on request: it depends on CAA File, Core stays vendor-neutral): default `I_Logger` that writes `Timestamp;Counter;Level;"Message"` lines to a csv file on the PLC. Ring buffer (`cBufferSize` 100, overflow counted and reported in the log), async write with **CAA File** (`FILE.GetSize/Open(MAPPD)/Write/Close`), header for a new file, retry after `tRetry`. `FB_Init(sFileName, fbTimeStamp : I_TimeStampService)` (from Utils). Body must run in the same task as the callers (buffer not multi-task safe). Line max 255 chars. No file rotation yet. Shared `F_EventLevelToText` is used by `FB_Event` and the logger.
- **Not implemented yet:** Hyperion logger, string-array logger.
- **Mode migrated (2026-11-20):** `10 Mode/Events/` holds `E_ModeEvents` + `FB_ModeEventGroup`: **one shared group** for `FB_ModeService` and all `FB_Mode`s (deliberate exception to one group per owner, chosen by the user: only one-shot log events, the mode name is in `%0`; split again if a mode gets stateful alarms). All owners get `fbEvents : I_EventGroup` via `FB_Init` and use `_fbEvents.Log(...)` with a `<> 0` check. `FB_Mode` reads alarms/warnings from `_fbEventSrv` (whole machine) and has `ResetEvents` (calls `_fbEventSrv.Reset()`). Group naming: `FB_<Owner>EventGroup`.
- **Module migrated (2026-11-20):** `FB_Module.FB_Init(fbEvents : I_EventGroup)` (may be 0) replaces the legacy `fbLogger : I_EventHandlerService`; stored in `_fbEvents`. Derived modules redeclare `fbEvents` in their own `FB_Init`. Command timeout event: body calls private `ProcessCommandEvents` after `_fbCmd.Cyclic()`, which does `_fbEvents.Condition(CommandTimeoutEvent(), _fbCmd.TimedOut, %0 = _fbCmd.Last)`. Protected `CommandTimeoutEvent : INT` returns -1 (no event) by default; a module overrides it with its own enum value and configures that event with `cEv_ModuleCommandTimeout` (`16#110`).
- **Mode, not event-related, still open:** `HandleEmergencyStop` uses the old `_fbEmergencyStopMod` (should go via `_fbSafetySrv`); `ProcessInitialize` uses an undeclared `_iStateEStop`; `FB_Mode` method names (`ResetSequenceRequest`, `ResetSafetyRequest`, `SetRequest`, `InitRequest`) do not match `I_ModeRequest` (`ResetMachine`, `ResetSafety`, `UserRequest`); `I_Mode.Mode` is `E_DefaultModes` while `FB_Mode.Mode` is `USINT`.
- `GeneralEvents.gvl.st` holds the Core ID constants (`16#100..` common, `16#200..` safety). `E_EventLevels` still lives in `ToDo/Warnings and Alarms/` and must move to Core.
- Message placeholders: `%0`..`%9` (decided).
- Legacy reference: `ToDo/Warnings and Alarms/` (`F_Event_InsertInLog`, `F_EventHandler_*`) shows the old behaviour: mapping `E_EventLevels` to Hyperion levels, per-submachine counters, local + Hyperion ring buffers. The Hyperion `I_Logger` implementation must keep that functionality without the globals.

## Conventions

- **Prefixes, types:** `FB_` function block, `I_` interface, `E_` enum, `SC_` struct, `GVL_` global list, `cEv_` event ID constant, `c` constant, `F_` function. **Exception (for now): `Async` and `Await` have no prefix**, so step chains read well.
- **Prefixes, variables (Hungarian):** `x` BOOL, `i` INT/UINT, `n` USINT, `udi` UDINT, `r` REAL, `s` STRING, `e` enum, `sc` struct, `a` array (`afb`, `as`, `asc`), `fb` FB or interface reference, `p` pointer. Member variables start with `_` (`_eState`, `_fbEventSrv`).
  - The README uses `itf` for interface references (`itfEventSrv`); the code uses `fb` (`fbEventSrv : I_EventService`). Not settled yet; follow the surrounding code and point out the inconsistency when relevant.
- **Enums:** `{attribute 'qualified_only'}`, plus `{attribute 'strict'}` **except** for enums whose values are passed as `INT` (event enums used as `iEvent`, command enums used as `iCmd`): those cannot be strict. Enums used as array index end with `Count` as the last member (`ARRAY[0..E_X.Count]`). Command enums start at 1 (0 = no command).
- **State machines:** `_eState` + `ProcessState(s)()` with one `CASE` dispatching to `ProcessXxx()` methods per state.
- **Base classes** are `ABSTRACT` (`FB_Mode`, `FB_Module`, `FB_Hardware`, `FB_Application`); each has a matching interface.
- **Null checks** on interface references before use (`IF _itf <> 0 THEN`); an unregistered event must not crash.
- Indentation with tabs; `:=` aligned in declaration blocks.
- `STRING` without a length is 80 characters. Formatted log messages need an explicit length (e.g. a library constant `cMaxMessageLength`).
