// Door de publieke commando-methodes van de afgeleide module.
// Start het commando als de module klaar is (Standby), of geeft de status terug als het al loopt.
// Bij de start gaat de module naar Execute; xStart is dan 1 cyclus TRUE: neem de parameters over.
METHOD PROTECTED InvokeCommand : E_CommandResult
VAR_INPUT
	iCmd 		: INT;				// commando-id uit de enum van de module, > 0
	tTimeout 	: TIME := T#0S;		// max duur van het commando, T#0S = geen timeout
END_VAR
VAR_OUTPUT
	xStart 		: BOOL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

InvokeCommand := _fbCmd.Invoke(
	iCmd 		:= iCmd,
	xAllowed 	:= _eState = E_ModuleStates.Standby OR _eState = E_ModuleStates.Execute,
	tTimeout 	:= tTimeout,
	xStart 		=> xStart);

IF xStart THEN
	_eState := E_ModuleStates.Execute;
END_IF
