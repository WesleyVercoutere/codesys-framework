METHOD SetLocalTime : E_TaskStatus
VAR_INPUT
	uiYear 					: UINT;
	uiMonth 				: UINT;
	uiDay 					: UINT;
	uiHour 					: UINT;
	uiMinute 				: UINT;
	uiSecond 				: UINT;
END_VAR
VAR
	_uliParWrite			: ULINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_dtSetDateAndTime := DTU.DTConcat(
						uiYear := uiYear, 
						uiMonth := uiMonth, 
						uiDay := uiDay, 
						uiHour := uiHour, 
						uiMinute := uiMinute, 
						uiSecond := uiSecond, 
						peError := ADR(_eError)
					);

_uliParWrite:=(DT_TO_ULINT(_dtSetDateAndTime)-946684800)*1000000000;	//Compensation for 1/1/1970 vs 1/1/2000

SetLocalTime := WriteParameter(
	wIndex		:= 	16#245C, 
	bySubIndex	:= 	2, 
	udiTimeOut	:= 	1000, 
	pDataBuffer	:=	ADR(_uliParWrite) , 
	udiDataSize	:=	8
);
