// Door de afgeleide module overschrijven: elke cyclus in Execute aangeroepen met het actieve commando.
//   CASE iCmd OF
//       E_GripperCmd.Open  : ... IF _fbHw.IsOpen THEN _fbCmd.Finish(); END_IF
//       E_GripperCmd.Close : ...
//   END_CASE
// Klaar: _fbCmd.Finish(). Gefaald: _fbCmd.Fail() en de oorzaak melden via een event.
METHOD PROTECTED ExecuteCommand
VAR_INPUT
	iCmd 		: INT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Basis kent geen commando's
_fbCmd.Fail();
