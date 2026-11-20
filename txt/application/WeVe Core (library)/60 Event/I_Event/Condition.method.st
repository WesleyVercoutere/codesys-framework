// Elke cyclus aanroepen voor een warning of alarm.
//   stijgende flank : event wordt actief en logt dat (met scPayload)
//   dalende flank   : logt dat de conditie weg is
//                     niet resetbaar -> event wordt meteen inactief
//                     resetbaar      -> event blijft actief tot Reset()
// Het event bouwt zelf de tekst op, de logger stuurt die alleen door.
// Geeft Active terug.
METHOD Condition : BOOL
VAR_INPUT
	xCondition 		: BOOL;
	scPayload 		: SC_EventPayload := (asPayload := [10('')]);	// mag weggelaten worden
END_VAR
