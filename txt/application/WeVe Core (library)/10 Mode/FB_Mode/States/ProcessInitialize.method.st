METHOD PROTECTED ProcessInitialize
VAR_INPUT
END_VAR
VAR
END_VAR

// --- BEGIN IMPLEMENTATION ---

_iStateStarting := 0;
_iStateRun := 0;
_iStateStop := 0;
_iStateEStop := 0;
_iStateReset := 0;

_eState := E_ModeStates.Standby;
