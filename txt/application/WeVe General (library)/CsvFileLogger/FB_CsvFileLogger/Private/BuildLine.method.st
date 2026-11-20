// Csv-regel opbouwen voor de regel op plaats iIndex in de buffer:
//   <timestamp>;<counter>;<level>;"<message>"$R$N
// Dubbele aanhalingstekens in de boodschap worden enkele, zodat de csv geldig blijft.
// Een regel is max 255 tekens (limiet van de stringfuncties): een lange boodschap wordt afgekapt.
METHOD PRIVATE BuildLine : STRING(255)
VAR_INPUT
	iIndex 			: INT;
END_VAR
VAR
	sMessage 		: STRING(GVL_Logger.cMaxMessageLength);
	sLine 			: STRING(255);
	iPos 			: INT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

sMessage := _ascEntries[iIndex].sMessage;

iPos := FIND(sMessage, '"');
WHILE iPos > 0 DO
	sMessage := REPLACE(sMessage, '$'', 1, iPos);
	iPos := FIND(sMessage, '"');
END_WHILE

sLine := _ascEntries[iIndex].sTimeStamp;
sLine := CONCAT(sLine, ';');
sLine := CONCAT(sLine, UDINT_TO_STRING(_ascEntries[iIndex].udiCounter));
sLine := CONCAT(sLine, ';');
sLine := CONCAT(sLine, F_EventLevelToText(_ascEntries[iIndex].eLevel));
sLine := CONCAT(sLine, ';"');
sLine := CONCAT(sLine, sMessage);

// Plaats houden voor het slot '"$R$N' (3 tekens)
IF LEN(sLine) > 252 THEN
	sLine := LEFT(sLine, 252);
END_IF

BuildLine := CONCAT(sLine, '"$R$N');
