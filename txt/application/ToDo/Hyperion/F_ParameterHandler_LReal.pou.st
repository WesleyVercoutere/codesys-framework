FUNCTION F_ParameterHandler_LReal : BOOL
VAR_INPUT
	eSubMachine 				: INT;
	w 							: WORD;
	eMode 						: E_ParameterMode;
	udiParameterId 				: UDINT;
	xCanBeZero 					: BOOL;
	lrLowLimit 					: LREAL;
	lrUppLimit 					: LREAL;
	xExternalValidationFailed 	: BOOL := FALSE;
END_VAR
VAR_IN_OUT
	xValidationFailed 			: BOOL;
	lrHypValue 					: LREAL;
	lrPLCValue 					: LREAL;
END_VAR
VAR
	_xParameterValid 			: BOOL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Check
IF eMode = E_ParameterMode.Invalid THEN
	xValidationFailed := TRUE;
	RETURN;
END_IF

// Check HypValues
IF eMode = E_ParameterMode.CheckHyp THEN
	_xParameterValid := TRUE;
	IF NOT xCanBeZero AND lrHypValue = 0 THEN
		_xParameterValid := FALSE;
	ELSIF lrHypValue < lrLowLimit THEN
		_xParameterValid := FALSE;
	ELSIF lrHypValue > lrUppLimit THEN
		_xParameterValid := FALSE;
	ELSIF xExternalValidationFailed THEN
		_xParameterValid := FALSE;
	END_IF

	// !!!!! SET xParameterValidationFailed (Reset will be performed elsewhere)
	IF NOT _xParameterValid THEN
		xValidationFailed := TRUE;
	END_IF
END_IF

// Check PLCValues
IF eMode = E_ParameterMode.CheckPLC THEN
	_xParameterValid := TRUE;
	IF NOT xCanBeZero AND lrPLCValue = 0 THEN
		_xParameterValid := FALSE;
	ELSIF lrPLCValue < lrLowLimit THEN
		_xParameterValid := FALSE;
	ELSIF lrPLCValue > lrUppLimit THEN
		_xParameterValid := FALSE;
	ELSIF xExternalValidationFailed THEN
		_xParameterValid := FALSE;
	END_IF

	// !!!!! SET xParameterValidationFailed (Reset will be performed elsewhere)
	IF NOT _xParameterValid THEN
		xValidationFailed := TRUE;
	END_IF
END_IF

// Validate HyperionValues
IF eMode = E_ParameterMode.ValidateHyp OR eMode = E_ParameterMode.ValidateHypAndSavePLC THEN
	_xParameterValid := TRUE;
	IF NOT xCanBeZero AND lrHypValue = 0 THEN
		_xParameterValid := FALSE;
		// Insert message parametervalue is Zero
		F_Event_InsertMessage_ParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			eValidationCode := E_ParameterValidationCode.Validation_Failed_IsZero,
			udiEventID := udiParameterId,
			rParameterValue_New := lrHypValue,
			rParameterValue_Previous := lrPLCValue,
			rParameterValue_MinimumValue := LREAL_TO_REAL(lrLowLimit),
			rParameterValue_MaximumValue := LREAL_TO_REAL(lrUppLimit));
	ELSIF lrHypValue < lrLowLimit THEN
		_xParameterValid := FALSE;
		//Insert message parametervalue < rValueLowerLimit
		F_Event_InsertMessage_ParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			eValidationCode := E_ParameterValidationCode.Validation_Failed_BelowMinimum,
			udiEventID := udiParameterId,
			rParameterValue_New := lrHypValue,
			rParameterValue_Previous := lrPLCValue,
			rParameterValue_MinimumValue := LREAL_TO_REAL(lrLowLimit),
			rParameterValue_MaximumValue := LREAL_TO_REAL(lrUppLimit));
	ELSIF lrHypValue > lrUppLimit THEN
		_xParameterValid := FALSE;
		// Insert message parametervalue > rValueUpperLimit
		F_Event_InsertMessage_ParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			eValidationCode := E_ParameterValidationCode.Validation_Failed_AboveMaximum,
			udiEventID := udiParameterId,
			rParameterValue_New := lrHypValue,
			rParameterValue_Previous := lrPLCValue,
			rParameterValue_MinimumValue := LREAL_TO_REAL(lrLowLimit),
			rParameterValue_MaximumValue := LREAL_TO_REAL(lrUppLimit));
	ELSIF xExternalValidationFailed THEN
		_xParameterValid := FALSE; 
		// Insert message externalvalidationfailed
		F_Event_InsertMessage_ParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			eValidationCode := E_ParameterValidationCode.Validation_Failed_External,
			udiEventID := udiParameterId,
			rParameterValue_New := lrHypValue,
			rParameterValue_Previous := lrPLCValue,
			rParameterValue_MinimumValue := LREAL_TO_REAL(lrLowLimit),
			rParameterValue_MaximumValue := LREAL_TO_REAL(lrUppLimit));
	END_IF

	// !!!!! SET xParameterValidationFailed (Reset will be performed elsewhere)
	IF NOT _xParameterValid THEN
		xValidationFailed := TRUE;
	END_IF
END_IF

// Save
IF eMode = E_ParameterMode.SavePLC OR (eMode = E_ParameterMode.ValidateHypAndSavePLC AND _xParameterValid) THEN
	IF lrPLCValue <> lrHypValue THEN
		F_Event_InsertMessage_ParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			eValidationCode := E_ParameterValidationCode.Validation_Ok,
			udiEventID := udiParameterId,
			rParameterValue_New := lrHypValue,
			rParameterValue_Previous := lrPLCValue,
			rParameterValue_MinimumValue := LREAL_TO_REAL(lrLowLimit),
			rParameterValue_MaximumValue := LREAL_TO_REAL(lrUppLimit));
		lrPLCValue := lrHypValue;
	END_IF
END_IF

// Copy
IF eMode = E_ParameterMode.CopyPLCToHyp THEN
	lrHypValue := lrPLCValue;
END_IF
