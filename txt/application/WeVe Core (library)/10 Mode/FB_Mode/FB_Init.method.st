//FB_Init is always available implicitly and it is used primarily for initialization.
//The return value is not evaluated. For a specific influence, you can also declare the
//methods explicitly and provide additional code there with the standard initialization
//code. You can evaluate the return value.
METHOD FB_Init: BOOL
VAR_INPUT
    bInitRetains: BOOL := TRUE; // TRUE: the retain variables are initialized (reset warm / reset cold)
    bInCopyCode: BOOL := TRUE;  // TRUE: the instance will be copied to the copy code afterward (online change)

	nMode 					: USINT;
	sName 					: STRING;
	fbEventSrv 				: I_EventService;
	fbSafetySrv				: I_SafetyService;
	fbEvents 				: I_EventGroup;		// de gedeelde FB_ModeEventGroup, mag 0 zijn
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Enkel referenties en waarden bewaren, geen methodes aanroepen
_fbEventSrv 	:= fbEventSrv;
_fbSafetySrv 	:= fbSafetySrv;
_fbEvents 		:= fbEvents;

_nMode := nMode;
_sName := sName;
