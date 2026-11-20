METHOD PROTECTED  CalculateAverage
VAR_INPUT
	alrValues 	: ARRAY[1..cMaxNbrOfEntries] OF LREAL;
END_VAR
VAR
	lrTotal 	: lREAL;
	lrAverage 	: LREAL;
	i, j 		: UINT;
	alrSorted 	: ARRAY[1..cMaxNbrOfEntries] OF LREAL;
	rTemp 		: LREAL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

lrTotal := 0;
lrAverage := 0;

alrSorted := alrValues;

IF _iNbrOfItemsInList > 3 THEN
	
	(*Bubble sort- The value of n should be equivalent to the last array element*)
	FOR i := 1 TO _iNbrOfItemsInList BY 1 DO 
	
		(* The second FOR loop compares two elements of the array at a time and sorts*)
		FOR j := 1 TO _iNbrOfItemsInList - 1 BY 1 DO
	
			IF (alrSorted[j] > alrSorted[j+1]) THEN
	
					rTemp := alrSorted[j+1];
					
					alrSorted[j+1] := alrSorted[j];
					alrSorted[j] := rTemp;
					
			END_IF
	
		END_FOR
	
	END_FOR
	
	FOR i := 2 TO _iNbrOfItemsInList - 1 DO
		lrTotal := lrTotal + alrSorted[i];
	END_FOR
	
	lrAverage := lrTotal / (_iNbrOfItemsInList - 2);

	_lrAverage := lrAverage;
	
ELSE
	
	SUPER^.CalculateAverage(alrValues := alrValues);
	
END_IF
