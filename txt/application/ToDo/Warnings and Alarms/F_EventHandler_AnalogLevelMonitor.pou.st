FUNCTION F_EventHandler_AnalogLevelMonitor : BOOL
VAR_INPUT
	eSubMachine : INT;
	w : WORD;
	iComponentId : INT;
	rProcessValue : REAL;
	rAlarmLevelLow : REAL;
	rWarningLevelLow : REAL;
	rWarningLevelHigh : REAL;
	rAlarmLevelHigh : REAL;
	xReset : BOOL;
	xAlarmHigh : BOOL;
	xWarningHigh : BOOL;
	xWarningLow : BOOL;
	xAlarmLow : BOOL;
END_VAR
VAR
END_VAR
VAR_IN_OUT
	scEvent : SC_EventHandler;
END_VAR
VAR
	_asEventPayload : ARRAY [1..10] OF STRING;
	_i : INT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Reset
IF xReset THEN
	scEvent.xEvent_WarningInsertedInLog := FALSE;
	scEvent.xEvent_AlarmInsertedInLog := FALSE;
	RETURN;
END_IF

// Check disabled
IF scEvent.scEventConfig.xEventIsDisabled THEN
	scEvent.xEvent_WarningInsertedInLog := FALSE;
	scEvent.xEvent_AlarmInsertedInLog := FALSE;
	RETURN;
END_IF

// Insert in log - Warning
IF scEvent.xEvent_WarningIsActive AND NOT scEvent.xEvent_WarningInsertedInLog THEN
	// Payload
	_asEventPayload[1] := INT_TO_STRING (iComponentID);
	_asEventPayload[2] := REAL_TO_STRING (rProcessValue);
	_asEventPayload[3] := REAL_TO_STRING (rAlarmLevelLow);
	_asEventPayload[4] := REAL_TO_STRING (rWarningLevelLow);
	_asEventPayload[5] := REAL_TO_STRING (rWarningLevelHigh);
	_asEventPayload[6] := REAL_TO_STRING (rAlarmLevelHigh);

	IF xAlarmHigh THEN
	_asEventPayload[7] := 'Alarm HIGH tension';
	ELSIF xAlarmLow THEN
	_asEventPayload[7] := 'Alarm LOW tension';
	ELSIF xWarningHigh THEN
	_asEventPayload[7] := 'Warning HIGH tension';
	ELSIF xWarningLow THEN
	_asEventPayload[7] := 'Warning LOW tension';
	END_IF

	FOR _i := 8 TO 10 BY 1 DO
		_asEventPayload[_i] := '';
	END_FOR
	F_Event_InsertInLog (
		eSubMachine := eSubMachine,
		w := w,
		udiEventID := scEvent.scEventConfig.udiEventID, 
		eEventLevel := scEvent.scEventConfig.eEventLevel_InCaseOfWarning, 
		asEventPayload := _asEventPayload
	);
	scEvent.xEvent_WarningInsertedInLog := TRUE;
END_IF

// Insert in log - Alarm
IF scEvent.xEvent_AlarmIsActive AND NOT scEvent.xEvent_AlarmInsertedInLog THEN
	// Payload
	_asEventPayload[1] := INT_TO_STRING (iComponentID);
	_asEventPayload[2] := REAL_TO_STRING (rProcessValue);
	_asEventPayload[3] := REAL_TO_STRING (rAlarmLevelLow);
	_asEventPayload[4] := REAL_TO_STRING (rWarningLevelLow);
	_asEventPayload[5] := REAL_TO_STRING (rWarningLevelHigh);
	_asEventPayload[6] := REAL_TO_STRING (rAlarmLevelHigh);

	IF xAlarmHigh THEN
	_asEventPayload[7] := 'Alarm HIGH tension';
	ELSIF xAlarmLow THEN
	_asEventPayload[7] := 'Alarm LOW tension';
	ELSIF xWarningHigh THEN
	_asEventPayload[7] := 'Warning HIGH tension';
	ELSIF xWarningLow THEN
	_asEventPayload[7] := 'Warning LOW tension';
	ELSE
	_asEventPayload[7] := '';
	END_IF

	FOR _i := 8 TO 10 BY 1 DO
		_asEventPayload[_i] := '';
	END_FOR	
	F_Event_InsertInLog (
		eSubMachine := eSubMachine,
		w := w,
		udiEventID := scEvent.scEventConfig.udiEventID, 
		eEventLevel := scEvent.scEventConfig.eEventLevel_InCaseOfAlarm, 
		asEventPayload := _asEventPayload
	);
	scEvent.xEvent_AlarmInsertedInLog := TRUE;
END_IF
