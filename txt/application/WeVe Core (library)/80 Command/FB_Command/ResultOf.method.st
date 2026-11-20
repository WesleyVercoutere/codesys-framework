// Resultaat van een commando opvragen zonder iets te starten.
// Blijft staan tot er een nieuw commando start. Idle = dit commando is niet het laatste.
METHOD ResultOf : E_CommandResult
VAR_INPUT
	iCmd 	: INT;
END_VAR
// --- BEGIN IMPLEMENTATION ---

IF iCmd = _iActive THEN
	ResultOf := _eResult;
ELSE
	ResultOf := E_CommandResult.Idle;
END_IF
