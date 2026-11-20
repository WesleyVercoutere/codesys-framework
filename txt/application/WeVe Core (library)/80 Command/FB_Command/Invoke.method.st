// Start een commando, of geeft de status terug als het al loopt.
// xStart is 1 cyclus TRUE wanneer het commando effectief start: neem dan de parameters over.
//
// Een eindresultaat (Done, Error, Aborted) wordt maar 1x afgeleverd aan wie doorlopend pollt.
// De volgende Invoke van hetzelfde commando start het dus opnieuw, ook in de onmiddellijk
// volgende stap (bv. twee keer Move na elkaar met een andere positie).
// Daarom: maximaal 1x per cyclus aanroepen, en verder gaan zodra er een eindresultaat is.
METHOD Invoke : E_CommandResult
VAR_INPUT
	iCmd 		: INT;		// commando-id uit de enum van de module, > 0 (0 = geen commando)
	xAllowed 	: BOOL;		// mag de module nu starten? (bv. enabled, geen fout)
	tTimeout 	: TIME := T#0S;		// max duur van het commando, T#0S = geen timeout
END_VAR
VAR_OUTPUT
	xStart 		: BOOL;
END_VAR
// --- BEGIN IMPLEMENTATION ---

_xPolled := TRUE;

// Ongeldig commando-id: weigeren, nooit stil negeren
IF iCmd <= 0 THEN
	Invoke := E_CommandResult.Rejected;
	RETURN;
END_IF

IF iCmd = _iActive THEN

	// Loopt nog: pollen
	IF _eResult = E_CommandResult.Busy THEN
		Invoke := E_CommandResult.Busy;
		RETURN;
	END_IF

	// Eindresultaat, vorige cyclus nog gepold en nog niet afgeleverd: 1x afleveren
	IF _xPolledPrev AND NOT _xDelivered THEN
		_xDelivered := TRUE;
		Invoke := _eResult;
		RETURN;
	END_IF

END_IF

// Ander commando bezig of module niet klaar: weigeren, nooit stil negeren
IF _eResult = E_CommandResult.Busy OR NOT xAllowed THEN
	Invoke := E_CommandResult.Rejected;
	RETURN;
END_IF

// Starten
_iActive := iCmd;
_eResult := E_CommandResult.Busy;
_xDelivered := FALSE;
_tTimeout := tTimeout;
_xTimedOut := FALSE;
_fbTimeout(IN := FALSE);	// timer van het vorige commando resetten
xStart := TRUE;
Invoke := E_CommandResult.Busy;
