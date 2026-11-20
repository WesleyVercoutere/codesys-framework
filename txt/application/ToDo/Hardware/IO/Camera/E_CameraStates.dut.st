{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_CameraStates :
(
	Invalid := 0,
	None,
	Initialize,
	Connect,
	Disconnect,
	Standby,
	SelectJob,
	TakePicture,
	Reset
);
END_TYPE
