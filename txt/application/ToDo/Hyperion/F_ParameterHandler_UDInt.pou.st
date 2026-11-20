FUNCTION F_ParameterHandler_UDInt : BOOL
VAR_INPUT
	eSubMachine 				: INT;
	w 							: WORD;
	eMode 						: E_ParameterMode;
	udiParameterId	 			: UDINT;
	xCanBeZero 					: BOOL;
	udiLowLimit 				: UDINT;
	udiUppLimit 				: UDINT;
	xExternalValidationFailed 	: BOOL := FALSE;
END_VAR
VAR_IN_OUT
	xValidationFailed 			: BOOL;
	udiHypValue 				: UDINT;
	udiPLCValue 				: UDINT;
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

_rHypValue := UDINT_TO_REAL (udiHypValue);
_rPLCValue := UDINT_TO_REAL (udiPLCValue);

F_ParameterHandler_Real (
	eSubMachine := eSubMachine,
	w := w,
	eMode := eMode,
	udiParameterId := udiParameterId,
	xCanBeZero := xCanBeZero,
	rLowLimit := UDINT_TO_REAL (udiLowLimit),
	rUppLimit := UDINT_TO_REAL (udiUppLimit),
	xValidationFailed := xValidationFailed,
	xExternalValidationFailed := xExternalValidationFailed,
	rHypValue := _rHypValue,
	rPLCValue := _rPLCValue);

udiHypValue := REAL_TO_UDINT (_rHypValue);
udiPLCValue := REAL_TO_UDINT (_rPLCValue);
