FUNCTION_BLOCK ABSTRACT FB_Component IMPLEMENTS I_Component
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_xBusy 		: BOOL;
	_xDone 		: BOOL;
	_sName 		: STRING := 'Undefined name';
	_scError 	: SC_Error;
END_VAR

// --- BEGIN IMPLEMENTATION ---


