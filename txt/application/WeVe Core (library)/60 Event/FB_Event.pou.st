// Eén event: eenmalige melding (Log) of warning/alarm met toestand (Condition).
//
// Gebruik (via de EventGroup van de eigenaar):
//   - warning/alarm : elke cyclus Condition(xCondition := ..., scPayload := ...)
//   - eenmalig      : Log(scPayload := ...) bij het voorval
//   - reset         : Reset(), lukt enkel als de conditie weg is
//
// Boodschap: Config.sMessage met placeholders %0..%9, ingevuld met scPayload.asPayload[0..9].
// Logregel:  '<level> [<overgang>] | <id> | <subMachine>.<subMachineId> | <boodschap>'
//            bv. 'Alarm supervisor raised | 257 | 1.0 | Invalid air pressure'
// Tijdstempel en teller voegt de logger toe. Zonder logger houdt het event enkel zijn toestand bij.
FUNCTION_BLOCK FB_Event IMPLEMENTS I_Event
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_scConfig 		: SC_Event;
	_fbLogger 		: I_Logger;
	_xDisabled 		: BOOL;
	_xActive 		: BOOL;				// warning/alarm actief of gelatcht
	_xCondition 	: BOOL;				// conditie van de vorige aanroep, voor flankdetectie
	_scPayload 		: SC_EventPayload;	// payload van de laatste stijgende flank, voor cleared/reset
END_VAR

// --- BEGIN IMPLEMENTATION ---

