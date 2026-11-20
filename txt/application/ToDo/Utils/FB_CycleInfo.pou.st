FUNCTION_BLOCK FB_CycleInfo
VAR_INPUT
	udiCycleStartEventID : UDINT;
END_VAR
VAR_OUTPUT
	rCycleTime_msec : REAL;
	udiCycleFirstStartCounter : UDINT;
END_VAR
VAR_IN_OUT
	xFirstCycleDone : BOOL;
	xResetFirstCycle : BOOL;
END_VAR
VAR
	_xFirstCycleNew : BOOL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF xFirstCycleDone AND xResetFirstCycle THEN
	xResetFirstCycle := FALSE;
	_xFirstCycleNew := TRUE;
END_IF

IF NOT xFirstCycleDone AND xResetFirstCycle THEN
	xFirstCycleDone := TRUE;
END_IF

IF NOT xFirstCycleDone OR _xFirstCycleNew THEN
	xFirstCycleDone := FALSE;
	_xFirstCycleNew := FALSE;
	F_Event_InsertMessage (
		eSubMachine := 0,
		w := 1,
		iComponentID := 0,
		udiEventID := udiCycleStartEventID,
		eEventLevel := E_EventLevels.EventIsInformational);
	udiCycleFirstStartCounter := udiCycleFirstStartCounter + 1;
END_IF
