// TRUE = aanvraag aanvaard.
METHOD ResetSequenceRequest : BOOL
VAR
	scPayload 	: SC_EventPayload;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF
	_eState = E_ModeStates.Run OR
	_eState = E_ModeStates.Stop OR
	_eState = E_ModeStates.QuickStop
THEN
	IF _fbEvents <> 0 THEN
		scPayload.asPayload[0] := _sName;
		_fbEvents.Log(iEvent := E_ModeEvents.ResetRequestInvalid, scPayload := scPayload);
	END_IF

	ResetSequenceRequest := FALSE;
	RETURN;
END_IF

_eState := E_ModeStates.Reset;
ResetSequenceRequest := TRUE;
