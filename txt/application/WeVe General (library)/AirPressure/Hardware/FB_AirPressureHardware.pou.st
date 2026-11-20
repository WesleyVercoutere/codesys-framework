FUNCTION_BLOCK FB_AirPressureHardware EXTENDS FB_Hardware IMPLEMENTS I_AirPressureHardware
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_scSysParAirPressure 	: SC_SystemParametersDigitalInput;
	_fbAirPressure 			: FB_DigitalInput;
END_VAR

// --- BEGIN IMPLEMENTATION ---

SUPER^();
