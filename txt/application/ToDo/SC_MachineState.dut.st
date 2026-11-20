TYPE SC_MachineState :
STRUCT
	eActiveMode 	: E_DefaultModes;
	eActiveState	: E_ModeStates;
	xWarning		: BOOL;
	xError			: BOOL;
	sIp				: STRING;
	xToggle			: BOOL;
END_STRUCT
END_TYPE
