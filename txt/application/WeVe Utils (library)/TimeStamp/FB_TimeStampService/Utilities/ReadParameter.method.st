METHOD PRIVATE ReadParameter : E_TaskStatus
VAR_INPUT
	wIndex				: WORD;
	bySubIndex			: BYTE;
	udiTimeOut			: UDINT;
	pDataBuffer			: POINTER TO BYTE;
	udiBufferSize		: UDINT; 
END_VAR

// --- BEGIN IMPLEMENTATION ---

ReadParameter := E_TaskStatus.Busy;

_fbL_IPAP_ParameterRead(
	xExecute		:=_xReadparameter , 
	xAbort			:= , 
	wIndex			:= wIndex,			    
	bySubIndex		:= bySubIndex,		 
	udiTimeOut		:= udiTimeOut,		 
	pDataBuffer		:= pDataBuffer,		
	udiBufferSize	:= udiBufferSize,
	xDone			=> , 
	xBusy			=> , 
	xAborted		=> , 
	xError			=> , 
	eErrorId		=> , 
	udiDataRead		=> , 
	eDataType		=> 
);

// Get LocalTime
CASE _wReadParameterState OF
	
	0 : 
		_xReadparameter := TRUE;
		_wReadParameterState := _wReadParameterState + 10;
		
		
	10:
		IF _fbL_IPAP_ParameterRead.xDone THEN
			_wReadParameterState := _wReadParameterState + 10;
		END_IF
		
		IF _fbL_IPAP_ParameterRead.xError THEN
			_xReadparameter := FALSE;
			_wReadParameterState := 100;
		END_IF
		
		
	20:
		_xReadparameter := FALSE;
		_wReadParameterState := _wReadParameterState + 10;
		
		
	30:
		//Extra state to disable the FB
		_wReadParameterState := 0;	
		ReadParameter := E_TaskStatus.Successful;
		
		
	100:
		_wReadParameterState := 0;	
		ReadParameter := E_TaskStatus.Failed;
		
END_CASE
