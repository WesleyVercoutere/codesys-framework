// Eén regel in de buffer van een logger.
TYPE SC_LogEntry :
STRUCT
	sTimeStamp 		: STRING(23);
	udiCounter 		: UDINT;
	eLevel 			: E_EventLevels;
	sMessage 		: STRING(GVL_Logger.cMaxMessageLength);
END_STRUCT
END_TYPE
