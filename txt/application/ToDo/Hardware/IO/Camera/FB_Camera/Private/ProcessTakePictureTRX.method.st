METHOD PRIVATE ProcessTakePictureTRX
VAR_INPUT
END_VAR
VAR
	result 	: STRING;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_xBusy := TRUE;

CASE _iStateTakePicture OF
	
	0 :
		_sResult := '';
		_sPicture := 'ASH11';		
		_write.szSize := SIZEOF(_sPicture);
		_write.pData := ADR(_sPicture);
		_write.xExecute := TRUE;

		_iStateTakePicture := _iStateTakePicture + 10;	
	
		
	10 :
		IF MID(STR := _sFeedBack, LEN := 4, POS := 1) = 'ASHP' THEN
			_sFeedBack := '';
			_write.xExecute := FALSE;
			_iStateTakePicture := _iStateTakePicture + 10;
		END_IF	
		
		
	20 :
		//_tonPicture.IN := TRUE;
		
		//IF _tonPicture.Q THEN
			_tonPicture.IN := FALSE;
			_iStateTakePicture := _iStateTakePicture + 10;
		//END_IF
		
		
	30 :
		_sPicture := _sPictureId; //MID(STR := _sPictureId, LEN := 5, POS := 1);		
		_write.szSize := SIZEOF(_sPicture);
		_write.pData := ADR(_sPicture);
		_write.xExecute := TRUE;

		_iStateTakePicture := _iStateTakePicture + 10;

		
	40 :
		IF MID(STR := _sFeedBack, LEN := 4, POS := 1) = 'TRXP' THEN
			_sFeedBack := '';
			_write.xExecute := FALSE;
			_iStateTakePicture := _iStateTakePicture + 10;
		ELSIF MID(STR := _sFeedBack, LEN := 4, POS := 1) = 'TRXF' THEN
			_sFeedBack := '';
			_write.xExecute := FALSE;
			_iStateTakePicture := 20;
		END_IF	
		
		
	50 :
		_tonPicture.IN := TRUE;
		
		IF _tonPicture.Q and _sResult <> '' THEN
			_tonPicture.IN := FALSE;
			_iStateTakePicture := _iStateTakePicture + 10;
		END_IF
		
	
	60 :
		_iStateTakePicture := 0;
		_xDone := TRUE;
		_eState := E_CameraStates.Standby;
		

END_CASE
