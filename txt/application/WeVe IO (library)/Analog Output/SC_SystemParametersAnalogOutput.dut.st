TYPE SC_SystemParametersAnalogOutput :
STRUCT
	eSysPar_AO_Type 								: E_AnalogOutputType;
	eSignalEngUnit 									: E_EngineeringUnits;
	iSysPar_SignalValue_Raw_atAnalogMinLevel 		: INT 	:= 0;
	iSysPar_SignalValue_Raw_atAnalogMaxLevel 		: INT 	:= 16384;
	rSysPar_SignalValue_EngUnit_atAnalogMinLevel 	: REAL;
	rSysPar_SignalValue_EngUnit_atAnalogMaxLevel 	: REAL;
END_STRUCT
END_TYPE
