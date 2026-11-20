METHOD PROTECTED ProcessStates
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

CASE _eState OF
	
	E_ModeStates.Off : ProcessOff();
	E_ModeStates.Initialize : ProcessInitialize();
	E_ModeStates.Standby : ProcessStandby();
	E_ModeStates.Starting : ProcessStarting();
	E_ModeStates.Run : ProcessRun();
	E_ModeStates.Stop : ProcessStop();
	E_ModeStates.QuickStop : ProcessQuickStop();
	E_ModeStates.Invalid : ProcessInvalid();
	E_ModeStates.Reset : ProcessReset();	
	E_ModeStates.Safe : ProcessSafe();

END_CASE
