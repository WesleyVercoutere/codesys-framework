FUNCTION_BLOCK ABSTRACT FB_Hardware IMPLEMENTS I_Hardware
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_xBusy 		: BOOL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

LoadHardCodedSettings();
ProcessHardware();
ProcessErrors();
