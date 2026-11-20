// Alle events van de machine resetten via de EventService (ook die van deze mode).
// Elk event beslist zelf of het mag (conditie weg).
// TRUE = geen enkel event nog actief.
METHOD ResetEvents : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _fbEventSrv <> 0 THEN
	ResetEvents := _fbEventSrv.Reset();
ELSE
	ResetEvents := TRUE;
END_IF
