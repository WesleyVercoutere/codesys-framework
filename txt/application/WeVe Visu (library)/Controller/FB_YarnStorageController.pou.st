FUNCTION_BLOCK FB_YarnStorageController
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbYarnStorageSrv 			: I_YarnStorageService;
	
	_btnClearStorage 			: FB_VisuButtonTrigger;
	_btnNewPallet				: FB_VisuButtonTrigger;
	_fbStorage 					: I_YarnStorageModule;
	
	_iStorage 					: E_UserFrame;
	_aState 					: ARRAY[1..2] OF E_StorageState;
	_NbrOfCoilsBase				: UINT;
	_NbrOfCoilsInverted			: UINT;
	_ascCoilPositionsBase		: ARRAY [0..cMaxNbrCoilPositions] OF SC_RobotPositionReals;
	_ascCoilPositionsInverted	: ARRAY [0..cMaxNbrCoilPositions] OF SC_RobotPositionReals;
	
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _iStorage < 1 OR _iStorage > 8 THEN
	_iStorage := 1;
END_IF

_aState := _fbYarnStorageSrv.GetStates(_iStorage);

_NbrOfCoilsBase		:= _fbYarnStorageSrv.NbrOfCoils(eStorage := _iStorage, eSide := E_FrameSide.Base);
//_NbrOfCoilsInverted :=_fbYarnStorageSrv.NbrOfCoils(eStorage := _iStorage, eSide := E_FrameSide.Inverted);

_ascCoilPositionsBase := _fbYarnStorageSrv.GetRobotPositions(eStorage := _iStorage, eSide := E_FrameSide.Base);
//_ascCoilPositionsInverted := _fbYarnStorageSrv.GetRobotPositions(eStorage := _iStorage, eSide := E_FrameSide.Inverted);


_btnClearStorage();
IF _btnClearStorage.RQ THEN
	_fbStorage := _fbYarnStorageSrv.GetStorage(id := _iStorage);
	_fbStorage.SetSideState(eSide := 1, eState := E_StorageState.New);
	_fbStorage.SetSideState(eSide := 2, eState := E_StorageState.New);
	_fbStorage.ResetData();
END_IF

_btnNewPallet();
IF _btnNewPallet.RQ THEN
	_fbStorage := _fbYarnStorageSrv.GetStorage(id := _iStorage);
	_fbStorage.SetSideState(eSide := 1, eState := E_StorageState.New);
	_fbStorage.SetSideState(eSide := 2, eState := E_StorageState.New);
	_fbStorage.ResetData();
END_IF
