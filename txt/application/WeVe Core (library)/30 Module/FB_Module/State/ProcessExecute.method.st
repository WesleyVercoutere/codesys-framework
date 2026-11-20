METHOD PROTECTED ProcessExecute
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Commando klaar, gefaald, afgebroken of timeout: terug naar Standby
IF _fbCmd.Active = 0 THEN
	_xBusy := FALSE;
	_eState := E_ModuleStates.Standby;
	RETURN;
END_IF

_xBusy := TRUE;
ExecuteCommand(iCmd := _fbCmd.Active);
