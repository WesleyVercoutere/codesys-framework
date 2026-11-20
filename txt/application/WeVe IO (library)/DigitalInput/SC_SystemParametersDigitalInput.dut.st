TYPE SC_SystemParametersDigitalInput :
STRUCT
	eSysPar_DI_SensorType 				: E_DigitalInputSensorType;
	tSysPar_Detection_OnDelay 			: TIME; // msec
	tSysPar_Detection_OffDelay 			: TIME; // msec
	
	tSysPar_Detection_OnDelayOnOff 		: TIME; // msec
	tSysPar_Detection_OffDelayOnOff 	: TIME; // msec
END_STRUCT
END_TYPE
