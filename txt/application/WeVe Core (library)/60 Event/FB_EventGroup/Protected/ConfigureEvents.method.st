// Door de afgeleide groep: één Configure-regel per event. Wordt aangeroepen vanuit Initialize.
//   Configure(E_AirPressureEvent.PressureNok, cEv_MainPressureNotOk, E_EventLevels.EventIsAlarm_SupervisorLevel, TRUE,  'Invalid air pressure');
//   Configure(E_AirPressureEvent.PressureLow, cEv_MainPressureLow,   E_EventLevels.EventIsWarning_Urgent,        FALSE, 'Air pressure low: %0 bar');
METHOD PROTECTED ABSTRACT ConfigureEvents
VAR_INPUT
END_VAR
