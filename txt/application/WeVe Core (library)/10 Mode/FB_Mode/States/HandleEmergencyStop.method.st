METHOD PROTECTED HandleEmergencyStop
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _fbEmergencyStopMod.State = E_EmergencyStopState.NOK THEN
	
	CASE _eState OF
		
		E_ModeStates.Invalid : ;
		E_ModeStates.Off,
		E_ModeStates.Initialize,
		E_ModeStates.Standby : _eState := E_ModeStates.Invalid;
		
		E_ModeStates.Starting,
		E_ModeStates.Run  : _eState := E_ModeStates.QuickStop;
		
		E_ModeStates.Stop,
		E_ModeStates.Safe,
		E_ModeStates.QuickStop,
		E_ModeStates.Reset : ;
		
	END_CASE

END_IF
