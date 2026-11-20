METHOD GoToPos1 : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _eState = E_CylinderStates.Pos1 THEN
	GoToPos1 := TRUE;
	RETURN;
END_IF

_eState := E_CylinderStates.GoToPos1;
