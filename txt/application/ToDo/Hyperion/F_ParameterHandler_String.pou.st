FUNCTION F_ParameterHandler_String : BOOL
VAR_INPUT
	eSubMachine 				: INT;
	w 							: WORD;
	eMode 						: E_ParameterMode;
	udiParameterId 				: UDINT;
	xCanBeLengthZero 			: BOOL;
	iLowLengthLimit 			: INT;
	iUppLengthLimit 			: INT;
	xExternalValidationFailed 	: BOOL := FALSE;
END_VAR
VAR_IN_OUT
	xValidationFailed 			: BOOL;
	sHypValue 					: STRING;
	sPLCValue 					: STRING;
END_VAR
VAR
	_xParameterValid 			: BOOL;
	_sHypValue 					: STRING;
	_sPLCValue 					: STRING;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_sHypValue := sHypValue;
_sPLCValue := sPLCValue;

// Check
IF (eMode = E_ParameterMode.Invalid) THEN
	xValidationFailed := TRUE;
	RETURN;
END_IF

// Check HypValues
IF (eMode = E_ParameterMode.CheckHyp) THEN
	_xParameterValid := TRUE;
	IF NOT xCanBeLengthZero AND (_sHypValue = '') THEN
		_xParameterValid := FALSE;
	ELSIF (LEN (_sHypValue) < iLowLengthLimit) THEN
		_xParameterValid := FALSE;
	ELSIF (LEN (_sHypValue) > iUppLengthLimit) THEN
		_xParameterValid := FALSE;
	ELSIF xExternalValidationFailed THEN
		_xParameterValid := FALSE;
	END_IF
	// !!!!!  SET xParameterValidationFailed (Reset will be performed elsewhere)
	IF (_xParameterValid = FALSE) THEN
		xValidationFailed := TRUE;
	END_IF
END_IF

//Check PLCValues
IF (eMode = E_ParameterMode.CheckPLC) THEN
	_xParameterValid := TRUE;
	IF (NOT xCanBeLengthZero AND (_sPLCValue = '')) THEN 
		_xParameterValid := FALSE;
	ELSIF (LEN (_sPLCValue) < iLowLengthLimit) THEN
		_xParameterValid := FALSE;
	ELSIF (LEN (_sPLCValue) > iUppLengthLimit) THEN
		_xParameterValid := FALSE;
	ELSIF xExternalValidationFailed THEN
		_xParameterValid := FALSE;
	END_IF
	// !!!!!  SET xParameterValidationFailed (Reset will be performed elsewhere)
	IF NOT _xParameterValid THEN
		xValidationFailed := TRUE;
	END_IF
END_IF

// Validate HyperionValues
IF ((eMode = E_ParameterMode.ValidateHyp) OR (eMode = E_ParameterMode.ValidateHypAndSavePLC)) THEN
	_xParameterValid := TRUE;
	IF (NOT xCanBeLengthZero AND (_sHypValue = '')) THEN 
		_xParameterValid := FALSE;
		// Insert message parametervalue is Zero
		F_Event_InsertMessage_StringParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			udiEventID := udiParameterId,
			eValidationCode := E_ParameterValidationCode.Validation_Failed_IsZero,
			sParameterValue_Previous := _sPLCValue,
			sParameterValue_New := _sHypValue,
			iParameterValue_MinimumValue := iLowLengthLimit,
			iParameterValue_MaximumValue := iUppLengthLimit);
	ELSIF (LEN (_sHypValue) < iLowLengthLimit) THEN
		_xParameterValid := FALSE;
		// Insert message parametervalue < rValueLowerLimit
		F_Event_InsertMessage_StringParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			udiEventID := udiParameterId,
			eValidationCode := E_ParameterValidationCode.Validation_Failed_BelowMinimum,
			sParameterValue_Previous := _sPLCValue,
			sParameterValue_New := _sHypValue,
			iParameterValue_MinimumValue := iLowLengthLimit,
			iParameterValue_MaximumValue := iUppLengthLimit);
	ELSIF (LEN (_sHypValue) > iUppLengthLimit) THEN
		_xParameterValid := FALSE; 
		// Insert message parametervalue > rValueUpperLimit
		F_Event_InsertMessage_StringParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			udiEventID := udiParameterId,
			eValidationCode := E_ParameterValidationCode.Validation_Failed_AboveMaximum,
			sParameterValue_Previous := _sPLCValue,
			sParameterValue_New := _sHypValue,
			iParameterValue_MinimumValue := iLowLengthLimit,
			iParameterValue_MaximumValue := iUppLengthLimit);
	ELSIF xExternalValidationFailed THEN
		_xParameterValid := FALSE;
		// Insert message external validatio nfailed
		F_Event_InsertMessage_StringParameterChange (
			eSubMachine := eSubMachine,
			w := w,
			udiEventID := udiParameterId,
			eValidationCode := E_ParameterValidationCode.Validation_Failed_External,
			sParameterValue_Previous := _sPLCValue,
			sParameterValue_New := _sHypValue,
			iParameterValue_MinimumValue := iLowLengthLimit,
			iParameterValue_MaximumValue := iUppLengthLimit);
	END_IF
	// !!!!!  SET xParameterValidationFailed (Reset will be performed elsewhere)
	IF NOT _xParameterValid THEN
		xValidationFailed := TRUE;
	END_IF
END_IF

// Save
IF ((eMode = E_ParameterMode.SavePLC) OR ((eMode = E_ParameterMode.ValidateHypAndSavePLC) AND _xParameterValid)) THEN
	IF (_sPLCValue <> _sHypValue) THEN
		F_Event_InsertMessage_StringParameterChange (
			eSubMachine := eSubMachine,
			w :=w,
			udiEventID := udiParameterId,
			eValidationCode := E_ParameterValidationCode.Validation_Ok,
			sParameterValue_Previous := _sPLCValue,
			sParameterValue_New := _sHypValue,
			iParameterValue_MinimumValue := iLowLengthLimit,
			iParameterValue_MaximumValue := iUppLengthLimit);
		_sPLCValue := _sHypValue;
	END_IF
END_IF

// Copy
IF (eMode = E_ParameterMode.CopyPLCToHyp) THEN
	_sHypValue := _sPLCValue;
END_IF

sHypValue := _sHypValue;
sPLCValue := _sPLCValue;
