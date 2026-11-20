METHOD PROTECTED LoadHardCodedSettings
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_scSysParAirPressure.eSysPar_DI_SensorType := E_DigitalInputSensorType.Type_NO;
_scSysParAirPressure.tSysPar_Detection_OnDelay := T#1S;
_scSysParAirPressure.tSysPar_Detection_OffDelay := T#1S;
_scSysParAirPressure.tSysPar_Detection_OnDelayOnOff := T#1S;
_scSysParAirPressure.tSysPar_Detection_OffDelayOnOff := T#1S;
