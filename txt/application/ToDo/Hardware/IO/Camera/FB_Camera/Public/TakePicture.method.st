METHOD TakePicture : BOOL
VAR_INPUT
	pictureId		: STRING;
END_VAR
VAR
	dataLength		: INT := 0;
	sDataLength		: STRING;
	operationInst	: STRING := 'TRX';
END_VAR

// --- BEGIN IMPLEMENTATION ---

dataLength := LEN(pictureId);
sDataLength := INT_TO_STRING(dataLength);

WHILE LEN(sDataLength) < 2 DO
	sDataLength := CONCAT('0', INT_TO_STRING(dataLength));
END_WHILE

_sPictureId := 	CONCAT(operationInst, 
					CONCAT(sDataLength, pictureId)
				);

IF _xDone  THEN
	TakePicture := TRUE;
	RETURN;
END_IF

IF _eState = E_CameraStates.Standby THEN
	_eState := E_CameraStates.TakePicture;
END_IF
