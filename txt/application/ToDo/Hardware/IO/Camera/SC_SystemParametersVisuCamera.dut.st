TYPE SC_SystemParametersVisuCamera :
STRUCT
	adress 			: NBS.IP_ADDR;
	conTimeout 		: UDINT;
	readPort 		: UINT;
	writePort 		: UINT;
	cycleTime 		: TIME;
	monitorTime 	: TIME;
	shutterTime 	: TIME;
	readTimeout 	: TIME;
	jobTimeout 		: TIME;
END_STRUCT
END_TYPE
