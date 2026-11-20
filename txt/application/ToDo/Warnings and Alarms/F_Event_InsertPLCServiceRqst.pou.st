FUNCTION F_Event_InsertPLCServiceRqst : BOOL
VAR_INPUT
	eSubMachine : INT;
	w : WORD;
	udiEventID : UDINT;
	iPLCServiceRqst : INT;
END_VAR
VAR
END_VAR
VAR_IN_OUT
END_VAR
VAR
	_asEventPayload : ARRAY [1..10] OF STRING;
	_i : INT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Payload
_asEventPayload[1] := INT_TO_STRING (iPLCServiceRqst);
FOR _i := 2 TO 10 BY 1 DO
	_asEventPayload[_i] := '';
END_FOR

// Insert in log
F_Event_InsertInLog (
	eSubMachine := eSubMachine,
	w := w,
	udiEventID := udiEventID, 
	eEventLevel := E_EventLevels.EventIsInformational, 
	asEventPayload := _asEventPayload
);
