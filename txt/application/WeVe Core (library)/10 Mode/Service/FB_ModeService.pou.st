FUNCTION_BLOCK FB_ModeService IMPLEMENTS I_ModeService
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbEventSrv 				: I_EventService;
	_fbLogger 					: I_Logger;
	_fbEvents 					: I_EventGroup;		// gedeelde FB_ModeEventGroup (E_ModeEvents)
	_afbModes 					: ARRAY[0..cNbrOfModes] OF I_Mode;

	_nActiveMode 				: USINT;
	_xInit 						: BOOL;
END_VAR
VAR CONSTANT
	cNbrOfModes 				: USINT := 13;
END_VAR
// --- BEGIN IMPLEMENTATION ---

IF _xInit THEN
	_xInit := FALSE;
	Initialize();
END_IF

Init();
