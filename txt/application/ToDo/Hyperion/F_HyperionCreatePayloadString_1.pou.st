FUNCTION F_HyperionCreatePayloadString_1 : ARRAY[0..63] OF BYTE
VAR_INPUT
	asEventPayload : ARRAY[1..10] OF STRING;
	iAmountPayload : INT;
END_VAR
VAR
	_sSeparator : STRING(1);
	_bySeparatorAsciiValue : BYTE;
	_byCharAsciiValue : BYTE;
	_iCounter : INT;
	_sPayloadPartString : STRING;
	_sPayloadString : STRING (cHYP_MAX_PAYLOADBYTESIZE);
	_iPayloadStringLength : INT;

	_abyPayloadByteArray : POINTER TO ARRAY [0 .. cHYP_MAX_PAYLOADBYTESIZE] OF BYTE;
	_abyPayloadByteArray_Return : ARRAY [0 .. cHYP_MAX_PAYLOADBYTESIZE] OF BYTE;
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Init
_sPayloadString := '';
_sSeparator := ';';
_bySeparatorAsciiValue := 59;
// Check PayloadStrings
FOR _iCounter := 1 TO iAmountPayload BY 1 DO
	_sPayloadPartString := CONCAT(STR1 := asEventPayload[_iCounter], STR2 := _sSeparator);
	_sPayloadString := CONCAT(STR1 := _sPayloadString, STR2 := _sPayloadPartString);
END_FOR

// String to ByteArray
_iPayloadStringLength := LEN (STR := _sPayloadString);
_abyPayloadByteArray := ADR (_sPayloadString);

// Replace ';' with 0
FOR _iCounter := 0 TO cHYP_MAX_PAYLOADBYTESIZE BY 1 DO
	IF _iCounter < _iPayloadStringLength THEN
		_byCharAsciiValue := _abyPayloadByteArray^[_iCounter];
 		IF (_byCharAsciiValue <> _bySeparatorAsciiValue) THEN
			_abyPayloadByteArray_Return[_iCounter] := _byCharAsciiValue;
		ELSE
			_abyPayloadByteArray_Return[_iCounter] := 0;
		END_IF
	ELSE
		_abyPayloadByteArray_Return[_iCounter] := 0;
	END_IF
END_FOR

F_HyperionCreatePayloadString := _abyPayloadByteArray_Return;
