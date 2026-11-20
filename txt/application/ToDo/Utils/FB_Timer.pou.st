FUNCTION_BLOCK FB_Timer
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_xOn 			: BOOL;
	_rtrigOn 		: R_TRIG;
	_ftrigOn 		: F_TRIG;
	
	_tStart 		: TIME;
	_tEnd 			: TIME;
	_tDelta 		: TIME;
	_tPrevious 		: TIME;
	_tTotal 		: TIME;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_rtrigOn(CLK := _xOn);
_ftrigOn(CLK := _xOn);

IF _rtrigOn.Q THEN
	_tStart := TO_TIME(SysTimeGetMs());
END_IF

IF _ftrigOn.Q THEN
	_tPrevious := _tPrevious + _tDelta;
	_tDelta := T#0MS;
END_IF

IF _xOn THEN
	_tEnd := TO_TIME(SysTimeGetMs());
	_tDelta := _tEnd - _tStart;
END_IF

_tTotal := _tPrevious + _tDelta;
