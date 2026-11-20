// Het actieve commando afbreken (Stop, QuickStop, mode-wissel).
METHOD Abort
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _eResult = E_CommandResult.Busy THEN
	_eResult := E_CommandResult.Aborted;
END_IF
