// Basis voor alle modules.
//
// Commando's (één actief commando per module, zie FB_Command):
//   - enum per module, beginnend bij 1:  E_GripperCmd : (Open := 1, Close);   (niet strict)
//   - publieke methode per commando:
//       METHOD Close : E_CommandResult
//       Close := InvokeCommand(iCmd := E_GripperCmd.Close, tTimeout := T#2S, xStart => xStart);
//       IF xStart THEN _rForce := rForce; END_IF		// parameters enkel bij de start overnemen
//   - uitvoering: ExecuteCommand overschrijven met een CASE op iCmd,
//     en _fbCmd.Finish() of _fbCmd.Fail() aanroepen als het commando klaar is.
//   - Stop/QuickStop breken het actieve commando af (Aborted).
//   - Fire-and-forget: de aanroeper volgt op met CommandResult(iCmd).
//   - Timeout-event: CommandTimeoutEvent overschrijven (zie daar).
//
// Events: de module krijgt haar eigen EventGroup (FB_XxxEventGroup) via FB_Init(fbEvents := ...)
// en meldt via _fbEvents.Condition(...) / _fbEvents.Log(...) met de enum van de module.
// Afgeleide modules declareren fbEvents ook in hun eigen FB_Init (CODESYS geeft het door aan de basis).
FUNCTION_BLOCK ABSTRACT FB_Module IMPLEMENTS I_Module
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_eState 	: E_ModuleStates;
	_xBusy 		: BOOL;
	_xDone 		: BOOL;
	_xHomed 	: BOOL;
	_xEnabled 	: BOOL;

	_fbCmd 		: FB_Command;		// het actieve commando van deze module

	_fbEvents 	: I_EventGroup;		// EventGroup van deze module (FB_Init), mag 0 zijn
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Vóór de state machine: zo stopt een commando met timeout al in deze cyclus
_fbCmd.Cyclic();
ProcessCommandEvents();

ProcessState();
