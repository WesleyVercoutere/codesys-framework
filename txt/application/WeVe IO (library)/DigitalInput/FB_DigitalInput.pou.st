FUNCTION_BLOCK FB_DigitalInput
VAR_INPUT
	xDI_Value 			: BOOL;
END_VAR
VAR_OUTPUT
	
END_VAR
VAR	
	_scSysPar 					: SC_SystemParametersDigitalInput;
	_scDISignals 				: SC_DigitalInputSignals;
	
	_rTrigPuls01 				: R_TRIG;
	_fTrigPuls10 				: F_TRIG;
	
	_tonDetectionOnDelay 		: TON;
	_tofDetectionOffDelay 		: TOF;
	_rTrigDelayedPuls01 		: R_TRIG;	
	_fTrigDelayedPuls10 		: F_TRIG;
	
	_tonDetectionOnOffDelay 	: TON;
	_tofDetectionOnOffDelay 	: TOF;
	_rTrigDelayedOnOff 			: R_TRIG;	
	_fTrigDelayedOnOff 			: F_TRIG;
	
END_VAR

// --- BEGIN IMPLEMENTATION ---

_scDISignals.xDIRawValue := xDI_Value;

//Set detectionstate according to sensortype
_scDISignals.xDIDetectionStateOn := xDI_Value;

IF (_scSysPar.eSysPar_DI_SensorType = E_DigitalInputSensorType.Type_NC) THEN
	_scDISignals.xDIDetectionStateOn := NOT xDI_Value;	
END_IF

//Invert for StateOff
_scDISignals.xDIDetectionStateOff := NOT _scDISignals.xDIDetectionStateOn;


//Reset variables
_scDISignals.xDIDetectionOnDelayRunning := FALSE;
_scDISignals.xDIDetectionOffDelayRunning := FALSE;


//Delay DetectionStateOn
_tonDetectionOnDelay.IN:= _scDISignals.xDIDetectionStateOn;
_tonDetectionOnDelay.PT := _scSysPar.tSysPar_Detection_OnDelay;
_tonDetectionOnDelay();

_scDISignals.xDIDelayedDetectionStateOn := _tonDetectionOnDelay.Q;
_scDISignals.xDIDetectionOnDelayRunning := _tonDetectionOnDelay.ET > TIME#0MS;


//Delay DetectionStateOff
_tofDetectionOffDelay.IN:= _scDISignals.xDIDetectionStateOn;
_tofDetectionOffDelay.PT := _scSysPar.tSysPar_Detection_OffDelay;
_tofDetectionOffDelay();

_scDISignals.xDIDelayedDetectionStateOff := _tofDetectionOffDelay.Q;
_scDISignals.xDIDetectionOffDelayRunning := _tofDetectionOffDelay.ET > TIME#0MS;


//Delay DetectionStateOnOff
_tonDetectionOnOffDelay.IN:= _scDISignals.xDIDetectionStateOn;
_tonDetectionOnOffDelay.PT := _scSysPar.tSysPar_Detection_OnDelayOnOff;
_tonDetectionOnOffDelay();
_tofDetectionOnOffDelay.IN:= _scDISignals.xDIDetectionStateOn;
_tofDetectionOnOffDelay.PT := _scSysPar.tSysPar_Detection_OffDelayOnOff;
_tofDetectionOnOffDelay();

_rTrigDelayedOnOff(clk := _tonDetectionOnOffDelay.Q);
_fTrigDelayedOnOff(clk := _tofDetectionOnOffDelay.Q);

IF _rTrigDelayedOnOff.Q THEN
	_scDISignals.xDIDelayedDetectionStateOnOff := TRUE;
END_IF

IF _fTrigDelayedOnOff.Q THEN
	_scDISignals.xDIDelayedDetectionStateOnOff := FALSE;
END_IF




//Puls01 (Rising edge) -- ON DETECTION STATE (Not RawValue)
_rTrigPuls01.CLK := _scDISignals.xDIDetectionStateOn;
_rTrigPuls01();
_scDISignals.xDIDetectionPulse01 := _rTrigPuls01.Q;

//Puls10 (Falling edge) -- ON DETECTION STATE (Not RawValue)
_fTrigPuls10.CLK := _scDISignals.xDIDetectionStateOn;
_fTrigPuls10();
_scDISignals.xDIDetectionPulse10 := _fTrigPuls10.Q;

//Puls01 (Rising edge) -- ON DELAYED DETECTION STATE (Not RawValue)
_rTrigDelayedPuls01.CLK := _scDISignals.xDIDelayedDetectionStateOn;
_rTrigDelayedPuls01();
_scDISignals.xDIDelayedDetectionPulse01 := _rTrigDelayedPuls01.Q;

//Puls10 (Falling edge) -- ON DELAYED DETECTION STATE (Not RawValue)
_fTrigDelayedPuls10.CLK := _scDISignals.xDIDelayedDetectionStateOff;
_fTrigDelayedPuls10();
_scDISignals.xDIDelayedDetectionPulse10 := _fTrigDelayedPuls10.Q;
