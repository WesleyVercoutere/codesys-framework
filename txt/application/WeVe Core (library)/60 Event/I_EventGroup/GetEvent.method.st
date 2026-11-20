// Rechtstreekse toegang tot één event, voor uitzonderlijke gevallen.
// Geeft 0 terug bij een ongeldige index: altijd controleren op <> 0.
METHOD GetEvent : I_Event
VAR_INPUT
	iEvent 			: INT;
END_VAR
