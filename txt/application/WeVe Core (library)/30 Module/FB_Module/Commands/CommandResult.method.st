// Resultaat van een commando opvragen zonder iets te starten (fire-and-forget opvolgen).
// Blijft staan tot er een nieuw commando start. Idle = dit commando is niet het laatste.
//   40 : Await(fbGripper.CommandResult(E_GripperCmd.Open), iNext := 50, iOnError := 900, iState := _iState);
METHOD CommandResult : E_CommandResult
VAR_INPUT
	iCmd 		: INT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

CommandResult := _fbCmd.ResultOf(iCmd := iCmd);
