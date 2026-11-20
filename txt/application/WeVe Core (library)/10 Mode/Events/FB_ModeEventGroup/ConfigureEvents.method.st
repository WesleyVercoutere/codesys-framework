// %0 = naam van de (gevraagde) mode
METHOD PROTECTED ConfigureEvents
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

// FB_ModeService
Configure(iEvent := E_ModeEvents.ModeRequest, 			udiEventId := cEv_ModeRequest, 			eEventLevel := E_EventLevels.EventIsInformational, 		xResetable := FALSE, sMessage := 'Request mode %0');
Configure(iEvent := E_ModeEvents.ModeRequestInvalid, 	udiEventId := cEv_ModeRequestInvalid, 	eEventLevel := E_EventLevels.EventIsAlarm_OnlyLogLevel, xResetable := FALSE, sMessage := 'Can not go to %0. Machine is not standby.');

// FB_Mode
Configure(iEvent := E_ModeEvents.StartRequestInvalid, 	udiEventId := cEv_StartRequestInvalid, 	eEventLevel := E_EventLevels.EventIsAlarm_OnlyLogLevel, xResetable := FALSE, sMessage := 'Start can not be used in mode %0.');
Configure(iEvent := E_ModeEvents.ResetRequestInvalid, 	udiEventId := cEv_ResetRequestInvalid, 	eEventLevel := E_EventLevels.EventIsAlarm_OnlyLogLevel, xResetable := FALSE, sMessage := 'Can not reset mode %0 while running or stopping.');
Configure(iEvent := E_ModeEvents.UserRequestInvalid, 	udiEventId := cEv_UserRequestInvalid, 	eEventLevel := E_EventLevels.EventIsAlarm_OnlyLogLevel, xResetable := FALSE, sMessage := 'User request not available in mode %0.');
