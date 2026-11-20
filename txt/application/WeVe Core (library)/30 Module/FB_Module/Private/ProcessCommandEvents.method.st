// Event bij een commando-timeout. Elke cyclus aanroepen: FB_Event doet de flankdetectie.
// Het event blijft actief tot er een nieuw commando start (TimedOut wordt dan FALSE) en het gereset is.
// %0 = nummer van het commando
METHOD PRIVATE ProcessCommandEvents
VAR_INPUT
END_VAR
VAR
	iEvent 		: INT;
	scPayload 	: SC_EventPayload;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _fbEvents = 0 THEN
	RETURN;
END_IF

iEvent := CommandTimeoutEvent();
IF iEvent < 0 THEN
	RETURN;
END_IF

scPayload.asPayload[0] := INT_TO_STRING(_fbCmd.Last);
_fbEvents.Condition(iEvent := iEvent, xCondition := _fbCmd.TimedOut, scPayload := scPayload);
