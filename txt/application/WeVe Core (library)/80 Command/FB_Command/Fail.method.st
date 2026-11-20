// Door de module: het actieve commando is gefaald. De module meldt zelf de oorzaak.
METHOD Fail
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _eResult = E_CommandResult.Busy THEN
	_eResult := E_CommandResult.Error;
END_IF
