FUNCTION F_ParameterHandler_Int : BOOL
VAR_INPUT
	eSubMachine 				: INT;
	w 							: WORD;
	eMode 						: E_ParameterMode;
	udiParameterId 				: UDINT;
	xCanBeZero 					: BOOL;
	iLowLimit 					: INT;
	iUppLimit 					: INT;
	xExternalValidationFailed 	: BOOL := FALSE;
END_VAR
VAR_IN_OUT
	xValidationFailed 			: BOOL;
	iHypValue 					: INT;
	iPLCValue 					: INT;
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

_rHypValue := INT_TO_REAL (iHypValue);
_rPLCValue := INT_TO_REAL (iPLCValue);

F_ParameterHandler_Real (
	eSubMachine := eSubMachine,
	w := w,
	eMode := eMode,
	udiParameterId := udiParameterId,
	xCanBeZero := xCanBeZero,
	rLowLimit := INT_TO_REAL (iLowLimit),
	rUppLimit := INT_TO_REAL (iUppLimit),
	xValidationFailed := xValidationFailed,
	xExternalValidationFailed := xExternalValidationFailed,
	rHypValue := _rHypValue,
	rPLCValue := _rPLCValue);

iHypValue := REAL_TO_INT (_rHypValue);
iPLCValue := REAL_TO_INT (_rPLCValue);
