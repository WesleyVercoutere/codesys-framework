TYPE SC_Event :
STRUCT
	udiEventId 			: UDINT;
	nSubMachine 		: USINT;
	nSubMachineId 		: USINT;
	eEventLevel 		: E_EventLevels;
	xResetable 			: BOOL;		// TRUE = blijft actief tot Reset(), ook als de conditie weg is
	sMessage 			: STRING(GVL_Logger.cMaxMessageLength) := '';	// placeholders %0..%9
END_STRUCT
END_TYPE
