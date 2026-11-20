FUNCTION_BLOCK FB_NavBarController
VAR_INPUT
	xHoverParameters 			: BOOL;
END_VAR
VAR_OUTPUT
	iFrame 						: UINT;
	xHideParameters 			: BOOL;
END_VAR
VAR
	_btnOperationalMode 		: FB_VisuButtonTrigger;
	
	_btnParameters 				: FB_VisuButtonTrigger;
	_btnSysParFR 				: FB_VisuButtonTrigger;
	_btnSysParBuggy 			: FB_VisuButtonTrigger;
	_btnSysParSafety 			: FB_VisuButtonTrigger;

	_btnJobManager 				: FB_VisuButtonTrigger;
	_btnManualRequest 			: FB_VisuButtonTrigger;
	_btnFeedRobot 				: FB_VisuButtonTrigger;
	_btnYarnStorage 			: FB_VisuButtonTrigger;
	
	_tonHideParameters 			: TON;
	_rtrigHideParameters 		: R_TRIG;
END_VAR

// --- BEGIN IMPLEMENTATION ---

ProcessFBs();
HandleButtonClicks();

IF _btnParameters.RQ THEN
	xHideParameters := NOT xHideParameters;
END_IF

_tonHideParameters(IN := NOT xHoverParameters, PT := T#250MS);
_rtrigHideParameters(CLK := _tonHideParameters.Q);

IF _rtrigHideParameters.Q THEN
	xHideParameters := TRUE;	
END_IF
