METHOD Reset
VAR_INPUT
END_VAR
VAR
	i 	: UINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

FOR i := 1 TO cMaxNbrOfEntries DO
	_alrValues[i] := 0;	
END_FOR

_lrAverage := 0;
_iInsertIndex := 0;
_iNbrOfItemsInList := 0;
