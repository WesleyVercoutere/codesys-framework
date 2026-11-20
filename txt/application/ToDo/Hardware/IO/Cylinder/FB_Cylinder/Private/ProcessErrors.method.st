METHOD PROTECTED ProcessErrors
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _scSysPar.xSensorPresentPos0 AND _tonToPos0.Q THEN
	
	_eState := E_CylinderStates.Invalid;
	_scError.xErrorActive := TRUE;
	_scError.sError := CONCAT(_sName, ': did not reach position 0 in time.');
	
END_IF

IF _scSysPar.xSensorPresentPos1 AND _tonToPos1.Q THEN
	
	_eState := E_CylinderStates.Invalid;
	_scError.xErrorActive := TRUE;
	_scError.sError := CONCAT(_sName, ': did not reach position 1 in time.');
	
END_IF

IF _eState <> E_CylinderStates.Invalid THEN
	_scError.xErrorActive := FALSE;
	_scError.sError := '';
END_IF
