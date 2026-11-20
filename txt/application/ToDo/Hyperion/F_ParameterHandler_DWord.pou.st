FUNCTION F_ParameterHandler_DWord : BOOL
VAR_INPUT
	eSubMachine 				: INT;
	w 							: WORD;
	eMode 						: E_ParameterMode;
	udiParameterId 				: UDINT;
	xCanBeZero 					: BOOL;
	dwLowLimit 					: DWORD;
	dwUppLimit 					: DWORD;
	xExternalValidationFailed 	: BOOL := FALSE;
END_VAR
VAR_IN_OUT
	xValidationFailed 			: BOOL;
	dwHypValue 					: DWORD;
	dwPLCValue 					: DWORD;
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

_rHypValue := DWORD_TO_REAL (dwHypValue);
_rPLCValue := DWORD_TO_REAL (dwPLCValue);

F_ParameterHandler_Real (
	eSubMachine := eSubMachine,
	w := w,
	eMode := eMode,
	udiParameterId := udiParameterId,
	xCanBeZero := xCanBeZero,
	rLowLimit := DWORD_TO_REAL (dwLowLimit),
	rUppLimit := DWORD_TO_REAL (dwUppLimit),
	xValidationFailed := xValidationFailed,
	xExternalValidationFailed := xExternalValidationFailed,
	rHypValue := _rHypValue,
	rPLCValue := _rPLCValue);

dwHypValue := REAL_TO_DWORD (_rHypValue);
dwPLCValue := REAL_TO_DWORD (_rPLCValue);
