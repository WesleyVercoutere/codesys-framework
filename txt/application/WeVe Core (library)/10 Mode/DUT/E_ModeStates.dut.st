{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_ModeStates :
(
	Off := 0,
	Invalid,
	Initialize,
	Standby,
	Starting,
	Run,
	Stop,
	QuickStop,
	Safe,
	Reset
)USINT;
END_TYPE
