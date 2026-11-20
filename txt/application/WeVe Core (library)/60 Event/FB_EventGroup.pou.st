// Basis voor de events van één eigenaar (mode, module of service).
//
// Een afgeleide groep levert:
//   - een enum per eigenaar, met Count als laatste element
//       E_AirPressureEvent : (PressureNok := 0, PressureLow, Count);
//   - de array van events
//       _afbEvents : ARRAY[0..E_AirPressureEvent.Count] OF FB_Event;   (slot Count blijft ongebruikt)
//   - GetEvent (met bounds check) en Count
//   - ConfigureEvents: één Configure-regel per event
//
// Wiring in FB_Application:
//   fbAirEvents : FB_AirPressureEvents(fbLogger := fbLogger, nSubMachine := 1, nSubMachineId := 0);
// Initialize() wordt eenmalig aangeroepen bij de opstart. Config wordt enkel dan gezet, nooit cyclisch.
FUNCTION_BLOCK ABSTRACT FB_EventGroup IMPLEMENTS I_EventGroup
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbLogger 			: I_Logger;
	_nSubMachine 		: USINT;
	_nSubMachineId 		: USINT;
	_xInitialized 		: BOOL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

