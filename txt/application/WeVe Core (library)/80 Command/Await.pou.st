// Uniforme afhandeling van een commando in een stappenketting.
//   Done                      -> iState := iNext, geeft TRUE
//   Error, Aborted, Rejected  -> iState := iOnError
//   Idle                      -> iState := iOnError (commando is nooit gestart)
//   Busy                      -> blijven wachten
//
// Voorbeeld:  10 : Await(fbGripper.Close(rForce := 50), iNext := 20, iOnError := 900, iState := _iState);
//             40 : Await(fbGripper.CommandResult(E_GripperCommand.Open), iNext := 50, iOnError := 900, iState := _iState);
FUNCTION Await : BOOL
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

CASE eResult OF

	E_CommandResult.Done :
		iState := iNext;
		Await := TRUE;

	E_CommandResult.Idle,
	E_CommandResult.Error,
	E_CommandResult.Aborted,
	E_CommandResult.Rejected :
		iState := iOnError;

END_CASE
