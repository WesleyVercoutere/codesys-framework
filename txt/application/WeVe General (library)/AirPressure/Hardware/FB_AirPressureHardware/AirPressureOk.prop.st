PROPERTY AirPressureOk : BOOL

// --- BEGIN IMPLEMENTATION ---



// ----------- GET -----------
VAR
	scSignals 	: SC_DigitalInputSignals;
END_VAR

// -- BEGIN IMPLEMENTATION GET --
scSignals := _fbAirPressure.Signals;

AirPressureOk := scSignals.xDIDelayedDetectionStateOff;
