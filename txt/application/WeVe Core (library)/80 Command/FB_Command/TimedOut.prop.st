// TRUE als het laatste commando gefaald is door de timeout. Blijft staan tot er een nieuw commando start.
// Bedoeld voor een event in de module: _fbEvents.Condition(..., xCondition := _fbCmd.TimedOut, ...).
PROPERTY TimedOut : BOOL
// --- BEGIN IMPLEMENTATION ---



// ----------- GET -----------
VAR
END_VAR

// -- BEGIN IMPLEMENTATION GET --
TimedOut := _xTimedOut;
