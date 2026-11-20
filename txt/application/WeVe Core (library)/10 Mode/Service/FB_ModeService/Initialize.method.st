METHOD Initialize
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_nActiveMode := E_DefaultModes.Auto;

IF _afbModes[_nActiveMode] <> 0 THEN
	_afbModes[_nActiveMode].State := E_ModeStates.Off;
END_IF

