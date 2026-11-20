// Een event loggen. Een tekstlogger gebruikt enkel de tekst (en het level voor de kolom Level);
// ID, bron en payload zitten al in sMessage.
// TRUE = opgenomen in de buffer, FALSE = buffer vol.
METHOD LogEvent : BOOL
VAR_INPUT
	scEvent 		: SC_Event;
	scPayload 		: SC_EventPayload;
	sMessage 		: STRING(GVL_Logger.cMaxMessageLength);
END_VAR

// --- BEGIN IMPLEMENTATION ---

LogEvent := AddEntry(eLevel := scEvent.eEventLevel, sMessage := sMessage);
