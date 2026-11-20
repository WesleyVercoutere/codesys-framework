METHOD Disconnect : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _xDone  THEN
	Disconnect := TRUE;
	RETURN;
END_IF

IF _eState = E_CameraStates.Standby THEN
	_eState := E_CameraStates.Disconnect;
END_IF
