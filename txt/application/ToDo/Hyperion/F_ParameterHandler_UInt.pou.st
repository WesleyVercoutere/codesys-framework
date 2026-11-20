FUNCTION F_ParameterHandler_UInt : BOOL
VAR_INPUT
	eSubMachine 				: INT;
	w 							: WORD;
	eMode 						: E_ParameterMode;
	udiParameterId 				: UDINT;
	xCanBeZero 					: BOOL;
	uiLowLimit 					: UINT;
	uiUppLimit 					: UINT;
	xExternalValidationFailed 	: BOOL := FALSE;
END_VAR
VAR_IN_OUT
	xValidationFailed 			: BOOL;
	uiHypValue 					: UINT;
	uiPLCValue 					: UINT;
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

_rHypValue := UINT_TO_REAL (uiHypValue);
_rPLCValue := UINT_TO_REAL (uiPLCValue);

F_ParameterHandler_Real (
	eSubMachine := eSubMachine,
	w := w,
	eMode := eMode,
	udiParameterId := udiParameterId,
	xCanBeZero := xCanBeZero,
	rLowLimit := UINT_TO_REAL (uiLowLimit),
	rUppLimit := UINT_TO_REAL (uiUppLimit),
	xValidationFailed := xValidationFailed,
	xExternalValidationFailed := xExternalValidationFailed,
	rHypValue := _rHypValue,
	rPLCValue := _rPLCValue);

uiHypValue := REAL_TO_UINT (_rHypValue);
uiPLCValue := REAL_TO_UINT (_rPLCValue);
