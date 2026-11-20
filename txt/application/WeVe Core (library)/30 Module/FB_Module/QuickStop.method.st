METHOD QuickStop : BOOL

// --- BEGIN IMPLEMENTATION ---

IF _xDone THEN
	QuickStop := TRUE;
	RETURN;
END_IF

_eState := E_ModuleStates.QuickStop;
