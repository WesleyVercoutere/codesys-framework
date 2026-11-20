FUNCTION_BLOCK FB_AnalogOutput
VAR_INPUT
END_VAR
VAR_OUTPUT
	iAQ_Value 				: INT;
END_VAR
VAR
	_scSysPar 				: SC_SystemParametersAnalogOutput;
	_rSetPoint 				: REAL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

iAQ_Value := REAL_TO_INT (F_Scale (
	rInputScaleValue := _rSetPoint,
	rInputScaleValueMinLevel := _scSysPar.rSysPar_SignalValue_EngUnit_atAnalogMinLevel,
	rInputScaleValueMaxLevel := _scSysPar.rSysPar_SignalValue_EngUnit_atAnalogMaxLevel,
	rOutputScaleValueMinLevel := _scSysPar.iSysPar_SignalValue_Raw_atAnalogMinLevel,
	rOutputScaleValueMaxLevel := _scSysPar.iSysPar_SignalValue_Raw_atAnalogMaxLevel,
	eScaleMethod := E_ScaleMethod.InterPolationZero_whenOutLimits));
