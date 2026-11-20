FUNCTION_BLOCK FB_VisuButtonTrigger
VAR_INPUT
	xbtn 		: BOOL;
END_VAR
VAR_OUTPUT
	RQ 			: BOOL;
	FQ 			: BOOL;
	State 		: BOOL;
END_VAR
VAR
	_rtrigger 	: R_TRIG;
	_ftrigger 	: F_TRIG;
END_VAR

// --- BEGIN IMPLEMENTATION ---

State := xbtn;

_rtrigger(CLK := xbtn, Q => RQ);
_ftrigger(CLK := xbtn, Q => FQ);
