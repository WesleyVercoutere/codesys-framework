// Eenmalig bij de opstart, na het registreren: alle groepen initialiseren
// (logger doorgeven, config invullen). Groepen die later registreren worden meteen geïnitialiseerd.
// TRUE = klaar.
METHOD Initialize : BOOL
VAR_INPUT
END_VAR
VAR
	i 		: INT;
END_VAR
// --- BEGIN IMPLEMENTATION ---

FOR i := 0 TO _iGroupCount - 1 DO
	IF _afbGroups[i] <> 0 THEN
		_afbGroups[i].Initialize();
	END_IF
END_FOR

_xInitialized := TRUE;
Initialize := TRUE;
