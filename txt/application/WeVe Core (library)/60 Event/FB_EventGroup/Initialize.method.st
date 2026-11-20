// Eenmalig bij de opstart: logger doorgeven aan alle events en hun config invullen.
// Mag meermaals aangeroepen worden, enkel de eerste keer doet iets.
// TRUE = klaar.
METHOD Initialize : BOOL
VAR_INPUT
END_VAR
VAR
	i 			: INT;
	fbEvent 	: I_Event;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _xInitialized THEN
	Initialize := TRUE;
	RETURN;
END_IF

FOR i := 0 TO Count - 1 DO
	fbEvent := GetEvent(i);
	IF fbEvent <> 0 THEN
		fbEvent.Logger := _fbLogger;
	END_IF
END_FOR

ConfigureEvents();

_xInitialized := TRUE;
Initialize := TRUE;
