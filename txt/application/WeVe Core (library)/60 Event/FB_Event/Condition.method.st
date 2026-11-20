// Elke cyclus aanroepen voor een warning of alarm.
//   stijgende flank : event wordt actief en logt 'raised' (met scPayload)
//   dalende flank   : logt 'cleared'
//                     niet resetbaar -> event wordt meteen inactief
//                     resetbaar      -> event blijft actief tot Reset()
// Geeft Active terug.
METHOD Condition : BOOL
VAR_INPUT
	xCondition 		: BOOL;
	scPayload 		: SC_EventPayload := (asPayload := [10('')]);	// mag weggelaten worden
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _xDisabled THEN
	Condition := FALSE;
	RETURN;
END_IF

// Stijgende flank
IF xCondition AND NOT _xCondition THEN
	_xActive := TRUE;
	_scPayload := scPayload;
	WriteLog(sTransition := 'raised', scPayload := _scPayload);

// Dalende flank
ELSIF NOT xCondition AND _xCondition THEN
	WriteLog(sTransition := 'cleared', scPayload := _scPayload);

	IF NOT _scConfig.xResetable THEN
		_xActive := FALSE;
	END_IF

END_IF

_xCondition := xCondition;
Condition := _xActive;
