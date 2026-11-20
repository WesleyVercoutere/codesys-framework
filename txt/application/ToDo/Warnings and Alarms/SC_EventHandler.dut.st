TYPE SC_EventHandler :
STRUCT
	scEventConfig 					: SC_EventConfig;
	eEventLevel 					: E_EventLevels;
	xEvent_WarningIsActive 			: BOOL;
	xEvent_AlarmIsActive 			: BOOL;
	xEvent_WarningInsertedInLog 	: BOOL;
	xEvent_AlarmInsertedInLog 		: BOOL;
END_STRUCT
END_TYPE
