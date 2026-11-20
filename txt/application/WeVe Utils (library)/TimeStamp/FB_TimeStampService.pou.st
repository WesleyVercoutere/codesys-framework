FUNCTION_BLOCK FB_TimeStampService IMPLEMENTS I_TimeStampService

VAR
	//Parameter R/W
	_fbL_IPAP_ParameterRead			: L_IPAP_ParameterRead;
	_wReadParameterState			: WORD;
	_xReadParameter					: BOOL;
	
	_fbL_IPAP_ParameterWrite		: L_IPAP_ParameterWrite;
	_wWriteParameterState			: WORD;
	_xWriteParameter				: BOOL;
	
	//Read System Time
	_fbGetSystemTime_UTC 			: RTCLK.GetDateAndTime;
	_dtSystemTime_UTC 				: DATE_AND_TIME;
	_xGetSystemTime 				: BOOL;		
	_sTimeStamp_UTC_AsString		: STRING(23);
	_xTimeStampStringCreated		: BOOL;	
	                            	
	//Read Local Time           	
	_dtRead							: DT; // date and time: current value
	_uliParRead						: ULINT; // date and time: value received from fb L_IPAP_ParameterRead1
	_sTimeStamp_Local_AsString		: STRING(23);
                                	
	//Set System Time           	
	_dtSetDateAndTime 				: DATE_AND_TIME;
	_eError 						: DTU.ERROR;
	
	//States
	_wForceNTPTimeSyncState 		: WORD;

END_VAR

// --- BEGIN IMPLEMENTATION ---

GetSystemTime_UTC();
GetLocalTime();
