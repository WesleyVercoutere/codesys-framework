FUNCTION_BLOCK FB_GeneralInputsController
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbUserRequest 			: I_UserRequestModule;
	_fbSignalLamp 			: I_SignalLampModule;
	_fbEmergencyStop 		: I_EmergencyStopModule;
	
	(* General inputs *)
	_xBtnEmergencyStop 		: BOOL;
	_btnStart 				: FB_VisuButtonTrigger;
	_btnStop 				: FB_VisuButtonTrigger;
	_btnReset 				: FB_VisuButtonTrigger;
	
	_tonDelayedStop 		: TON;
	_rtrigDelayedStop 		: R_TRIG;
	
	
	_xBtnSimulation 		: BOOL;
	
	_xEmergencyBtnState 	: BOOL;
	
	_scSignalLamp 			: SC_SignalLamp;
	_xSignalLightStartBtn 	: BOOL;
	_xSignalLightResetBtn 	: BOOL;
	_xSignalLightGreen 		: BOOL;
	_xSignalLightOrange 	: BOOL;
	_xSignalLightRed 		: BOOL;
	
	_iStopCounter 			: UINT;
	_tonCounter 			: TON;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_btnStart();

IF _btnStart.RQ THEN
	_fbUserRequest.Start(sSource := 'Visu');
END_IF

_btnStop();

IF _btnStop.RQ THEN
	_fbUserRequest.Stop(sSource := 'Visu');
	_iStopCounter := _iStopCounter + 1;
END_IF

_tonCounter(IN := _iStopCounter > 0, PT := T#500MS);

IF _tonCounter.Q THEN
	_iStopCounter := 0;
END_IF

IF _iStopCounter >= 2 THEN
	_fbUserRequest.QuickStop();
END_IF

_tonDelayedStop(IN := _btnStop.State, PT := cStopDelayTime);
_rtrigDelayedStop(CLK := _tonDelayedStop.Q);

IF _rtrigDelayedStop.Q THEN
	_fbUserRequest.ResetSequence(sSource := 'Visu');
END_IF

_btnReset();

IF _btnReset.RQ THEN
	_fbUserRequest.ResetSafety(sSource := 'Visu');
END_IF

_xEmergencyBtnState := FALSE;

IF _fbEmergencyStop.State = E_EmergencyStopState.NOK THEN
	_xEmergencyBtnState := TRUE;
END_IF

_scSignalLamp := _fbSignalLamp.SignalLamp;

_xSignalLightStartBtn 	:= _scSignalLamp.xStartBtn;
_xSignalLightResetBtn 	:= _scSignalLamp.xResetBtn;
_xSignalLightGreen 		:= _scSignalLamp.xGreen;
_xSignalLightOrange 	:= _scSignalLamp.xOrange;
_xSignalLightRed 		:= _scSignalLamp.xRed;
