FUNCTION Round : LREAL
VAR_INPUT
	lrValue 		: LREAL;
 	iDecimalPlaces 	: INT;
END_VAR
VAR
	_lrOutput 		: LREAL;
	_lrRightPart 	: LREAL;
  	_lrLeftPart 	: LREAL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_lrOutput := lrValue * EXPT(10, iDecimalPlaces);
_lrRightPart := DINT_TO_LREAL(TRUNC(_lrOutput));
_lrLeftPart := _lrOutput - _lrRightPart;

_lrOutput := _lrRightPart;

IF _lrLeftPart >= 0.5 THEN
  _lrOutput := _lrRightPart + 1; 
END_IF

_lrOutput := _lrOutput / EXPT(10, iDecimalPlaces);

Round := _lrOutput;
