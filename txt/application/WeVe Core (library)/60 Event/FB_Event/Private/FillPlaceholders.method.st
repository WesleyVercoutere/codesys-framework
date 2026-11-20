// Vervangt %0..%9 in sTemplate door scPayload.asPayload[0..9].
// Een '%' die niet gevolgd wordt door een cijfer blijft staan (bv. '50 %').
METHOD PRIVATE FillPlaceholders : STRING(GVL_Logger.cMaxMessageLength)
VAR_INPUT
	sTemplate 		: STRING(GVL_Logger.cMaxMessageLength);
	scPayload 		: SC_EventPayload;
END_VAR
VAR
	sResult 		: STRING(GVL_Logger.cMaxMessageLength);
	sRest 			: STRING(GVL_Logger.cMaxMessageLength);
	iPos 			: INT;		// positie van '%' in sRest, 1-gebaseerd (FIND)
	byNext 			: BYTE;		// teken na '%'
END_VAR

// --- BEGIN IMPLEMENTATION ---

sResult := '';
sRest := sTemplate;
iPos := FIND(sRest, '%');

WHILE iPos > 0 DO

	// Alles voor de '%' overnemen
	sResult := CONCAT(sResult, LEFT(sRest, iPos - 1));

	// sRest[i] is 0-gebaseerd: sRest[iPos] is het teken na '%' (0 als '%' het laatste teken is)
	byNext := sRest[iPos];

	IF byNext >= 16#30 AND byNext <= 16#39 THEN
		sResult := CONCAT(sResult, scPayload.asPayload[byNext - 16#30]);
		sRest := RIGHT(sRest, LEN(sRest) - iPos - 1);
	ELSE
		sResult := CONCAT(sResult, '%');
		sRest := RIGHT(sRest, LEN(sRest) - iPos);
	END_IF

	iPos := FIND(sRest, '%');

END_WHILE

FillPlaceholders := CONCAT(sResult, sRest);
