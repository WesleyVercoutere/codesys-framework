// Vrije tekst loggen, bv. om te debuggen.
// TRUE = opgenomen in de buffer, FALSE = buffer vol.
METHOD LogMessage : BOOL
VAR_INPUT
	eLevel 			: E_EventLevels;
	sMessage 		: STRING(GVL_Logger.cMaxMessageLength);
END_VAR

// --- BEGIN IMPLEMENTATION ---

LogMessage := AddEntry(eLevel := eLevel, sMessage := sMessage);
