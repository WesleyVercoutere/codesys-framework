METHOD Protected ProcessQuickStop
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

// QuickStop is dominant: het actieve commando wordt afgebroken (Aborted).
// Een afgeleide module die hier overschrijft, zet zelf haar uitgangen veilig en roept SUPER^.ProcessQuickStop() aan.
_fbCmd.Abort();

_eState := E_ModuleStates.Invalid;
