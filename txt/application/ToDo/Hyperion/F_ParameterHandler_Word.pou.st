FUNCTION F_ParameterHandler_Word : BOOL
VAR_INPUT
	eSubMachine 				: INT;
	w 							: WORD;
	eMode 						: E_ParameterMode;
	udiParameterId 				: UDINT;
	xCanBeZero 					: BOOL;
	wLowLimit 					: WORD;
	wUppLimit 					: WORD;
	xExternalValidationFailed 	: BOOL := FALSE;
END_VAR
VAR_IN_OUT
	xValidationFailed 			: BOOL;
	wHypValue 					: WORD;
	wPLCValue 					: WORD;
END_VAR
VAR
	_xParameterValid 			: BOOL;
	_rHypValue 					: REAL;
	_rPLCValue 					: REAL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF eMode = E_ParameterMode.Invalid THEN
	xValidationFailed := TRUE;
	RETURN;
END_IF

_rHypValue := WORD_TO_REAL (wHypValue);
_rPLCValue := WORD_TO_REAL (wPLCValue);

F_ParameterHandler_Real (
	eSubMachine := eSubMachine,
	w := w,
	eMode := eMode,
	udiParameterId := udiParameterId,
	xCanBeZero := xCanBeZero,
	rLowLimit := WORD_TO_REAL (wLowLimit),
	rUppLimit := WORD_TO_REAL (wUppLimit),
	xValidationFailed := xValidationFailed,
	xExternalValidationFailed := xExternalValidationFailed,
	rHypValue := _rHypValue,
	rPLCValue := _rPLCValue);

wHypValue := REAL_TO_WORD (_rHypValue);
wPLCValue := REAL_TO_WORD (_rPLCValue);
