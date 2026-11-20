METHOD Disable : BOOL

// --- BEGIN IMPLEMENTATION ---

IF NOT _xEnabled THEN
	Disable := TRUE;
	RETURN;
END_IF

IF _eState = E_ModuleStates.Standby THEN
	_eState := E_ModuleStates.Disable;
END_IF
