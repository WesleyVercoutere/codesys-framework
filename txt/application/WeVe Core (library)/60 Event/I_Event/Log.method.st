// Eenmalige melding, bv. drukknop of aanvraag. Logt OneShot, houdt geen toestand bij.
// TRUE = gelogd.
METHOD Log : BOOL
VAR_INPUT
	scPayload 		: SC_EventPayload := (asPayload := [10('')]);	// mag weggelaten worden
END_VAR
