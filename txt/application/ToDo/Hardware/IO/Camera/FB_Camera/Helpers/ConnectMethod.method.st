METHOD PUBLIC ConnectMethod : BOOL
VAR_INPUT
END_VAR

VAR_INST
	uiConnectionAttempts	: UINT;
	uiMaxConnectionAttempts	: UINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

uiMaxConnectionAttempts	:= 5;

CASE _iStateConnectMethod OF
	
	0:  //Startup
		IF NOT _xError THEN
		   _iStateConnectMethod := _iStateConnectMethod + 10;
		END_IF
	
	10: //Init connection
		uiConnectionAttempts	:= uiConnectionAttempts + 1;
	
		IF _clientRead.xActive AND  _clientWrite.xActive THEN
			_iStateConnectMethod := 40;
		ELSE	
			_clientRead.xEnable := FALSE;
			_clientWrite.xEnable := FALSE;
			
			//No active connections
			IF NOT _clientRead.xActive AND NOT _clientWrite.xActive THEN
			   _iStateConnectMethod := _iStateConnectMethod + 10;
			END_IF
		END_IF
		
	20: //Make read connection	
		_clientRead.xEnable := TRUE;
		
		//Active error
		IF _xError THEN
		   _iStateConnectMethod := 1100;
		END_IF
		//Active connection
		IF _clientRead.xActive AND NOT _clientRead.xError THEN
		   _iStateConnectMethod := _iStateConnectMethod + 10;
		END_IF
		//Error
		IF _clientRead.xError THEN
		   _iStateConnectMethod := 1000;	
		END_IF
		
	30: //Make write connection
		_clientRead.xEnable := TRUE;	
		_clientWrite.xEnable := TRUE;
		
		//Active error
		IF _xError THEN
		   _iStateConnectMethod := 1100;
		END_IF
		//Active connection
		IF _clientWrite.xActive AND NOT _clientWrite.xError THEN
		   _iStateConnectMethod := _iStateConnectMethod + 10;
		END_IF
		//Error
		IF _clientWrite.xError THEN
		   _iStateConnectMethod := 1010;	
		END_IF
	
	40: //Hold connections
		_clientRead.xEnable := TRUE;	
		_clientWrite.xEnable := TRUE;
		
		//Active error
		IF _xError THEN
		   _iStateConnectMethod := 1100;
		END_IF
		//Error
		IF _clientRead.xError THEN
		   _iStateConnectMethod := 1000;	
		END_IF
		//Error
		IF _clientWrite.xError THEN
		   _iStateConnectMethod := 1010;	
		END_IF
		
		_iStateConnectMethod := _iStateConnectMethod + 10;
		
		
	50 :
		_iStateConnectMethod :=0;
		uiConnectionAttempts := 0;
		ConnectMethod := TRUE;
		RETURN;
		
  1000: //Error
		_xError := _clientRead.xError;
		_iErrorId := 0;
		_sError := CONCAT(_scSysPar.adress.sAddr,': CAMERA ERROR MAKING READ CONNECTION');
		_iStateConnectMethod := 1100;

  1010: //Error
		_xError := _clientWrite.xError;
		_iErrorId := 0;
		_sError := CONCAT(_scSysPar.adress.sAddr,': CAMERA ERROR MAKING WRITE CONNECTION');
		_iStateConnectMethod := 1100;
		
  1100: //Wait for reset	
  		IF	uiConnectionAttempts < uiMaxConnectionAttempts
		THEN
			_xError := FALSE;
		END_IF
  		
		IF NOT _xError THEN
		   _iStateConnectMethod := 0;
		END_IF	

END_CASE
