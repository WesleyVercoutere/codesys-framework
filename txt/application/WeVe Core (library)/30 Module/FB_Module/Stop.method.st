METHOD Stop : BOOL

// --- BEGIN IMPLEMENTATION ---

IF _xDone THEN
	Stop := TRUE;
	RETURN;
END_IF

_eState := E_ModuleStates.Stop;
