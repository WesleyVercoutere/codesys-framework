METHOD StopRequest

// --- BEGIN IMPLEMENTATION ---

IF 		_eState = E_ModeStates.Starting 
	OR 	_eState = E_ModeStates.Run
	OR 	_eState = E_ModeStates.Safe 
THEN
	_eState := E_ModeStates.Stop;
END_IF
