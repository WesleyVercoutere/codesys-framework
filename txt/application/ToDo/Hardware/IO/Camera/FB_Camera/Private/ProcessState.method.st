METHOD PRIVATE ProcessState
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

CASE _eState OF
	
	E_CameraStates.None				: ;
	E_CameraStates.Invalid 			: _eState := E_CameraStates.Initialize;
	E_CameraStates.Initialize 		: Initialize();
	E_CameraStates.Connect 			: ProcessConnect();
	E_CameraStates.Disconnect 		: ProcessDisconnect();
	E_CameraStates.Standby 			: _xDone := FALSE; _xBusy := FALSE;
	E_CameraStates.SelectJob 		: ProcessSelectJob();
	E_CameraStates.TakePicture 		: ProcessTakePictureTRX();
	E_CameraStates.Reset 			: ProcessDisconnect();

END_CASE
