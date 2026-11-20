METHOD PRIVATE ProcessDisconnect
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_xBusy := TRUE;

CASE _iStateDisconnect OF
	
	0:  //Startup
		IF NOT _xError THEN
		   _iStateDisconnect := _iStateDisconnect + 10;
		END_IF
	
	10: //Init connection
		_clientRead.xEnable := FALSE;
		_clientWrite.xEnable := FALSE;
		
		//No active connections
		IF NOT _clientRead.xActive AND NOT _clientWrite.xActive THEN
		   _iStateDisconnect := _iStateDisconnect + 10;
		END_IF
	
	20 :
		_iStateDisconnect := 0;
		_xDone := TRUE;
		_xBusy := FALSE;
		_eState := E_CameraStates.Standby;
		
		
END_CASE
