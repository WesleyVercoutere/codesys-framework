METHOD PRIVATE Init
VAR_INPUT
END_VAR
VAR
	i 	: USINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

FOR i := 0 TO cNbrOfModes DO
	
	IF _afbModes[i] <> 0 THEN
		_afbModes[i].Active := i = _nActiveMode;
	END_IF
	
END_FOR
