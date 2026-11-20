FUNCTION_BLOCK FB_Cylinder EXTENDS FB_Component
VAR_OUTPUT
	xDQ_Value 			: BOOL;
END_VAR
VAR
	_scSysPar			: SC_SystemParametersCylinder;
	_eState				: E_CylinderStates;
	
	_tonToPos0			: TON;
	_tonToPos1			: TON;
	
	_xDetPos0			: BOOL;
	_xDetPos1			: BOOL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

ProcessTimers();
ProcessState();
ProcessDetections();
ProcessErrors();
