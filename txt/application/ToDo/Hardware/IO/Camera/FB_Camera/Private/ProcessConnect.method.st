METHOD PRIVATE ProcessConnect
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_xBusy := TRUE;

CASE _iStateConnect OF
	
	0:  //Startup
		IF NOT _xError THEN
		   _iStateConnect := _iStateConnect + 10;
		END_IF
	
	10: //connect
		IF ConnectMethod() THEN
		   _iStateConnect := 50;
		END_IF	
	
	50 :
		_iStateConnect := 0;
		_xDone := TRUE;
		_xBusy := FALSE;
		_eState := E_CameraStates.Standby;
		
END_CASE
