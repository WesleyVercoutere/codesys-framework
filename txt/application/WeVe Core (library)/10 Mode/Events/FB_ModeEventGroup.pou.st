// Events van de mode-laag. Eén instantie, gedeeld door FB_ModeService en alle FB_Mode's.
// Bevat enkel eenmalige meldingen (Log): er is geen toestand die modes met elkaar delen.
// De mode staat in de boodschap via %0.
//   fbModeEvents : FB_ModeEventGroup(fbLogger := fbLogger, nSubMachine := 0, nSubMachineId := 0);
FUNCTION_BLOCK FB_ModeEventGroup EXTENDS FB_EventGroup
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_afbEvents 		: ARRAY[0..E_ModeEvents.Count] OF FB_Event;		// slot Count blijft ongebruikt
END_VAR

// --- BEGIN IMPLEMENTATION ---

