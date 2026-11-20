// Reset het event, maar enkel als de conditie weg is. Logt 'reset'.
// TRUE = event is niet (meer) actief.
METHOD Reset : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF NOT _xActive THEN
	Reset := TRUE;
	RETURN;
END_IF

// Oorzaak nog aanwezig: reset weigeren
IF _xCondition THEN
	Reset := FALSE;
	RETURN;
END_IF

_xActive := FALSE;
WriteLog(sTransition := 'reset', scPayload := _scPayload);
Reset := TRUE;
