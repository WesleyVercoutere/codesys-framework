FUNCTION F_Event_InsertMessage_ParameterChange : BOOL
VAR_INPUT
	eSubMachine : INT;
	w : WORD;
	udiEventID : UDINT;
	eValidationCode : E_ParameterValidationCode;
	rParameterValue_Previous : REAL;
	rParameterValue_New : REAL;
	rParameterValue_MinimumValue : REAL;
	rParameterValue_MaximumValue : REAL;
END_VAR
VAR
	_eEventLevel : E_EventLevels;
	_asEventPayload : ARRAY [1..10] OF STRING;
	_i : INT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Parameter
CASE (eValidationCode) OF
	E_ParameterValidationCode.Invalid :
		_asEventPayload[1] := '-';
		_eEventLevel := E_EventLevels.EventIsWarning_Urgent;
	E_ParameterValidationCode.Validation_Failed_IsZero :
		_asEventPayload[1] := '=0';
		_eEventLevel := E_EventLevels.EventIsWarning_Urgent;
	E_ParameterValidationCode.Validation_Failed_BelowMinimum :
		_asEventPayload[1] := '<';
		_eEventLevel := E_EventLevels.EventIsWarning_Urgent;
	E_ParameterValidationCode.Validation_Failed_AboveMaximum :
		_asEventPayload[1] := '>';
		_eEventLevel := E_EventLevels.EventIsWarning_Urgent;
	E_ParameterValidationCode.Validation_Failed_External :
		_asEventPayload[1] := 'Ext';
		_eEventLevel := E_EventLevels.EventIsWarning_Urgent;
	E_ParameterValidationCode.Validation_Ok :
		_asEventPayload[1] := 'V';
		_eEventLevel := E_EventLevels.EventIsInformational;
END_CASE

_asEventPayload[2] := REAL_TO_STRING (rParameterValue_Previous);
_asEventPayload[3] := REAL_TO_STRING (rParameterValue_New);
_asEventPayload[4] := REAL_TO_STRING (rParameterValue_MinimumValue);
_asEventPayload[5] := REAL_TO_STRING (rParameterValue_MaximumValue);

FOR _i := 6 TO 10 BY 1 DO
	_asEventPayload[_i] := '';
END_FOR

F_Event_InsertInLog (
	eSubMachine := eSubMachine,
	w := w,
	udiEventID := udiEventID, 
	eEventLevel := _eEventLevel, 
	asEventPayload := _asEventPayload
);
