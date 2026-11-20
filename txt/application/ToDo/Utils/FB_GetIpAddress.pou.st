FUNCTION_BLOCK FB_GetIpAddress
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbL_IPAP_ParameterRead		: L_IPAP_ParameterRead;
	
	_xRead 						: BOOL;
	_udiIp						: UDINT;
	_b1, _b2, _b3, _b4 			: BYTE;
	_sIp 						: STRING;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_fbL_IPAP_ParameterRead(
	xExecute		:= _xRead , 
	xAbort			:= , 
	wIndex			:= 9298,			    
	bySubIndex		:= 1,		 
	udiTimeOut		:= 1000,		 
	pDataBuffer		:= ADR(_udiIp),		
	udiBufferSize	:= SIZEOF(_udiIp),
	xDone			=> , 
	xBusy			=> , 
	xAborted		=> , 
	xError			=> , 
	eErrorId		=> , 
	udiDataRead		=> , 
	eDataType		=> 
);

IF _xRead AND _fbL_IPAP_ParameterRead.xDone THEN
	 _xRead := FALSE;
END_IF

_b1 := TO_BYTE(SHR(_udiIp, 24));
_b2 := TO_BYTE(SHR(_udiIp, 16));
_b3 := TO_BYTE(SHR(_udiIp, 8));
_b4 := TO_BYTE(_udiIp);

_sIp := '';
_sIp := CONCAT(str1 := _sIp, str2 := TO_STRING(_b4));
_sIp := CONCAT(str1 := _sIp, str2 := '.');
_sIp := CONCAT(str1 := _sIp, str2 := TO_STRING(_b3));
_sIp := CONCAT(str1 := _sIp, str2 := '.');
_sIp := CONCAT(str1 := _sIp, str2 := TO_STRING(_b2));
_sIp := CONCAT(str1 := _sIp, str2 := '.');
_sIp := CONCAT(str1 := _sIp, str2 := TO_STRING(_b1));
