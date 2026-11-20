METHOD PRIVATE CheckNumberOfItems
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_iNbrOfItems := _scSysPar.iNbrOfItemsForAverage;

IF _iNbrOfItems <= 0 THEN
	_iNbrOfItems := 10;
END_IF

IF _iNbrOfItems > cMaxNbrOfEntries THEN
	_iNbrOfItems := cMaxNbrOfEntries;
END_IF
