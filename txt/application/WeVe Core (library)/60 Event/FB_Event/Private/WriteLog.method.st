// Bouwt de logregel op en geeft ze door aan de logger.
//   '<level> [<overgang>] | <id> | <subMachine>.<subMachineId> | <boodschap>'
// sTransition = '' voor een eenmalige melding.
// TRUE = gelogd. FALSE = geen logger of buffer vol.
METHOD PRIVATE WriteLog : BOOL
VAR_INPUT
	sTransition 	: STRING(20);
	scPayload 		: SC_EventPayload;
END_VAR
VAR
	sLine 			: STRING(GVL_Logger.cMaxMessageLength);
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _fbLogger = 0 THEN
	WriteLog := FALSE;
	RETURN;
END_IF

sLine := F_EventLevelToText(_scConfig.eEventLevel);

IF sTransition <> '' THEN
	sLine := CONCAT(sLine, ' ');
	sLine := CONCAT(sLine, sTransition);
END_IF

sLine := CONCAT(sLine, ' | ');
sLine := CONCAT(sLine, UDINT_TO_STRING(_scConfig.udiEventId));
sLine := CONCAT(sLine, ' | ');
sLine := CONCAT(sLine, USINT_TO_STRING(_scConfig.nSubMachine));
sLine := CONCAT(sLine, '.');
sLine := CONCAT(sLine, USINT_TO_STRING(_scConfig.nSubMachineId));
sLine := CONCAT(sLine, ' | ');
sLine := CONCAT(sLine, FillPlaceholders(sTemplate := _scConfig.sMessage, scPayload := scPayload));

WriteLog := _fbLogger.LogEvent(scEvent := _scConfig, scPayload := scPayload, sMessage := sLine);
