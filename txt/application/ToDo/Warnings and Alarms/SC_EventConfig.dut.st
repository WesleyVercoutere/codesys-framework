TYPE SC_EventConfig :
STRUCT
	udiEventID 						: UDINT;
	eSubMachine 					: INT;
	xEventIsDisabled 				: BOOL := FALSE;
	eEventLevel_InCaseOfWarning 	: E_EventLevels;
	eEventLevel_InCaseOfAlarm 		: E_EventLevels;
END_STRUCT
END_TYPE
