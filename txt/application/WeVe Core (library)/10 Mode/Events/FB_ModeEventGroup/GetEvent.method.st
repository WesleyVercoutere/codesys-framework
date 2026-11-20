METHOD GetEvent : I_Event
VAR_INPUT
	iEvent 			: INT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF iEvent >= 0 AND iEvent < Count THEN
	GetEvent := _afbEvents[iEvent];
ELSE
	GetEvent := 0;
END_IF
