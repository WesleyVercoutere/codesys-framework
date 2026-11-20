FUNCTION F_EventHandler_Component_RaiseEvent : BOOL
VAR_INPUT
	w : WORD;
	iComponentId : INT;
	sComponentName : STRING;//STRING [10];
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

// Check disabled
IF scEvent.scEventConfig.xEventIsDisabled THEN
	scEvent.xEvent_WarningInsertedInLog := FALSE;
	scEvent.xEvent_AlarmInsertedInLog := FALSE;
	RETURN;
END_IF

// Insert in log
IF scEvent.xEvent_WarningIsActive AND NOT scEvent.xEvent_WarningInsertedInLog OR 
	scEvent.xEvent_AlarmIsActive AND NOT scEvent.xEvent_AlarmInsertedInLog 
THEN
	// Payload
	_asEventPayload[1] := INT_TO_STRING (iComponentId);
	_asEventPayload[2] := sComponentName;
	
	FOR _i := 3 TO 10 BY 1 DO
		_asEventPayload[_i] := '';
	END_FOR
	
	IF scEvent.xEvent_AlarmIsActive THEN
		
		F_Event_InsertInLog (
			eSubMachine := scEvent.scEventConfig.eSubMachine,
			w := w,
			udiEventID := scEvent.scEventConfig.udiEventID,
			eEventLevel := scEvent.scEventConfig.eEventLevel_InCaseOfAlarm,
			asEventPayload := _asEventPayload
		);
		
	ELSE
		
		F_Event_InsertInLog (
			eSubMachine := scEvent.scEventConfig.eSubMachine,
			w := w,
			udiEventID := scEvent.scEventConfig.udiEventID,
			eEventLevel := scEvent.scEventConfig.eEventLevel_InCaseOfWarning,
			asEventPayload := _asEventPayload
		);
		
	END_IF
	
	IF scEvent.xEvent_AlarmIsActive THEN
		scEvent.xEvent_AlarmInsertedInLog := TRUE;
	ELSE
		scEvent.xEvent_WarningInsertedInLog := TRUE;
	END_IF
	
END_IF
