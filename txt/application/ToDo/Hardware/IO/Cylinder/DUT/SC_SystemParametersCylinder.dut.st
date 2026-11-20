TYPE SC_SystemParametersCylinder:
STRUCT
	xSensorPresentPos0		: BOOL;
	xSensorPresentPos1		: BOOL;
	
	xSensorCriticalPos0		: BOOL := TRUE;
	xSensorCriticalPos1		: BOOL := TRUE;
	
	tCylinderToPos0			: TIME;
	tCylinderToPos1			: TIME;
	
	rErrorTimeoutFactor		: REAL := 1;
END_STRUCT
END_TYPE
