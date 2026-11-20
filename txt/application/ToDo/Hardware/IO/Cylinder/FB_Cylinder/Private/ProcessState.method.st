METHOD PROTECTED ProcessState : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

CASE _eState OF
	
	E_CylinderStates.Invalid		: ;
	E_CylinderStates.Pos0			: ;
	E_CylinderStates.Pos1			: ;
	E_CylinderStates.GoToPos0		: ProcessGoToPos0();
	E_CylinderStates.GoToPos1		: ProcessGoToPos1();
	
END_CASE

_xDone := _eState = E_CylinderStates.Pos0 OR _eState = E_CylinderStates.Pos1;
_xBusy := _eState = E_CylinderStates.GoToPos0 OR _eState = E_CylinderStates.GoToPos1;
