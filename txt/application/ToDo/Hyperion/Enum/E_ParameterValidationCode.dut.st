TYPE E_ParameterValidationCode :
(
	Invalid := 0,
	Validation_Failed_IsZero := 1,
	Validation_Failed_BelowMinimum := 2,
	Validation_Failed_AboveMaximum := 3,
	Validation_Failed_External := 4,
	Validation_Ok := 5
);
END_TYPE
