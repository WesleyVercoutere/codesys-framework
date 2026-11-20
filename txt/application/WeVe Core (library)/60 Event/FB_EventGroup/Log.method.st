// Doorgeefluik naar I_Event.Log van event iEvent (enum van de eigenaar).
// FALSE bij een ongeldige index.
METHOD Log : BOOL
VAR_INPUT
	iEvent 			: INT;
	scPayload 		: SC_EventPayload := (asPayload := [10('')]);	// mag weggelaten worden
END_VAR
VAR
	fbEvent 		: I_Event;
END_VAR

// --- BEGIN IMPLEMENTATION ---

fbEvent := GetEvent(iEvent);

IF fbEvent = 0 THEN
	Log := FALSE;
	RETURN;
END_IF

Log := fbEvent.Log(scPayload := scPayload);
