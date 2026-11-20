FUNCTION_BLOCK FB_ManualController
VAR_OUTPUT
	xManualMode 			: BOOL;
	xEnabled 				: BOOL;
END_VAR
VAR
	_fbManualMode 			: I_Mode;
	
	_btnRequestHomePos 			: FB_VisuButtonTrigger;
	_btnCalibrateCamGripper		: FB_VisuButtonTrigger;
	_btnCalibrateCamAngled		: FB_VisuButtonTrigger;
	_btnMeasure 				: FB_VisuButtonTrigger;
	_btnFindCoils				: FB_VisuButtonTrigger;
	_btnPickCoil				: FB_VisuButtonTrigger;
	_btnPickDropCoil			: FB_VisuButtonTrigger;
	_btnRequestTopOfMaster		: FB_VisuButtonTrigger;
	_btnRequestDisable			: FB_VisuButtonTrigger;
	_btnDropCoil				: FB_VisuButtonTrigger;
	_btnDropCoilOnFloor			: FB_VisuButtonTrigger;
	_btnPickTopCoil				: FB_VisuButtonTrigger;
	_btnReleaseBuggy			: FB_VisuButtonTrigger;
	_btnClampBuggy				: FB_VisuButtonTrigger;
	_btnFindAndWait				: FB_VisuButtonTrigger;
	_btnPickDropFromPos			: FB_VisuButtonTrigger;
	_btnPickDropCardboard		: FB_VisuButtonTrigger;
	_btnCheckEmptyLayer			: FB_VisuButtonTrigger;
	_btnCheckEmptyLayerLaser	: FB_VisuButtonTrigger;
	_btnDropCardboard			: FB_VisuButtonTrigger;
	_btnMeasureCoilOrCardboard	: FB_VisuButtonTrigger;
	_btnCheckStorageOrientation	: FB_VisuButtonTrigger;

	_scRobotPosition 		: SC_RobotPosition;
	
	_scRobotPosRealsTemp	: SC_RobotPositionReals;
	
	_ascCamJobsToTry		: ARRAY [1..5] OF UINT;
	
	
END_VAR

// --- BEGIN IMPLEMENTATION ---

xManualMode := _fbManualMode.Mode = E_DefaultModes.Manual AND _fbManualMode.State = E_ModeStates.StandBy;

_btnRequestHomePos();
IF _btnRequestHomePos.RQ THEN
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualHomePosition);
END_IF

_btnCalibrateCamGripper();
IF _btnCalibrateCamGripper.RQ THEN
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualCalibrateCamGripper);
END_IF

_btnCalibrateCamAngled();
IF _btnCalibrateCamAngled.RQ THEN
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualCalibrateCamAngled);
END_IF

_btnMeasure();
IF _btnMeasure.RQ THEN
	_scRobotPosition.scRobotPosition := PersistentVars.scFeedrobot.RobotArm.MeasurePositionLeft;
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualMeasure, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnFindCoils();
IF _btnFindCoils.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualFindCoils, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnFindAndWait();
IF _btnFindAndWait.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualFindAndWait, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnPickCoil();
IF _btnPickCoil.RQ THEN
	//get robot orientation
	_scRobotPosRealsTemp := PersistentVars.scFeedRobot.RobotArm.refPosPickCoils;
	_scRobotPosRealsTemp.posX := _scRobotPosition.scRobotPosition.posX;
	_scRobotPosRealsTemp.posY := _scRobotPosition.scRobotPosition.posY;
	_scRobotPosRealsTemp.posZ := _scRobotPosition.scRobotPosition.posZ;
	_scRobotPosRealsTemp.posRX := _scRobotPosition.scRobotPosition.posRX;
	_scRobotPosRealsTemp.posRY := _scRobotPosition.scRobotPosition.posRY;
	_scRobotPosRealsTemp.posRZ := _scRobotPosition.scRobotPosition.posRZ;
	_scRobotPosRealsTemp.ToolID := _scRobotPosition.scRobotPosition.ToolID;
	//trensfrom to correct buggy side
	_scRobotPosition.scRobotPosition := _scRobotposrealstemp;
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualPickCoil, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnRequestTopOfMaster();
IF _btnRequestTopOfMaster.RQ THEN
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualTopOfMaster);
END_IF

_btnRequestDisable();
IF _btnRequestDisable.RQ THEN
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualDisable);
END_IF

_btnDropCoil();
IF _btnDropCoil.RQ THEN
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualDropCoil,pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnDropCoilOnFloor();
IF _btnDropCoilOnFloor.RQ THEN
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualDropFloor);
END_IF

_btnPickTopCoil();
IF _btnPickTopCoil.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualPickTopCoil, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnReleaseBuggy();
IF _btnReleaseBuggy.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualReleaseBuggy, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnClampBuggy();
IF _btnClampBuggy.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualClampBuggy, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnPickDropCoil();
IF _btnPickDropCoil.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualPickDropCoil, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnPickDropFromPos();
IF _btnPickDropFromPos.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualPickDropFromPos, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnPickDropCardboard();
IF _btnPickDropCardboard.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualPickDropCardboard, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnCheckEmptyLayer();
IF _btnCheckEmptyLayer.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualCheckEmptyLayer, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnCheckEmptyLayerLaser();
IF _btnCheckEmptyLayerLaser.RQ THEN
	//set job request
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualCheckEmptyLayerLaser, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnDropCardboard();
IF _btnDropCardboard.RQ THEN
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualDropCardboard, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnMeasureCoilOrCardboard();
IF _btnMeasureCoilOrCardboard.RQ THEN
	_scRobotPosition.scRobotPosition := PersistentVars.scFeedrobot.RobotArm.MeasurePositionLeft;
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualMeasureCoilOrCardboard, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF

_btnCheckStorageOrientation();
IF _btnCheckStorageOrientation.RQ THEN
	_scRobotPosition.scRobotPosition := PersistentVars.scFeedrobot.RobotArm.MeasurePositionCheckOrientation;
	_fbManualMode.SetRequest(iRequest := E_JobRequests.ManualCheckStorageOrientation, pData := ADR(_scRobotPosition), pSize := SIZEOF(_scRobotPosition));
END_IF
