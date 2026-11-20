FUNCTION_BLOCK FB_AnalogInput
VAR_INPUT
	iAI_Value 		: INT;
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_scSysPar 			: SC_SystemParametersAnalogInput;
	_scSignalValue 		: SC_AnalogInputSignals;
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Scale output value (dependant on input signal type)
_scSignalValue.iRawValue := iAI_Value;

_scSignalValue.rValue := F_Scale (
	rInputScaleValue := INT_TO_REAL(iAI_Value),
	rInputScaleValueMinLevel := _scSysPar.rSignalValueEngUnit_AnalogMinLevel,	
	rInputScaleValueMaxLevel := _scSysPar.rSignalValueEngUnit_AnalogMaxLevel,	
	rOutputScaleValueMinLevel := _scSysPar.rSignalValueEngUnit_atAnalogMinLevel,
	rOutputScaleValueMaxLevel := _scSysPar.rSignalValueEngUnit_atAnalogMaxLevel,
	eScaleMethod := E_ScaleMethod.ExtraPolation);

// Add EngineeringUnitString
_scSignalValue.sUnit := F_GetEngUnit(_scSysPar.eSignalEngUnit);
