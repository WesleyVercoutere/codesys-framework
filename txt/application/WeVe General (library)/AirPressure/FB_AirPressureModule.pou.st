FUNCTION_BLOCK FB_AirPressureModule IMPLEMENTS I_AirPressureModule
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbLogger 		: I_EventHandlerService;
	_fbHw 			: I_AirPressureHardware;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF NOT _fbHw.AirPressureOk THEN

	_fbLogger.RaiseEvent(
		udiEventId 			:= cEv_MainPressureNotOk,
		eSubMachine 		:= 0,
		iSubMachineId 		:= 0,
		eEventLevel 		:= E_EventLevels.EventIsAlarm_SupervisorLevel,
		xAddToList 			:= TRUE,
		sMessage 			:= 'Invalid air pressure'
	);

END_IF

