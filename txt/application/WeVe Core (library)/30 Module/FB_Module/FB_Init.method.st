//FB_Init is always available implicitly and it is used primarily for initialization.
//The return value is not evaluated. For a specific influence, you can also declare the
//methods explicitly and provide additional code there with the standard initialization
//code. You can evaluate the return value.
METHOD FB_Init: BOOL
VAR_INPUT
    bInitRetains: BOOL; // TRUE: the retain variables are initialized (reset warm / reset cold)
    bInCopyCode: BOOL;  // TRUE: the instance will be copied to the copy code afterward (online change)   
	
	fbEvents 	: I_EventGroup;		// de EventGroup van deze module, mag 0 zijn
END_VAR
// --- BEGIN IMPLEMENTATION ---

// Enkel de referentie bewaren, geen methodes aanroepen
_fbEvents := fbEvents;
