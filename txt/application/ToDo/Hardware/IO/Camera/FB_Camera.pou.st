FUNCTION_BLOCK FB_Camera IMPLEMENTS I_Camera
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_scSysPar 				: SC_SystemParametersVisuCamera;
	
	_eState 				: E_CameraStates;
	_xBusy 					: BOOL;
	_xDone 					: BOOL;
	_xError 				: BOOL;
	_iErrorId 				: UINT;
	_sError 				: STRING;
	
	_read 	  				: NBS.TCP_Read; 
	_write		 			: NBS.TCP_Write;
	_writeFeedBack 			: NBS.TCP_Read; 
	
	_clientState			: NBS.TCP_Client;
	_clientRead        		: NBS.TCP_Client;
	_clientWrite			: NBS.TCP_Client;
	
	_tonMonitor 			: TON;
	_tonPicture 			: TON;
	_tonSelectJob 			: TON;
	
	_xConnected 			: BOOL;
	
	_iStateMonitor 			: UINT;
	_iStateConnect 			: UINT;
	_iStateSetJob 			: UINT;
	_iStateTakePicture 		: UINT;
	_iStateConnectMethod 	: UINT;
	_iStateDisconnect 		: UINT;
	
	_sJob 					: STRING;
	_sPicture 				: STRING;
	_sFeedBack 				: STRING;
	_id 					: UINT;
	
	_sResult 				: STRING(280);
	_sResultPrev			: STRING(280);
	_sPictureId				: STRING;
END_VAR

// --- BEGIN IMPLEMENTATION ---

Monitor();

ProcessFBs();
ProcessState();
