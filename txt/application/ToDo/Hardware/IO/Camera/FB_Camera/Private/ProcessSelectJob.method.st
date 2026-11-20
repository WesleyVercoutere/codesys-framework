METHOD PRIVATE ProcessSelectJob
VAR_INPUT
END_VAR
VAR
	result : STRING;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_xBusy := TRUE;

CASE _iStateSetJob OF
	
	0 :
		_sJob := 'CJP00';
		_sJob := CONCAT('CJP00', UINT_TO_STRING(_id));
		_write.szSize := SIZEOF(_sJob);
		_write.pData := ADR(_sJob);
		_write.xExecute := TRUE;
		_tonSelectJob.IN := FALSE;
		
		_iStateSetJob := _iStateSetJob + 10;	
	
		
	10 :
		_tonSelectJob.IN := TRUE;
		result := CONCAT('CJPPT00', UINT_TO_STRING(_id));
		
		IF _sFeedBack = result THEN
			_sFeedBack := '';
			_write.xExecute := FALSE;
			
			_xDone := TRUE;
			_eState := E_CameraStates.Standby;
			_iStateSetJob := 0;
		END_IF
		
		IF _tonSelectJob.Q THEN
			_iStateSetJob := 100;
		END_IF

		
	100 :
		_write.xExecute := FALSE;
		_iStateSetJob := _iStateSetJob + 10;
		
		
	110 :
		_iStateSetJob := 0;
	
	
END_CASE
