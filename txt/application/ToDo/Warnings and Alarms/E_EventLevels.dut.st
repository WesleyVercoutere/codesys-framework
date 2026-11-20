{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_EventLevels :
(
	Invalid := 0,
	NotApplicable := 1,
	Success := 5,
	EventIsInformational := 10,
	EventIsWarning_NotUrgent := 20,
	EventIsWarning_Urgent := 21,
	EventIsAlarm_OnlyLogLevel := 40,
	EventIsAlarm_OperatorLevel := 41,
	EventIsAlarm_SupervisorLevel := 42
);
END_TYPE
