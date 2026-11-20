FUNCTION_BLOCK FB_Monostable_OrionButton
VAR_INPUT
	eSubMachine 	: INT;
	w 				: WORD;
	iIdNr 			: INT;	
	udiParameterId 	: UDINT;
END_VAR
VAR_IN_OUT
	udiButton 		: UDINT;
	xResetButton 	: BOOL;
END_VAR
VAR_OUTPUT
	xButtonPressed 	: BOOL;
END_VAR
VAR
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF udiButton = 1 THEN
	xButtonPressed := TRUE;
	udiButton := 0;
	F_Event_InsertMessage(eSubMachine := eSubMachine,w:=w, iComponentId := iIdNr, udiEventID := udiParameterId, eEventLevel := E_EventLevels.EventIsInformational);
END_IF

IF xResetButton THEN
	xButtonPressed := FALSE;
	xResetButton := FALSE;
END_IF
