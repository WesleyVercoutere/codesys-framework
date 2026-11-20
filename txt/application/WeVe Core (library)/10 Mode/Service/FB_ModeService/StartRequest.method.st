METHOD StartRequest

// --- BEGIN IMPLEMENTATION ---

IF _afbModes[_nActiveMode] <> 0 THEN
	_afbModes[_nActiveMode].StartRequest();
END_IF
