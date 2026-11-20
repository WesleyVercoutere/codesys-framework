// Basis: start is niet mogelijk. Een concrete mode die starten toelaat, overschrijft deze methode.
// TRUE = aanvraag aanvaard.
METHOD StartRequest : BOOL
VAR
	scPayload 	: SC_EventPayload;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _fbEvents <> 0 THEN
	scPayload.asPayload[0] := _sName;
	_fbEvents.Log(iEvent := E_ModeEvents.StartRequestInvalid, scPayload := scPayload);
END_IF

StartRequest := FALSE;
