// Config van één event invullen. De bron (nSubMachine, nSubMachineId) komt van de groep,
// zodat elke instantie van een module zijn eigen bron heeft met dezelfde event-ID's.
// FALSE bij een ongeldige index.
METHOD PROTECTED Configure : BOOL
VAR_INPUT
	iEvent 			: INT;
	udiEventId 		: UDINT;
	eEventLevel 	: E_EventLevels;
	xResetable 		: BOOL;
	sMessage 		: STRING(GVL_Logger.cMaxMessageLength);		// placeholders %0..%9
END_VAR
VAR
	fbEvent 		: I_Event;
	scConfig 		: SC_Event;
END_VAR

// --- BEGIN IMPLEMENTATION ---

fbEvent := GetEvent(iEvent);

IF fbEvent = 0 THEN
	Configure := FALSE;
	RETURN;
END_IF

scConfig.udiEventId 	:= udiEventId;
scConfig.nSubMachine 	:= _nSubMachine;
scConfig.nSubMachineId 	:= _nSubMachineId;
scConfig.eEventLevel 	:= eEventLevel;
scConfig.xResetable 	:= xResetable;
scConfig.sMessage 		:= sMessage;

fbEvent.Config := scConfig;
Configure := TRUE;
