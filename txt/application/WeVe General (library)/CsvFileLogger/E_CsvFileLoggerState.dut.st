{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_CsvFileLoggerState :
(
	Init := 0,		// bestaat het bestand al? (header nodig of niet)
	Idle,			// wachten op regels in de buffer
	Open,			// bestand openen om toe te voegen
	NextLine,		// volgende regel (of header) klaarzetten
	Write,			// regel wegschrijven
	Close,			// bestand sluiten
	Error			// wachten en opnieuw proberen
);
END_TYPE
