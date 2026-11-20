// Een EventGroup registreren. Eenmalig, in de eerste cyclus, vanuit FB_Application.
// FALSE = lijst vol (de service logt dit) of groep al geregistreerd.
METHOD Register : BOOL
VAR_INPUT
	fbEventGroup 	: I_EventGroup;
END_VAR
