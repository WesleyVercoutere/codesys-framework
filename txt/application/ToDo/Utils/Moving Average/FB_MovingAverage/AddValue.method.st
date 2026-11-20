METHOD AddValue
VAR_INPUT
	lrValue 	: LREAL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_iInsertIndex := _iInsertIndex + 1;

IF _iInsertIndex > _iNbrOfItems THEN
	_iInsertIndex := 1;
END_IF

IF _iNbrOfItemsInList < _iNbrOfItems THEN
	_iNbrOfItemsInList := _iNbrOfItemsInList + 1;
END_IF

_alrValues[_iInsertIndex] := lrValue;
