PROPERTY Disabled : BOOL
// --- BEGIN IMPLEMENTATION ---



// ----------- GET -----------
VAR
END_VAR

// -- BEGIN IMPLEMENTATION GET --
Disabled := _xDisabled;


// ----------- SET -----------
PUBLIC
VAR
END_VAR

// -- BEGIN IMPLEMENTATION SET --
_xDisabled := Disabled;

// Uitgeschakeld event is nooit actief
IF _xDisabled THEN
	_xActive := FALSE;
	_xCondition := FALSE;
END_IF
