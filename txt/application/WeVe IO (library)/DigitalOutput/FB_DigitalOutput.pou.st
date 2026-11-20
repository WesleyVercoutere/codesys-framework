FUNCTION_BLOCK FB_DigitalOutput
VAR_INPUT	
END_VAR
VAR_OUTPUT
	xDQ_Value 		: BOOL;
END_VAR
VAR	
	_scSysPar 		: SC_SystemParametersDigitalOutput;
	_xOutputValue 	: BOOL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF NOT _scSysPar.xInvertOutput THEN
	xDQ_Value := _xOutputValue;
ELSE
	xDQ_Value := NOT _xOutputValue;
END_IF
