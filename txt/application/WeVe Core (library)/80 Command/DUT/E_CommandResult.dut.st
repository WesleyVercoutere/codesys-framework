// Resultaat van een commando, teruggegeven door elke commando-methode van een module.
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_CommandResult :
(
	Idle 		:= 0,	// geen commando / nog niet gestart
	Busy,				// commando loopt
	Done,				// commando goed afgewerkt
	Error,				// commando gefaald (oorzaak: zie module)
	Aborted,			// commando afgebroken (Stop / mode-wissel)
	Rejected			// niet gestart: module bezig met ander commando of niet klaar
);
END_TYPE