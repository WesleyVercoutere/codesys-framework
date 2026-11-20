METHOD PROTECTED ProcessOff
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _xActive THEN
	_eState := E_ModeStates.Initialize;
END_IF
