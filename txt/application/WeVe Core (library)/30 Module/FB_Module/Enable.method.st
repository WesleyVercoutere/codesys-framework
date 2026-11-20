METHOD Enable : BOOL

// --- BEGIN IMPLEMENTATION ---

IF _xEnabled THEN
	Enable := TRUE;
	RETURN;
END_IF

IF _eState = E_ModuleStates.Idle THEN
	_eState := E_ModuleStates.Enable;
END_IF
