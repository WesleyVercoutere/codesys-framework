METHOD PRIVATE ProcessState
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

CASE _eState OF

	E_ModuleStates.Invalid 			: ;
	E_ModuleStates.Initialize 		: ;
	E_ModuleStates.Idle 			: ProcessIdle();
	E_ModuleStates.Enable 			: ProcessEnable();
	E_ModuleStates.Standby 			: ProcessStandby();
	E_ModuleStates.Execute 			: ProcessExecute();
	E_ModuleStates.Disable 			: ProcessDisable();
	E_ModuleStates.Stop 			: ProcessStop();
	E_ModuleStates.QuickStop 		: ProcessQuickStop();
	E_ModuleStates.Reset 			: ProcessReset();
	
END_CASE
