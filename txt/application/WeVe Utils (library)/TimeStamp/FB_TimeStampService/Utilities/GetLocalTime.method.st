METHOD PRIVATE GetLocalTime : E_TaskStatus;
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

GetLocalTime := ReadParameter(
	wIndex			:= 16#245C, 
	bySubIndex		:= 2, 
	udiTimeOut		:= 1000, 
	pDataBuffer		:= ADR(_uliParRead), 
	udiBufferSize	:= 8
);

IF GetLocalTime = E_TaskStatus.Successful THEN
	_dtRead	:= ULINT_TO_DT(_uliParRead/1000000000+946684800);  //Compensation for 1/1/1970 vs 1/1/2000
	_sTimeStamp_Local_AsString := CONCAT (STR1 := RIGHT (STR := DT_TO_STRING (_dtRead), SIZE := 19), STR2 := '.000');
END_IF
