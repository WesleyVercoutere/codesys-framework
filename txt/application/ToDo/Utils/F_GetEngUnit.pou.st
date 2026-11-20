FUNCTION F_GetEngUnit : STRING (20)
VAR_INPUT
	eEngUnit : E_EngineeringUnits;
END_VAR
VAR
	sEngUnitString : STRING(20);
END_VAR

// --- BEGIN IMPLEMENTATION ---

//Add EngineeringUnitString
CASE (eEngUnit) OF
	E_EngineeringUnits.Volt : sEngUnitString := 'V';
	E_EngineeringUnits.gram : sEngUnitString := 'gram';
	E_EngineeringUnits.bar : sEngUnitString := 'bar';
	E_EngineeringUnits.degree : sEngUnitString := '°';
	E_EngineeringUnits.cubicmeters : sEngUnitString := 'm³';
	E_EngineeringUnits.milimeters : sEngUnitString := 'mm';
	ELSE sEngUnitString := '';
END_CASE

F_GetEngUnit := sEngUnitString;
