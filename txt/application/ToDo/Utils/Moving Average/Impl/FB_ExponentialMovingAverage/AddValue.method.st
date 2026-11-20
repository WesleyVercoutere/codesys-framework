METHOD AddValue
VAR_INPUT
	lrValue 	: LREAL;
END_VAR
VAR
	lrMultiplier 	: LREAL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

lrMultiplier := 2.0 / UINT_TO_LREAL(_scSysPar.iNbrOfItemsForAverage + 1);

IF _lrEma = 0 THEN
	_lrEma := lrValue;
	RETURN;
END_IF

_lrEma := (lrValue * lrMultiplier) + (_lrEma * (1 - lrMultiplier));
