{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_ModuleStates :
(
	None := 0,
	Invalid,
	Initialize,
	Idle,
	Enable,
	Standby,
	Execute,
	Stop,
	QuickStop,
	Disable,
	Reset
);
END_TYPE
