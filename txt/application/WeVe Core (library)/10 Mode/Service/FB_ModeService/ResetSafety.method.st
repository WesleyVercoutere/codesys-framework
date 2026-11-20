METHOD ResetSafety : BOOL

// --- BEGIN IMPLEMENTATION ---

IF _afbModes[_nActiveMode] <> 0 THEN
	_afbModes[_nActiveMode].ResetSafety();
END_IF