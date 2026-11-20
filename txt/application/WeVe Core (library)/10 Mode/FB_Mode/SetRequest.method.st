// Basis: geen mode-specifieke aanvragen. Een concrete mode overschrijft deze methode.
// TRUE = aanvraag aanvaard.
METHOD SetRequest : BOOL
VAR_INPUT
	iRequest	: UINT;
	pData		: POINTER TO ARRAY [0..255] OF BYTE := 0;
	pSize		: ULINT := 0;
END_VAR
VAR
	scPayload 	: SC_EventPayload;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _fbEvents <> 0 THEN
	scPayload.asPayload[0] := _sName;
	_fbEvents.Log(iEvent := E_ModeEvents.UserRequestInvalid, scPayload := scPayload);
END_IF

SetRequest := FALSE;
