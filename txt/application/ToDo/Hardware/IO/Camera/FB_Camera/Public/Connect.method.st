METHOD Connect : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _xDone  THEN
	Connect := TRUE;
	RETURN;
END_IF

IF _eState = E_CameraStates.Standby THEN
	_eState := E_CameraStates.Connect;
END_IF
