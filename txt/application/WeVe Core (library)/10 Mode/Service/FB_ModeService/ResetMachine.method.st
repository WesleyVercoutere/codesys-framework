METHOD ResetMachine : BOOL

// --- BEGIN IMPLEMENTATION ---

IF _afbModes[_nActiveMode] <> 0 THEN
	_afbModes[_nActiveMode].ResetMachine();
END_IF