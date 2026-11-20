TYPE SC_DigitalInputSignals :
STRUCT
	xDIRawValue 					: BOOL;
	
	xDIDetectionStateOn 			: BOOL;
	xDIDetectionStateOff 			: BOOL;
	xDIDetectionPulse01 			: BOOL;
	xDIDetectionPulse10 			: BOOL;
	
	xDIDelayedDetectionStateOn 		: BOOL;
	xDIDelayedDetectionStateOff 	: BOOL;
	xDIDelayedDetectionStateOnOff 	: BOOL;
	xDIDelayedDetectionPulse01 		: BOOL;
	xDIDelayedDetectionPulse10 		: BOOL;
	
	xDIDetectionOnDelayRunning 		: BOOL;
	xDIDetectionOffDelayRunning 	: BOOL;
END_STRUCT
END_TYPE
