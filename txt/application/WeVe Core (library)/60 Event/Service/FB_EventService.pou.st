// Centraal register van alle EventGroups. Geeft de actieve warnings en alarmen terug
// en reset alle events in één keer. De service kent geen events, enkel groepen.
//
// Wiring in FB_Application:
//   fbEventSrv : FB_EventService(fbLogger := fbLogger);
//   Opstart:    fbEventSrv.Register(fbAirEvents); ...  daarna  fbEventSrv.Initialize();
//   Cyclisch:   fbEventSrv();   (in dezelfde taak als de Mode, vóór de Mode)
FUNCTION_BLOCK FB_EventService IMPLEMENTS I_EventService
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbLogger 			: I_Logger;			// enkel om fouten van de service zelf te loggen
	_afbGroups 			: ARRAY[0..cMaxGroups - 1] OF I_EventGroup;
	_iGroupCount 		: INT;
	_xInitialized 		: BOOL;
	_scState 			: SC_EventState;
	i 					: INT;
END_VAR
VAR CONSTANT
	cMaxGroups 			: INT := 100;		// ruim kiezen: een volle lijst wordt gelogd
END_VAR

// --- BEGIN IMPLEMENTATION ---

// Samengevatte toestand over alle groepen, één keer per cyclus
_scState.xWarningIsOn := FALSE;
_scState.xAlarmIsOn := FALSE;

FOR i := 0 TO _iGroupCount - 1 DO
	IF _afbGroups[i] <> 0 THEN
		_scState.xWarningIsOn := _scState.xWarningIsOn OR _afbGroups[i].HasWarning;
		_scState.xAlarmIsOn := _scState.xAlarmIsOn OR _afbGroups[i].HasAlarm;
	END_IF
END_FOR
