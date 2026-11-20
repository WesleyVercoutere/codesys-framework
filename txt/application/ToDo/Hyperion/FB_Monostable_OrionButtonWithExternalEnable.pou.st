FUNCTION_BLOCK FB_Monostable_OrionButtonWithExternalEnable
VAR_INPUT
	eSubMachine 		: INT;
	w 					: WORD;
	iIdNr 				: INT;	
	udiSwitchOnEventID 	: UDINT;
	udiDisabledEventID 	: UDINT;
	xButtonEnabled 		: BOOL;
END_VAR
VAR_IN_OUT
	udiButton 			: UDINT;
	xResetButton 		: BOOL;	
END_VAR
VAR_OUTPUT
	xButtonPressed 		: BOOL;
END_VAR
VAR
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF udiButton = 1 AND xButtonEnabled THEN
	F_Event_InsertMessage(eSubMachine := eSubMachine,w:=w, iComponentId := iIdNr, udiEventID := udiSwitchOnEventID, eEventLevel := E_EventLevels.EventIsInformational);
	xButtonPressed := TRUE;
	udiButton := 0;
END_IF

IF udiButton = 1 AND NOT xButtonEnabled THEN
	F_Event_InsertMessage(eSubMachine := eSubMachine,w:=w, iComponentId := iIdNr, udiEventID := udiDisabledEventID, eEventLevel := E_EventLevels.EventIsInformational);	
	xButtonPressed := FALSE;
	udiButton := 0;
END_IF	

IF xResetButton THEN
	xButtonPressed := FALSE;
	xResetButton := FALSE;
	udiButton := 0;
END_IF
