TYPE SC_SystemParametersAnalogInput :
STRUCT
	eAI_Type	 							: E_AnalogInputType;
	eSignalEngUnit 							: E_EngineeringUnits;
	rSignalValueEngUnit_AnalogMinLevel 		: REAL;
	rSignalValueEngUnit_AnalogMaxLevel 		: REAL;
	rSignalValueEngUnit_atAnalogMinLevel 	: REAL;
	rSignalValueEngUnit_atAnalogMaxLevel 	: REAL;
END_STRUCT
END_TYPE
