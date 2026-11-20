// Regel achteraan in de ringbuffer zetten, met tijdstempel en volgnummer.
// TRUE = opgenomen, FALSE = buffer vol (geteld in Overflow).
METHOD PRIVATE AddEntry : BOOL
VAR_INPUT
	eLevel 			: E_EventLevels;
	sMessage 		: STRING(GVL_Logger.cMaxMessageLength);
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _iCount >= cBufferSize THEN
	_udiOverflow := _udiOverflow + 1;
	_udiLost := _udiLost + 1;
	AddEntry := FALSE;
	RETURN;
END_IF

_udiCounter := _udiCounter + 1;

IF _fbTimeStamp <> 0 THEN
	_ascEntries[_iHead].sTimeStamp := _fbTimeStamp.TimeStamp_Local_AsString;
ELSE
	_ascEntries[_iHead].sTimeStamp := '';
END_IF

_ascEntries[_iHead].udiCounter := _udiCounter;
_ascEntries[_iHead].eLevel := eLevel;
_ascEntries[_iHead].sMessage := sMessage;

_iHead := (_iHead + 1) MOD cBufferSize;
_iCount := _iCount + 1;

AddEntry := TRUE;
