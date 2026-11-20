METHOD InitRequest

// --- BEGIN IMPLEMENTATION ---

IF _eState = E_ModeStates.Standby THEN
	_eState := E_ModeStates.Initialize;
END_IF
