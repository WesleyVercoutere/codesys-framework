FUNCTION_BLOCK ABSTRACT FB_Mode IMPLEMENTS I_Mode
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbEventSrv 			: I_EventService;	// alarmen van de hele machine
	_fbSafetySrv 			: I_SafetyService;
	_fbEvents 				: I_EventGroup;		// gedeelde FB_ModeEventGroup (E_ModeEvents)

	_nMode 					: USINT;
	_sName 					: STRING;
	_xActive 				: BOOL;
	_eState 				: E_ModeStates;

	_xWarning 				: BOOL;
	_xErrorStop 			: BOOL;

	_iStateStarting 		: UINT;
	_iStateRun 				: UINT;
	_iStateStop 			: UINT;
	_iStateQuickStop 		: UINT;
	_iStateReset 			: UINT;
	_iStateSafe				: UINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF NOT _xActive THEN
	_eState := E_ModeStates.Off;
	RETURN;
END_IF

// Alarmen via de EventService: de Mode reageert op de hele machine
IF _fbEventSrv <> 0 THEN
	_xWarning := _fbEventSrv.HasWarning;
	_xErrorStop := _fbEventSrv.HasAlarm;
ELSE
	_xWarning := FALSE;
	_xErrorStop := FALSE;
END_IF

IF _xErrorStop AND (_eState = E_ModeStates.Run OR _eState = E_ModeStates.Starting) THEN
	_eState := E_ModeStates.Stop;
END_IF

IF _xErrorStop AND _eState = E_ModeStates.Standby THEN
	_eState := E_ModeStates.Invalid;
END_IF

ProcessStates();
HandleEmergencyStop();
