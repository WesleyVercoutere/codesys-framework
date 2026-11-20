METHOD SetJob : BOOL
VAR_INPUT
	id 		: UINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _xDone  THEN
	SetJob := TRUE;
	RETURN;
END_IF

IF _eState = E_CameraStates.Standby THEN
	_id := id;
	_eState := E_CameraStates.SelectJob;
END_IF
