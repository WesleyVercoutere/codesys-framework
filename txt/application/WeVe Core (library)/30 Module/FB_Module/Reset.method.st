METHOD Reset : BOOL

// --- BEGIN IMPLEMENTATION ---

IF _xDone THEN
	Reset := TRUE;
	RETURN;
END_IF

_eState := E_ModuleStates.Reset;
