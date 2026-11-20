PROPERTY HasWarning : BOOL
// --- BEGIN IMPLEMENTATION ---



// ----------- GET -----------
VAR
	i 			: INT;
	fbEvent 	: I_Event;
END_VAR

// -- BEGIN IMPLEMENTATION GET --
HasWarning := FALSE;

FOR i := 0 TO Count - 1 DO
	fbEvent := GetEvent(i);
	IF fbEvent <> 0 THEN
		IF fbEvent.Active AND (fbEvent.Level = E_EventLevels.EventIsWarning_NotUrgent OR fbEvent.Level = E_EventLevels.EventIsWarning_Urgent) THEN
			HasWarning := TRUE;
			RETURN;
		END_IF
	END_IF
END_FOR
