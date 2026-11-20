METHOD PRIVATE WriteParameter : E_TaskStatus
VAR_INPUT
	wIndex				: WORD;
	bySubIndex			: BYTE;
	udiTimeOut			: UDINT;
	pDataBuffer			: POINTER TO BYTE;
	udiDataSize			: UDINT; 
END_VAR

// --- BEGIN IMPLEMENTATION ---

WriteParameter := E_TaskStatus.Busy;

_fbL_IPAP_ParameterWrite(
	xExecute	:=_xWriteParameter, 
	xAbort		:= , 
	wIndex		:= wIndex, 
	bySubIndex	:= bySubIndex, 
	udiTimeOut	:= udiTimeOut, 
	pDataBuffer	:= pDataBuffer, 
	udiDataSize	:= udiDataSize, 
	xDone		=> , 
	xBusy		=> , 
	xAborted	=> , 
	xError		=> , 
	eErrorId	=> 
);
	
CASE _wWriteParameterState OF
	
	0 : 
		_xWriteParameter   := TRUE;
		_wWriteParameterState := _wWriteParameterState + 10;
		
		
	10:
		IF _fbL_IPAP_ParameterWrite.xDone THEN
			_xWriteParameter := FALSE;
			_wWriteParameterState := _wWriteParameterState + 10;
		END_IF
		
		IF _fbL_IPAP_ParameterWrite.xError THEN
			_xWriteParameter := FALSE;
			_wWriteParameterState := 100;
		END_IF
		
		
	20:
		//Extra state to disable the FB
		_wWriteParameterState := 0;	
		WriteParameter := E_TaskStatus.Successful;
		
		
	100:
		_wWriteParameterState := 0;	
		WriteParameter := E_TaskStatus.Failed;
		
END_CASE
