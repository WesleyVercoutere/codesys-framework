METHOD SetLocalTimeZone : E_TaskStatus
VAR_INPUT
	eTimeZone	: E_TimeZone;
END_VAR

// --- BEGIN IMPLEMENTATION ---

SetLocalTimeZone := WriteParameter(
	wIndex		:= 	16#245C, 
	bySubIndex	:= 	1, 
	udiTimeOut	:= 	1000, 
	pDataBuffer	:=	ADR(eTimeZone) , 
	udiDataSize	:=	2
);
