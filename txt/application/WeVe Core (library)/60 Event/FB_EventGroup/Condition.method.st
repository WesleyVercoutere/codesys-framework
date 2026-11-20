// Doorgeefluik naar I_Event.Condition van event iEvent (enum van de eigenaar).
// Geeft Active van dat event terug, FALSE bij een ongeldige index.
METHOD Condition : BOOL
VAR_INPUT
	iEvent 			: INT;
	xCondition 		: BOOL;
	scPayload 		: SC_EventPayload := (asPayload := [10('')]);	// mag weggelaten worden
END_VAR
VAR
	fbEvent 		: I_Event;
END_VAR

// --- BEGIN IMPLEMENTATION ---

fbEvent := GetEvent(iEvent);

IF fbEvent = 0 THEN
	Condition := FALSE;
	RETURN;
END_IF

Condition := fbEvent.Condition(xCondition := xCondition, scPayload := scPayload);
