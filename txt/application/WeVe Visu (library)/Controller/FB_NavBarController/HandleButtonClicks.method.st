METHOD PRIVATE HandleButtonClicks : BOOL
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _btnOperationalMode.RQ THEN
	SetFrame(iFrameToShow := 0);
END_IF

IF _btnSysParFR.RQ THEN
	SetFrame(iFrameToShow := 1);
END_IF

IF _btnSysParBuggy.RQ THEN
	SetFrame(iFrameToShow := 2);
END_IF

IF _btnJobManager.RQ THEN
	SetFrame(iFrameToShow := 3);
END_IF

IF _btnManualRequest.RQ THEN
	SetFrame(iFrameToShow := 4);
END_IF

IF _btnFeedRobot.RQ THEN
	SetFrame(iFrameToShow := 5);
END_IF

IF _btnYarnStorage.RQ THEN
	SetFrame(iFrameToShow := 6);
END_IF

IF _btnSysParSafety.RQ THEN
	SetFrame(iFrameToShow := 7);
END_IF
