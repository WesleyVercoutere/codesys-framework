// Boekhouding van één actief commando in een module. Eén commando tegelijk per module;
// een module die dingen parallel moet doen, wordt opgesplitst in submodules.
//
// Gebruik in een module:
//   - enum:              commando-id's beginnen bij 1 (0 = geen commando)
//   - body:              _fbCmd.Cyclic();  CASE _fbCmd.Active OF ... END_CASE
//   - publieke methode:  Resultaat := _fbCmd.Invoke(iCmd := ..., xAllowed := ..., tTimeout := T#3S, xStart => xStart);
//   - uitvoering klaar:  _fbCmd.Finish();  of  _fbCmd.Fail();
//   - Stop/QuickStop:    _fbCmd.Abort();  de module brengt zelf haar uitgangen in een veilige toestand
//   - timeout:           _fbEvents.Condition(iEvent := E_XxxEvents.CommandTimeout, xCondition := _fbCmd.TimedOut, ...);
//
// Timeout (vangnet per commando):
//   - tTimeout bij Invoke, T#0S = geen timeout (bv. een transportband die blijft lopen).
//   - Verlopen terwijl Busy: resultaat wordt Error, TimedOut wordt TRUE tot er een nieuw commando start.
//   - Active wordt 0, net als bij Fail: de module brengt zelf haar uitgangen in een veilige toestand
//     en meldt de oorzaak via een event. Fijnere timeouts per stap blijven in de module zelf.
//
// Regels voor de aanroeper:
//   - Invoke blijven aanroepen = pollen: Busy, Busy, ..., dan 1x het eindresultaat (Done/Error/Aborted).
//   - Daarna start de volgende Invoke van hetzelfde commando het opnieuw.
//   - Maximaal 1x per cyclus aanroepen en verder gaan zodra er een eindresultaat is (zoals Await doet).
//   - Afvuren en later opvolgen: 1x Invoke (Async), daarna ResultOf() lezen. ResultOf start nooit iets
//     en toont het resultaat tot er een nieuw commando start.
FUNCTION_BLOCK FB_Command
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_iActive 		: INT;				// huidig/laatste commando, 0 = geen
	_eResult 		: E_CommandResult;	// resultaat van _iActive
	_xPolled 		: BOOL;				// Invoke aangeroepen deze cyclus
	_xPolledPrev 	: BOOL;				// Invoke aangeroepen vorige cyclus
	_xDelivered 	: BOOL;				// eindresultaat al afgeleverd via Invoke
	_tTimeout 		: TIME;				// timeout van _iActive, T#0S = geen
	_fbTimeout 		: TON;
	_xTimedOut 		: BOOL;				// _iActive is gefaald door de timeout
END_VAR

// --- BEGIN IMPLEMENTATION ---

