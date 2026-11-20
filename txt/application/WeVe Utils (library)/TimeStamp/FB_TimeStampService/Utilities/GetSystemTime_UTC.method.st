METHOD PRIVATE GetSystemTime_UTC : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Get SystemTime (UTC)
_fbGetSystemTime_UTC (xExecute := _xGetSystemTime, dtDateAndTime => _dtSystemTime_UTC);
_xGetSystemTime := TRUE;

IF _fbGetSystemTime_UTC.xDone THEN
	_xGetSystemTime := FALSE;
END_IF

// String of the UTC-DateTime
IF _fbGetSystemTime_UTC.xDone THEN
	_sTimeStamp_UTC_AsString := CONCAT(STR1 := RIGHT (STR := DT_TO_STRING (_dtSystemTime_UTC), SIZE := 19), STR2 := '.000');
	_xTimeStampStringCreated := TRUE;
END_IF
