// 1x per cyclus aanroepen in de body van de module, vóór de uitvoering.
// Bij een timeout wordt het commando hier al Error, zodat de uitvoering in dezelfde cyclus stopt.
METHOD Cyclic
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_xPolledPrev := _xPolled;
_xPolled := FALSE;

// Timeout: timer loopt enkel zolang het commando Busy is en er een timeout is ingesteld
_fbTimeout(IN := _eResult = E_CommandResult.Busy AND _tTimeout > T#0S, PT := _tTimeout);

IF _fbTimeout.Q THEN
	_eResult := E_CommandResult.Error;
	_xTimedOut := TRUE;
END_IF
