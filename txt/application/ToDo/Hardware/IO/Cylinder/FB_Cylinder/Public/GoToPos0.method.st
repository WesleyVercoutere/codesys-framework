METHOD GoToPos0 : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _eState = E_CylinderStates.Pos0 THEN
	GoToPos0 := TRUE;
	RETURN;
END_IF

_eState := E_CylinderStates.GoToPos0;
