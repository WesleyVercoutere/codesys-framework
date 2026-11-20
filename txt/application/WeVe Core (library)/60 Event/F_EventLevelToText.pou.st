// Leesbare tekst voor een event-level, voor logregels.
FUNCTION F_EventLevelToText : STRING(20)
VAR_INPUT
	eLevel 			: E_EventLevels;
END_VAR
VAR
END_VAR

// --- BEGIN IMPLEMENTATION ---

CASE eLevel OF
	E_EventLevels.Success 						: F_EventLevelToText := 'Success';
	E_EventLevels.EventIsInformational 			: F_EventLevelToText := 'Info';
	E_EventLevels.EventIsWarning_NotUrgent 		: F_EventLevelToText := 'Warning';
	E_EventLevels.EventIsWarning_Urgent 		: F_EventLevelToText := 'Warning urgent';
	E_EventLevels.EventIsAlarm_OnlyLogLevel 	: F_EventLevelToText := 'Alarm log';
	E_EventLevels.EventIsAlarm_OperatorLevel 	: F_EventLevelToText := 'Alarm operator';
	E_EventLevels.EventIsAlarm_SupervisorLevel 	: F_EventLevelToText := 'Alarm supervisor';
ELSE
	F_EventLevelToText := 'Event';
END_CASE
