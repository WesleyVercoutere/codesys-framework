METHOD ResetEvents : BOOL

// --- BEGIN IMPLEMENTATION ---

IF _afbModes[_nActiveMode] <> 0 THEN
	_afbModes[_nActiveMode].ResetEvents();
END_IF