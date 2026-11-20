// Schrijft de buffer asynchroon weg met CAA File.
// Patroon per CAA-blok: aanroepen met xExecute := TRUE tot xDone of xError,
// daarna één keer met xExecute := FALSE om het blok te resetten.
METHOD PRIVATE ProcessFile
VAR_INPUT
END_VAR
VAR
	szLength 		: CAA.SIZE;
END_VAR

// --- BEGIN IMPLEMENTATION ---

CASE _eState OF

	E_CsvFileLoggerState.Init :
		_fbGetSize(xExecute := TRUE, sFileName := _sFileName);

		IF _fbGetSize.xDone THEN
			_xWriteHeader := _fbGetSize.szSize = 0;
			_fbGetSize(xExecute := FALSE);
			_eState := E_CsvFileLoggerState.Idle;

		ELSIF _fbGetSize.xError THEN
			// Bestand bestaat nog niet: Open maakt het aan
			_xWriteHeader := TRUE;
			_fbGetSize(xExecute := FALSE);
			_eState := E_CsvFileLoggerState.Idle;
		END_IF

	E_CsvFileLoggerState.Idle :
		IF _iCount > 0 THEN
			_eState := E_CsvFileLoggerState.Open;
		END_IF

	E_CsvFileLoggerState.Open :
		_fbOpen(xExecute := TRUE, sFileName := _sFileName, eFileMode := FILE.MODE.MAPPD, xExclusive := FALSE);

		IF _fbOpen.xDone THEN
			_hFile := _fbOpen.hFile;
			_fbOpen(xExecute := FALSE);
			_iLinesThisOpen := 0;
			_eState := E_CsvFileLoggerState.NextLine;

		ELSIF _fbOpen.xError THEN
			_fbOpen(xExecute := FALSE);
			_xError := TRUE;
			_eState := E_CsvFileLoggerState.Error;
		END_IF

	E_CsvFileLoggerState.NextLine :
		IF _xWriteHeader THEN
			_sLine := cHeader;
			_xHeaderBusy := TRUE;
			_eState := E_CsvFileLoggerState.Write;

		ELSIF _iCount > 0 AND _iLinesThisOpen < cMaxLinesPerOpen THEN
			_sLine := BuildLine(iIndex := _iTail);
			_xHeaderBusy := FALSE;
			_eState := E_CsvFileLoggerState.Write;

		ELSE
			_eState := E_CsvFileLoggerState.Close;
		END_IF

	E_CsvFileLoggerState.Write :
		szLength := LEN(_sLine);
		_fbWrite(xExecute := TRUE, hFile := _hFile, pBuffer := ADR(_sLine), szSize := szLength);

		IF _fbWrite.xDone THEN
			_fbWrite(xExecute := FALSE);

			IF _xHeaderBusy THEN
				_xWriteHeader := FALSE;
			ELSE
				// Regel staat in het bestand: uit de buffer halen
				_iTail := (_iTail + 1) MOD cBufferSize;
				_iCount := _iCount - 1;
				_iLinesThisOpen := _iLinesThisOpen + 1;
			END_IF

			_eState := E_CsvFileLoggerState.NextLine;

		ELSIF _fbWrite.xError THEN
			// Regel blijft in de buffer en wordt later opnieuw geprobeerd
			_fbWrite(xExecute := FALSE);
			_xError := TRUE;
			_eState := E_CsvFileLoggerState.Close;
		END_IF

	E_CsvFileLoggerState.Close :
		_fbClose(xExecute := TRUE, hFile := _hFile);

		IF _fbClose.xDone OR _fbClose.xError THEN
			_fbClose(xExecute := FALSE);
			_hFile := 0;

			IF _xError THEN
				_eState := E_CsvFileLoggerState.Error;
			ELSE
				_eState := E_CsvFileLoggerState.Idle;
			END_IF
		END_IF

	E_CsvFileLoggerState.Error :
		_fbRetry(IN := TRUE, PT := tRetry);

		IF _fbRetry.Q THEN
			_fbRetry(IN := FALSE);
			_xError := FALSE;
			// Opnieuw van voor af aan: misschien is het bestand intussen verdwenen
			_eState := E_CsvFileLoggerState.Init;
		END_IF

END_CASE
