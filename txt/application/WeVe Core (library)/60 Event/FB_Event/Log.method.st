// Eenmalige melding, bv. drukknop of aanvraag. Houdt geen toestand bij.
// TRUE = gelogd. FALSE = uitgeschakeld, geen logger of buffer vol.
METHOD Log : BOOL
VAR_INPUT
	scPayload 		: SC_EventPayload := (asPayload := [10('')]);	// mag weggelaten worden
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _xDisabled THEN
	Log := FALSE;
	RETURN;
END_IF

Log := WriteLog(sTransition := '', scPayload := scPayload);
