// Standaard logger: schrijft regels naar een csv-bestand op de PLC.
//
// Kolommen: Timestamp;Counter;Level;Message   (scheidingsteken ';', boodschap tussen "")
//   2026-11-20 14:03:12.345;17;Alarm supervisor;"Alarm supervisor raised | 257 | 1.0 | Invalid air pressure"
//
// Werking:
//   - LogMessage/LogEvent zetten de regel enkel in een ringbuffer: kost bijna niets in de cyclus.
//   - De body schrijft de buffer asynchroon weg met CAA File (open in append-modus, regels schrijven, sluiten).
//   - Buffer vol: de regel gaat verloren, Overflow telt mee, en zodra er terug plaats is
//     komt er een regel in de log met het aantal verloren regels.
//   - Schrijffout: na tRetry opnieuw proberen, de buffer blijft bewaard.
//   - Nieuw of leeg bestand: eerst de kopregel.
//
// Wiring in FB_Application:
//   fbLogger : FB_CsvFileLogger(sFileName := 'eventlog.csv', fbTimeStamp := fbTimeStampSrv);
//   Cyclisch: fbLogger();
// Roep de body aan in dezelfde taak als de FB's die loggen: de ringbuffer is niet beveiligd
// tegen gelijktijdige toegang vanuit meerdere taken.
//
// Vereist de library CAA File (namespace FILE).
FUNCTION_BLOCK FB_CsvFileLogger IMPLEMENTS I_Logger
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_sFileName 			: STRING(255);
	_fbTimeStamp 		: I_TimeStampService;

	// Ringbuffer
	_ascEntries 		: ARRAY[0..cBufferSize - 1] OF SC_LogEntry;
	_iHead 				: INT;		// volgende vrije plaats
	_iTail 				: INT;		// oudste regel
	_iCount 			: INT;		// aantal regels in de buffer
	_udiCounter 		: UDINT;	// volgnummer van de regels
	_udiOverflow 		: UDINT;	// totaal aantal verloren regels
	_udiLost 			: UDINT;	// verloren sinds de laatste melding in de log

	// Bestand
	_eState 			: E_CsvFileLoggerState;
	_fbGetSize 			: FILE.GetSize;
	_fbOpen 			: FILE.Open;
	_fbWrite 			: FILE.Write;
	_fbClose 			: FILE.Close;
	_hFile 				: CAA.HANDLE;
	_sLine 				: STRING(255);
	_xWriteHeader 		: BOOL;		// kopregel moet nog geschreven worden
	_xHeaderBusy 		: BOOL;		// _sLine is de kopregel
	_iLinesThisOpen 	: INT;
	_xError 			: BOOL;
	_fbRetry 			: TON;
END_VAR
VAR CONSTANT
	cBufferSize 		: INT := 100;
	cMaxLinesPerOpen 	: INT := 20;		// daarna sluiten, zodat de regels zeker op schijf staan
	tRetry 				: TIME := T#10S;
	cHeader 			: STRING := 'Timestamp;Counter;Level;Message$R$N';
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Verloren regels melden zodra er terug plaats is
IF _udiLost > 0 AND _iCount < cBufferSize THEN
	AddEntry(
		eLevel 		:= E_EventLevels.EventIsAlarm_OnlyLogLevel,
		sMessage 	:= CONCAT('Logger buffer full, lines lost: ', UDINT_TO_STRING(_udiLost)));
	_udiLost := 0;
END_IF

ProcessFile();
