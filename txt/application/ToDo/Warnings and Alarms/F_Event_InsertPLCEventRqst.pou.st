FUNCTION F_Event_InsertPLCEventRqst : BOOL
VAR_INPUT
	eSubMachine : INT;
	w : WORD;
	udiEventID : UDINT;
END_VAR
VAR
END_VAR
VAR_IN_OUT
END_VAR
VAR
	_asEventPayload : ARRAY[1..10] OF STRING;
	_i : int;
END_VAR

// --- BEGIN IMPLEMENTATION ---

//Payload
_asEventPayload[1] := ' TEST';
FOR _i := 2 TO 10 BY 1 DO
	_asEventPayload[_i] := '';
END_FOR	
	
//Insert in log
F_Event_InsertInLog(
	eSubMachine := eSubMachine,
	w := w,
	udiEventID := udiEventID, 
	eEventLevel := E_EventLevels.EventIsInformational, 
	asEventPayload := _asEventPayload
);
