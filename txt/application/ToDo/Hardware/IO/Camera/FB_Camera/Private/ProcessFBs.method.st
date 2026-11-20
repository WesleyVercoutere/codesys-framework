METHOD PRIVATE ProcessFBs
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_clientRead(ipAddr := _scSysPar.adress,uiPort := _scSysPar.readPort,udiTimeOut := _scSysPar.conTimeout);
_clientWrite(ipAddr := _scSysPar.adress,uiPort := _scSysPar.writePort,udiTimeOut := _scSysPar.conTimeout);
_clientState(ipAddr := _scSysPar.adress,uiPort := _scSysPar.writePort,udiTimeOut := _scSysPar.conTimeout);


_read(
	xEnable:= _clientRead.xActive, 
	xDone=> , 
	xBusy=> , 
	xError=> , 
	hConnection:= _clientRead.hConnection, 
	szSize:= SIZEOF(_sResult), 
	pData:= ADR(_sResult), 
	eError=> , 
	xReady=> , 
	szCount=> 
);
	
_write(
	xExecute:= , 
	udiTimeOut:= , 
	xDone=> , 
	xBusy=> , 
	xError=> , 
	hConnection:= _clientWrite.hConnection, 
	szSize:= , 
	pData:= , 
	eError=> 
);

_writeFeedBack(
	xEnable:= _clientWrite.xActive, 
	xDone=> , 
	xBusy=> , 
	xError=> , 
	hConnection:= _clientWrite.hConnection, 
	szSize:= SIZEOF(_sFeedBack), 
	pData:= ADR(_sFeedBack), 
	eError=> , 
	xReady=> , 
	szCount=> 
);


_tonMonitor(PT := _scSysPar.monitorTime);
_tonPicture(PT := _scSysPar.readTimeout);
_tonSelectJob(PT := _scSysPar.jobTimeout);
