METHOD PROTECTED  CalculateAverage
VAR_INPUT
	alrValues 	: ARRAY[1..cMaxNbrOfEntries] OF LREAL;
END_VAR
VAR
	lrTotal 	: LREAL;
	lrAverage 	: LREAL;
	i 			: UINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

lrTotal := 0;
lrAverage := 0;

FOR i := 1 TO _iNbrOfItems DO
	lrTotal := lrTotal + alrValues[i];
END_FOR

IF _iNbrOfItemsInList > 0 THEN
	lrAverage := lrTotal / _iNbrOfItemsInList;
ELSE
	lrAverage := 0;
END_IF

_lrAverage := lrAverage;
