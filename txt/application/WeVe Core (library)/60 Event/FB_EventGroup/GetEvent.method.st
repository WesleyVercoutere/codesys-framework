// Door de afgeleide groep: event iEvent teruggeven, 0 bij een ongeldige index.
//   IF iEvent >= 0 AND iEvent < Count THEN
//       GetEvent := _afbEvents[iEvent];
//   ELSE
//       GetEvent := 0;
//   END_IF
METHOD ABSTRACT GetEvent : I_Event
VAR_INPUT
	iEvent 			: INT;
END_VAR
