// Door de module: het actieve commando is goed afgewerkt.
METHOD Finish
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _eResult = E_CommandResult.Busy THEN
	_eResult := E_CommandResult.Done;
END_IF
