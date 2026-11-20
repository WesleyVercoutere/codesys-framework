// Een EventGroup registreren. Bij de opstart, vanuit FB_Application.
// Registreren na Initialize mag ook: de groep wordt dan meteen geïnitialiseerd.
// FALSE = groep is 0, al geregistreerd, of de lijst is vol (wordt gelogd).
METHOD Register : BOOL
VAR_INPUT
	fbEventGroup 	: I_EventGroup;
END_VAR
VAR
	i 				: INT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF fbEventGroup = 0 THEN
	Register := FALSE;
	RETURN;
END_IF

// Dubbele registratie
FOR i := 0 TO _iGroupCount - 1 DO
	IF _afbGroups[i] = fbEventGroup THEN
		Register := FALSE;
		RETURN;
	END_IF
END_FOR

// Lijst vol: nooit stil negeren
IF _iGroupCount >= cMaxGroups THEN
	IF _fbLogger <> 0 THEN
		_fbLogger.LogMessage(
			eLevel 		:= E_EventLevels.EventIsAlarm_OnlyLogLevel,
			sMessage 	:= 'FB_EventService: too many event groups, increase cMaxGroups');
	END_IF
	Register := FALSE;
	RETURN;
END_IF

_afbGroups[_iGroupCount] := fbEventGroup;
_iGroupCount := _iGroupCount + 1;

IF _xInitialized THEN
	fbEventGroup.Initialize();
END_IF

Register := TRUE;
