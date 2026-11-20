METHOD PRIVATE Monitor
VAR_INPUT
END_VAR
VAR_INST
	uiConnectionAttempts	: UINT;
	uiMaxConnectionAttempts	: UINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

uiMaxConnectionAttempts	:= 5;

CASE _iStateMonitor OF
	
	0 :	//Startup
		IF NOT _xError THEN
 		   _iStateMonitor := _iStateMonitor + 10;
		END_IF
		
		
	10 :  //Init timer
		uiConnectionAttempts	:= uiConnectionAttempts + 1;
		_tonMonitor.IN := FALSE;
		//Init connection
		_clientState.xEnable := FALSE;
		
		//Timer inactive and no active connection
		IF NOT _tonMonitor.Q AND NOT _clientState.xActive THEN
			IF _clientRead.xActive AND _clientWrite.xActive THEN
		   	   _iStateMonitor := _iStateMonitor + 10;
			END_IF
		END_IF
	
	20: //Make connection
		_clientState.xEnable := TRUE;
		
		//Active connection
		IF _clientState.xActive AND NOT _clientState.xError THEN
		   _iStateMonitor := _iStateMonitor + 10;
		END_IF
		//Error
		IF _clientState.xError THEN
		   _iStateMonitor := 1000;	
		END_IF
		
	30: //Recheck
		_tonMonitor.IN := TRUE;
		//Init connection
		_clientState.xEnable := FALSE;
		//Connected
		_xConnected := TRUE;
		
		uiConnectionAttempts := 0;
		
		//error
		IF _tonMonitor.Q THEN
			_iStateMonitor := 0;
		END_IF
		
  1000: //Error
		_xError := _clientState.xError;
		_iErrorId := 0;
		_sError := CONCAT(_scSysPar.adress.sAddr,': CAMERA NO CONNECTION');
		_iStateMonitor := 1100;
	
  1100: //Init connected -> wait for reset
  		IF	uiConnectionAttempts < uiMaxConnectionAttempts
		THEN
			_xError := FALSE;
			_iStateMonitor := 0;
		END_IF
		_xConnected := FALSE;
		
END_CASE
