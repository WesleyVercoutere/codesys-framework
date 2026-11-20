// Commando afvuren in een stappenketting, zonder te wachten tot het klaar is.
// Opvolgen gebeurt later met Await op het resultaat (bv. module.CommandResult(...)).
//   Busy          -> commando gestart: iState := iNext, geeft TRUE
//   al de rest    -> niet (opnieuw) gestart: iState := iOnError
//
// Voorbeeld:  20 : Async(fbGripper.Open(), iNext := 30, iOnError := 900, iState := _iState);
FUNCTION Async : BOOL
VAR_INPUT
	eResult 	: E_CommandResult;
	iNext 		: INT;
	iOnError 	: INT;
END_VAR
VAR_IN_OUT
	iState 		: INT;
END_VAR
VAR
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF eResult = E_CommandResult.Busy THEN
	iState := iNext;
	Async := TRUE;
ELSE
	iState := iOnError;
END_IF
