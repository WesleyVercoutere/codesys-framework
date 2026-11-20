METHOD Initialize
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_xBusy := FALSE;
_xDone := FALSE;
_xError := FALSE;
_iErrorId := 0;
_sError := '';
_xConnected := FALSE;
_iStateMonitor := 0;
_iStateConnect := 0;
_iStateSetJob := 0;
_iStateTakePicture := 0;
_iStateConnectMethod := 0;
_iStateDisconnect := 0;

_sFeedBack := '';
_sJob := '';
_sPicture := '';
_id := 0;

_tonPicture.IN := FALSE;
_write.xExecute := FALSE;
_tonSelectJob.IN := FALSE;

_eState := E_CameraStates.Connect;
