FUNCTION_BLOCK FB_Bistable_OrionButtonWithExternalReset
VAR_INPUT
	eSubMachine 	: INT;
	w 				: WORD;
	iIdNr 			: INT;
	udiParameterId 	: UDINT;
END_VAR
VAR_IN_OUT
	udiButton 		: UDINT;
	xExternalReset 	: BOOL;
END_VAR
VAR_OUTPUT
	xButtonPressed 	: BOOL;
END_VAR
VAR
END_VAR

// --- BEGIN IMPLEMENTATION ---

//When button in Orion is clicked we receive value 1 on parameter udiButton
//If we write value 2 to parameter udiButton the button has a pressed appearance in Orion

IF udiButton = 1 AND NOT xButtonPressed THEN
	F_Event_InsertMessageString(eSubMachine := eSubMachine,w:=w, udiEventID := udiParameterId, eEventLevel := E_EventLevels.EventIsInformational, sMessageString1 := '1', sMessageString2 := '');
	xButtonPressed := TRUE;
	udiButton := 2;
END_IF

IF udiButton = 1 AND xButtonPressed THEN
	F_Event_InsertMessageString(eSubMachine := eSubMachine,w:=w, udiEventID := udiParameterId, eEventLevel := E_EventLevels.EventIsInformational, sMessageString1 := '0', sMessageString2 := '');
	xButtonPressed := FALSE;
	udiButton := 0;
END_IF

IF xExternalReset THEN
	xButtonPressed := FALSE;
	xExternalReset := FALSE;
	udiButton := 0;
END_IF
