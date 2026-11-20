METHOD SetTimeBase :  E_TaskStatus
VAR_INPUT
	eTimeBase	: E_TimeBase;
END_VAR

// --- BEGIN IMPLEMENTATION ---

SetTimeBase := WriteParameter(
	wIndex		:= 	16#245B, 
	bySubIndex	:= 	1, 
	udiTimeOut	:= 	1000, 
	pDataBuffer	:=	ADR(eTimeBase) , 
	udiDataSize	:=	1
);
