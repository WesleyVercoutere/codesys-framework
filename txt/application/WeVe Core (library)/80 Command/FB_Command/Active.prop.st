PROPERTY Active : INT
// --- BEGIN IMPLEMENTATION ---



// ----------- GET -----------
VAR
END_VAR

// -- BEGIN IMPLEMENTATION GET --
IF _eResult = E_CommandResult.Busy THEN
	Active := _iActive;
ELSE
	Active := 0;
END_IF
