// Overschrijven als de module een event wil bij een commando-timeout:
// geef de index van dat event in de enum van de module terug.
//   METHOD PROTECTED CommandTimeoutEvent : INT
//   CommandTimeoutEvent := E_GripperEvents.CommandTimeout;
// In ConfigureEvents van de groep:
//   Configure(iEvent := E_GripperEvents.CommandTimeout, udiEventId := cEv_ModuleCommandTimeout,
//             eEventLevel := E_EventLevels.EventIsAlarm_OperatorLevel, xResetable := TRUE, sMessage := 'Command %0 timed out.');
// -1 = geen event (standaard).
METHOD PROTECTED CommandTimeoutEvent : INT
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

CommandTimeoutEvent := -1;
