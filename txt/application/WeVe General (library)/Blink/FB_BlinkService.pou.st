FUNCTION_BLOCK FB_BlinkService IMPLEMENTS I_BlinkService
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbBlink200msLow1800msHigh 		: BLINK;
	_fbBlink1800msLow200msHigh 		: BLINK;
	_fbBlink1000msLow1000msHigh 	: BLINK;
	_fbBlink250msLow250msHigh 		: BLINK;
	_fbBlink500msLow500msHigh 		: BLINK;
	_fbBlink100msLow100msHigh 		: BLINK;
	
	_scBlinks 						: SC_Blinks;
END_VAR

// --- BEGIN IMPLEMENTATION ---

_fbBlink200msLow1800msHigh(ENABLE := TRUE, TIMELOW := T#200MS, TIMEHIGH := T#1800MS);
_fbBlink1800msLow200msHigh(ENABLE := TRUE, TIMELOW :=T#1800MS , TIMEHIGH := T#200MS);
_fbBlink1000msLow1000msHigh(ENABLE := TRUE, TIMELOW := T#1000MS, TIMEHIGH := T#1000MS);
_fbBlink250msLow250msHigh(ENABLE := TRUE, TIMELOW := T#250MS, TIMEHIGH := T#250MS);
_fbBlink500msLow500msHigh(ENABLE := TRUE, TIMELOW := T#250MS, TIMEHIGH := T#250MS);
_fbBlink100msLow100msHigh(ENABLE := TRUE, TIMELOW := T#100MS, TIMEHIGH := T#100MS);

_scBlinks.xBlink200msLow1800msHigh 		:= _fbBlink200msLow1800msHigh.OUT;
_scBlinks.xBlink1800msLow200msHigh 		:= _fbBlink1800msLow200msHigh.OUT;
_scBlinks.xBlink1000msLow1000msHigh 	:= _fbBlink1000msLow1000msHigh.OUT;
_scBlinks.xBlink250msLow250msHigh 		:= _fbBlink250msLow250msHigh.OUT;
_scBlinks.xBlink500msLow500msHigh 		:= _fbBlink500msLow500msHigh.OUT;
_scBlinks.xBlink100msLow100msHigh 		:= _fbBlink100msLow100msHigh.OUT;
