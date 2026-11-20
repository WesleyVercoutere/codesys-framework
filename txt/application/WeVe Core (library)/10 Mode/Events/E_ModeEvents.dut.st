// Events van de mode-laag (FB_ModeService en alle FB_Mode's). Index in FB_ModeEventGroup, niet de event-ID.
// Geen 'strict': de waarden worden als INT doorgegeven aan de EventGroup.
{attribute 'qualified_only'}
TYPE E_ModeEvents :
(
	// FB_ModeService
	ModeRequest := 0,
	ModeRequestInvalid,

	// FB_Mode
	StartRequestInvalid,
	ResetRequestInvalid,
	UserRequestInvalid,

	Count				// altijd laatste
);
END_TYPE
