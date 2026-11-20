METHOD PROTECTED ProcessDetections : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _eState = E_CylinderStates.GoToPos0
	AND ((_scSysPar.xSensorPresentPos0 AND _xDetPos0) OR (NOT _scSysPar.xSensorPresentPos0 AND _tonToPos0.Q))
THEN
	_eState := E_CylinderStates.Pos0;
END_IF

IF	_eState = E_CylinderStates.GoToPos1
	AND	((_scSysPar.xSensorPresentPos1 AND _xDetPos1) OR (NOT _scSysPar.xSensorPresentPos1 AND _tontopos1.Q))
THEN
	_eState := E_CylinderStates.Pos1;
END_IF
