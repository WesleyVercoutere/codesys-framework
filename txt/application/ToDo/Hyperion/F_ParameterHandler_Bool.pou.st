FUNCTION F_ParameterHandler_Bool : BOOL
VAR_INPUT
	eSubMachine 				: INT;
	w 							: WORD;
	eMode 						: E_ParameterMode;
	udiParameterId 				: UDINT;
	xExternalValidationFailed 	: BOOL := FALSE;
END_VAR
VAR_IN_OUT
	xValidationFailed 			: BOOL;
END_VAR
VAR_IN_OUT
	xHypValue 					: BOOL;
	xPLCValue 					: BOOL;
END_VAR
VAR
	_xParameterValid 			: BOOL;
	_rHypValue 					: REAL;
	_rPLCValue 					: REAL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF (eMode = E_ParameterMode.Invalid) THEN
	xValidationFailed := TRUE;
	RETURN;
END_IF

IF xHypValue THEN
	_rHypValue := 1;
ELSE
	_rHypValue := 0;
END_IF

IF xPLCValue THEN
	_rPLCValue := 1;
ELSE
	_rPLCValue := 0;
END_IF

F_ParameterHandler_Real (
	eSubMachine := eSubMachine,
	w := w,
	eMode := eMode,
	udiParameterId := udiParameterId,
	xCanBeZero := TRUE,
	rLowLimit := 0,
	rUppLimit := 1,
	xValidationFailed := xValidationFailed,
	xExternalValidationFailed := xExternalValidationFailed,
	rHypValue := _rHypValue,
	rPLCValue := _rPLCValue);

xHypValue := _rHypValue = 1;
xPLCValue := _rPLCValue = 1;
