FUNCTION F_Scale : REAL
VAR_INPUT
	rInputScaleValue : REAL;
	rInputScaleValueMinLevel : REAL;
	rInputScaleValueMaxLevel : REAL;
	rOutputScaleValueMinLevel : REAL;
	rOutputScaleValueMaxLevel : REAL;
	eScaleMethod : E_ScaleMethod;
END_VAR
VAR_OUTPUT
	xInputScaleValueBelowMinLevel : BOOL;
	xInputScaleValueAboveMaxLevel : BOOL;
	xInputScaleMinMaxDivisionByZero : BOOL;
END_VAR
VAR
	_rPercentValue : REAL;
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Scale the <rInputScale_Value> between <rOutputScale_Value_MinLevel> and <rOutputScale_Value_MaxLevel>
// -- <rOutputScale_Value_MinLevel> ~ <rInputScale_Value_MinLevel>
// -- <rOutputScale_Value_MaxLevel> ~ <rInputScale_Value_MaxLevel>

// Check boundaries <nInputScale_Value>
xInputScaleValueBelowMinLevel := rInputScaleValue < rInputScaleValueMinLevel;
xInputScaleValueAboveMaxLevel := rInputScaleValue > rInputScaleValueMaxLevel;
xInputScaleMinMaxDivisionByZero := (rInputScaleValueMaxLevel - rInputScaleValueMinLevel) = 0;

// If error 
IF eScaleMethod = E_ScaleMethod.InterPolationLimitValue_whenOutLimits AND (xInputScaleValueBelowMinLevel OR xInputScaleValueAboveMaxLevel) THEN
	
	IF xInputScaleValueBelowMinLevel THEN
		F_Scale := rOutputScaleValueMinLevel;
	
	ELSIF xInputScaleValueAboveMaxLevel THEN
		F_Scale := rOutputScaleValueMaxLevel;
	
	END_IF

ELSIF (eScaleMethod = E_ScaleMethod.InterPolationZero_whenOutLimits AND (xInputScaleValueBelowMinLevel OR xInputScaleValueAboveMaxLevel)) OR xInputScaleMinMaxDivisionByZero THEN
	F_Scale := 0.0;
ELSE
	_rPercentValue := (rInputScaleValue - rInputScaleValueMinLevel) / (rInputScaleValueMaxLevel - rInputScaleValueMinLevel);
	F_Scale := rOutputScaleValueMinLevel + ((rOutputScaleValueMaxLevel - rOutputScaleValueMinLevel) * _rPercentValue);
END_IF
