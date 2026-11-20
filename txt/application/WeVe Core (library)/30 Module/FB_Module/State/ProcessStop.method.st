METHOD PROTECTED ProcessStop
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Stop is dominant: het actieve commando wordt afgebroken (Aborted).
// Een afgeleide module die hier overschrijft, zet zelf haar uitgangen veilig en roept SUPER^.ProcessStop() aan.
_fbCmd.Abort();

_eState := E_ModuleStates.Disable;
