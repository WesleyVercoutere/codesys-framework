FUNCTION_BLOCK FB_ModeController
VAR_INPUT
	pOpModeSrv 				: POINTER TO FB_ModeService;  
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbOpModeSrv 			: I_ModeService;
	_fbLogger 				: I_EventHandlerService;
	
	_btnRequestAutomatic 	: FB_VisuButtonTrigger;
	_btnRequestManual 		: FB_VisuButtonTrigger;
	_btnRequestMaintenance 	: FB_VisuButtonTrigger;
	_btnRequestTest 		: FB_VisuButtonTrigger;
	
	_ascMessages 			: ARRAY[1..cNbrOfLogMessages] OF SC_LogMessage;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_btnRequestAutomatic();
_btnRequestManual();
_btnRequestMaintenance();
_btnRequestTest();


IF _btnRequestAutomatic.RQ THEN
	_fbOpModeSrv.RequestMode(eMode := E_DefaultModes.Auto);
END_IF

IF _btnRequestManual.RQ THEN
	_fbOpModeSrv.RequestMode(eMode := E_DefaultModes.Manual);
END_IF

IF _btnRequestMaintenance.RQ THEN
	_fbOpModeSrv.RequestMode(eMode := E_DefaultModes.Maintenance);
END_IF

IF _btnRequestTest.RQ THEN
	_fbOpModeSrv.RequestMode(eMode := E_DefaultModes.UserDefined1);
END_IF

_ascMessages := _fbLogger.GetMessages();
