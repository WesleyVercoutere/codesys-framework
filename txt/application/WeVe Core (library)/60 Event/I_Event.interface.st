// Eén event: eenmalige melding (Log) of warning/alarm met toestand (Condition).
// Het event bouwt zelf de boodschap op (message + payload) en geeft ze door aan de logger.
// Een event zonder logger mag niet crashen: het houdt dan enkel zijn toestand bij.
INTERFACE I_Event
