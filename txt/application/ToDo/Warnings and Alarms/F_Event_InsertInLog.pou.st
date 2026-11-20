FUNCTION F_Event_InsertInLog : BOOL
VAR_INPUT
	eSubMachine 			: INT;
	w 						: WORD;
	udiEventID 				: UDINT;
	eEventLevel 			: E_EventLevels;
	asEventPayload 			: ARRAY [1..cHYP_MAX_PAYLOADFIELDS] OF STRING;
END_VAR
VAR
	_scEventForHyperion 	: SC_Hyperion_EventStruct;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF eSubMachine = E_SubMachines.YarnStorage THEN
	audiYSEventCounter[w] := audiYSEventCounter[w] + 1;
	_scEventForHyperion.Counter := audiYSEventCounter[w];
	
	IF audiYSEventCounter[w] >= 4294967295 THEN
		audiYSEventCounter[w] := 0;
	END_IF
	
ELSIF eSubMachine = E_SubMachines.CardBoardStorage THEN
	udiCSEventCounter := udiCSEventCounter + 1;
	_scEventForHyperion.Counter := udiCSEventCounter;
	
	IF udiCSEventCounter >= 4294967295 THEN
		udiCSEventCounter := 0;
	END_IF
	
ELSE
	udiFREventCounter := udiFREventCounter + 1;
	_scEventForHyperion.Counter := udiFREventCounter;
	
	IF udiFREventCounter >= 4294967295 THEN
		udiFREventCounter := 0;
	END_IF
	
END_IF

_scEventForHyperion.Identification := udiEventID;

(*
IF eSubMachine = E_SubMachines.Creel THEN
	audiCLEventCounter[w] := audiCLEventCounter[w] + 1;
	_scEventForHyperion.Counter := audiCLEventCounter[w];
ELSIF eSubMachine = E_SubMachines.CreelRobot THEN
	audiCREventCounter[w] := audiCREventCounter[w] + 1;
	_scEventForHyperion.Counter := audiCREventCounter[w];
ELSIF eSubMachine = E_SubMachines.CreelConveyor THEN
	audiCCEventCounter[w] := audiCCEventCounter[w] + 1;
	_scEventForHyperion.Counter := audiCCEventCounter[w];
ELSIF eSubMachine = E_SubMachines.YarnConsumer THEN
	audiHSEventCounter[w] := audiHSEventCounter[w] + 1;
	_scEventForHyperion.Counter := audiHSEventCounter[w];
ELSE
	udiCUEventCounter := udiCUEventCounter + 1;
	_scEventForHyperion.Counter := udiCUEventCounter;
END_IF
*)

_scEventForHyperion.Identification := udiEventID;


// Create Hyperion Event Struct
CASE (eEventLevel) OF
	E_EventLevels.EventIsInformational : _scEventForHyperion.Level := cHYP_LEVEL_INFORMATIONAL;
	E_EventLevels.Success : _scEventForHyperion.Level := cHYP_LEVEL_BOOKMARK;
	E_EventLevels.EventIsWarning_NotUrgent : _scEventForHyperion.Level := cHYP_LEVEL_WARNING;
	E_EventLevels.EventIsWarning_Urgent : _scEventForHyperion.Level := cHYP_LEVEL_WARNING;
	E_EventLevels.EventIsAlarm_OnlyLogLevel : _scEventForHyperion.Level := cHYP_LEVEL_ERROR;
	E_EventLevels.EventIsAlarm_OperatorLevel : _scEventForHyperion.Level := cHYP_LEVEL_ERROR;
	E_EventLevels.EventIsAlarm_SupervisorLevel : _scEventForHyperion.Level := cHYP_LEVEL_ERROR;
END_CASE

// _scEventForHyperion.TimeStamp := sTimeStamp_Local_AsString;
_scEventForHyperion.TimeStamp := sTimeStamp_UTC_AsString;
_scEventForHyperion.PayLoad := F_HyperionCreatePayloadString (asEventPayload := asEventPayload);

// Insert in local eventbuffer
IF eSubMachine = E_SubMachines.YarnStorage THEN
	audiYSLocalEventPointer[w] := audiYSLocalEventPointer[w] + 1;
	IF audiYSLocalEventPointer[w] > cMaxLocalEvents THEN
		audiYSLocalEventPointer[w] := 1;
	END_IF
	aascYSLocalEventList[w][audiYSLocalEventPointer[w]].udiEventID := udiEventID;
	aascYSLocalEventList[w][audiYSLocalEventPointer[w]].eEventLevel := eEventLevel;
	
ELSE
	udiFRLocalEventPointer := udiFRLocalEventPointer + 1;
	IF udiFRLocalEventPointer > cMaxLocalEvents THEN
		udiFRLocalEventPointer := 1;
	END_IF
	ascFRLocalEventList[udiFRLocalEventPointer].udiEventID := udiEventID;
	ascFRLocalEventList[udiFRLocalEventPointer].eEventLevel := eEventLevel;	
END_IF

// Insert in Hyperion eventbuffer
IF eSubMachine = E_SubMachines.YarnStorage THEN
	aiYSHyperionEventPointer[w] := aiYSHyperionEventPointer[w] + 1;
	IF (aiYSHyperionEventPointer[w] > 50) THEN
		aiYSHyperionEventPointer[w] := 1;
	END_IF
	aascYSHyperion_EventList[w][aiYSHyperionEventPointer[w]] := _scEventForHyperion;
ELSE
	iFRHyperionEventPointer := iFRHyperionEventPointer + 1;
	IF (iFRHyperionEventPointer > cHYP_MAX_EVENTS) THEN
		iFRHyperionEventPointer := 1;
	END_IF
	ascFRHyperion_EventList[iFRHyperionEventPointer] := _scEventForHyperion;
END_IF
