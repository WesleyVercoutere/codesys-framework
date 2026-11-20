// Globale reset: alle groepen resetten. Elk event beslist zelf of het mag (conditie weg).
// TRUE = geen enkel event nog actief.
METHOD Reset : BOOL
VAR_INPUT
END_VAR
VAR
	i 			: INT;
	xAllReset 	: BOOL := TRUE;
END_VAR

// --- BEGIN IMPLEMENTATION ---

FOR i := 0 TO _iGroupCount - 1 DO
	IF _afbGroups[i] <> 0 THEN
		// Reset altijd aanroepen, ook als een vorige groep al FALSE gaf
		IF NOT _afbGroups[i].Reset() THEN
			xAllReset := FALSE;
		END_IF
	END_IF
END_FOR

Reset := xAllReset;
