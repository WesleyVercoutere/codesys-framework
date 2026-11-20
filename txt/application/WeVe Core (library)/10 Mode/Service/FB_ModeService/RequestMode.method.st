METHOD RequestMode
VAR_INPUT
	nMode		: USINT;
END_VAR
VAR
	i 			: USINT;
	scPayload 	: SC_EventPayload;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _afbModes[nMode] = 0 THEN
	RETURN;
END_IF

scPayload.asPayload[0] := _afbModes[nMode].Name;

IF _fbEvents <> 0 THEN
	_fbEvents.Log(iEvent := E_ModeEvents.ModeRequest, scPayload := scPayload);
END_IF

IF _afbModes[_nActiveMode].State = E_ModeStates.Standby THEN

	FOR i := 0 TO cNbrOfModes DO

		IF _afbModes[i] <> 0 THEN
			_afbModes[i].State := E_ModeStates.Off;
		END_IF

	END_FOR

	_nActiveMode := nMode;
	_afbModes[nMode].Active := TRUE;

ELSIF _fbEvents <> 0 THEN

	_fbEvents.Log(iEvent := E_ModeEvents.ModeRequestInvalid, scPayload := scPayload);

END_IF
