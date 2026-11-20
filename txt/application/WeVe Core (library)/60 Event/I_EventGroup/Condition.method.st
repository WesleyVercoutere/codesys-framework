// Doorgeefluik naar I_Event.Condition van event iEvent (enum van de eigenaar).
// Geeft Active van dat event terug, FALSE bij een ongeldige index.
METHOD Condition : BOOL
VAR_INPUT
	iEvent 			: INT;
	xCondition 		: BOOL;
	scPayload 		: SC_EventPayload := (asPayload := [10('')]);	// mag weggelaten worden
END_VAR
