// Een event loggen. Wordt aangeroepen door FB_Event.
//   scEvent   : ID, level en bron (nSubMachine, nSubMachineId)
//   scPayload : de losse payloadvelden, voor gestructureerde loggers (Hyperion)
//   sMessage  : de volledige tekst, door het event opgebouwd
// TRUE = opgenomen in de buffer, FALSE = buffer vol (de logger telt de overflow).
METHOD LogEvent : BOOL
VAR_INPUT
	scEvent 		: SC_Event;
	scPayload 		: SC_EventPayload;
	sMessage 		: STRING(GVL_Logger.cMaxMessageLength);
END_VAR
