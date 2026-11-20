TYPE E_HyperionHandshake :
(
	Invalid := 0,
	AwaitingSendStartRqst := 1,
	AwaitingSendStopRqst := 2,
	AwaitingStartAckNack := 3,
	AwaitingStopAckNack := 4,
	
	Rcve_StartRqst := 5,
	
	Send_ReadyForStart := 6,
	Send_NotReadyForStart := 7,
	
	Rcve_StopRqst := 8,
	
	DataValidating := 9,
	Send_DataValid := 10,
	Send_DataNotValid := 11
);
END_TYPE
