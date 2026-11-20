// Doorgeefluik naar I_Event.Log van event iEvent (enum van de eigenaar).
// FALSE bij een ongeldige index.
METHOD Log : BOOL
VAR_INPUT
	iEvent 			: INT;
	scPayload 		: SC_EventPayload := (asPayload := [10('')]);	// mag weggelaten worden
END_VAR
