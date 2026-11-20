// Reset alle events van de groep. Elk event beslist zelf of het mag (conditie weg).
// TRUE = geen enkel event nog actief.
METHOD Reset : BOOL
VAR_INPUT
END_VAR
VAR
	i 			: INT;
	fbEvent 	: I_Event;
	xAllReset 	: BOOL := TRUE;
END_VAR

// --- BEGIN IMPLEMENTATION ---

FOR i := 0 TO Count - 1 DO
	fbEvent := GetEvent(i);
	IF fbEvent <> 0 THEN
		// Reset altijd aanroepen, ook als een vorig event al FALSE gaf
		IF NOT fbEvent.Reset() THEN
			xAllReset := FALSE;
		END_IF
	END_IF
END_FOR

Reset := xAllReset;
