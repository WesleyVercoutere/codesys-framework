VAR_GLOBAL CONSTANT
	
	cEv_Bookmark 								: DWORD := 16#00000000;

// [16#00000100 .. 16#000001FF] - Common	
	cEv_PlcFirstCycleTask 						: UDINT := 16#00000100;
	cEv_MainPressureNotOk 						: UDINT := 16#00000101;
	                                                                   
	cEv_ParameterUpdateRequest 					: UDINT := 16#00000102;
	cEv_ParameterUpdateNotAllowed 				: UDINT := 16#00000103;
	cEv_ParameterUpdateSucceeded 				: UDINT := 16#00000104;
	cEv_ParameterUpdateFailed 					: UDINT := 16#00000105;

	cEv_StartRequest 							: UDINT := 16#00000106;
	cEv_StopRequest 							: UDINT := 16#00000107;
	cEv_ResetRequest							: UDINT := 16#00000108;
	cEv_UserRequest								: UDINT := 16#00000109;
	cEv_StartRequestInvalid  					: UDINT := 16#0000010A;
	cEv_StopRequestInvalid  					: UDINT := 16#0000010B;
	cEv_ResetRequestInvalid  					: UDINT := 16#0000010C;
	cEv_UserRequestInvalid  					: UDINT := 16#0000010D;

	cEv_ModeRequest 							: UDINT := 16#0000010E;	
	cEv_ModeRequestInvalid 						: UDINT := 16#0000010F;	

// Module
	cEv_ModuleCommandTimeout 					: UDINT := 16#00000110;
	

// [16#00000200 - 16#000002FF] - Common	Safety
	cEv_SafetyNotOk 							: UDINT := 16#00000200;
	cEv_EmergencyStopActive 					: UDINT := 16#00000201;
	
END_VAR
