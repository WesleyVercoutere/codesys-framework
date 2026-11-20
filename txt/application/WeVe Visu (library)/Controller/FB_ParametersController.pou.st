FUNCTION_BLOCK FB_ParametersController
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbParameterSrv 			: I_ParameterService;
	
	_btnLoadDefaultParameters 	: FB_VisuButtonTrigger;
	_aiNumber 					: ARRAY[1..3] OF INT := [1,2,3];
END_VAR

// --- BEGIN IMPLEMENTATION ---

_btnLoadDefaultParameters();

IF _btnLoadDefaultParameters.RQ THEN
	_fbParameterSrv.LoadDefaultRecipeSettings();
	_fbParameterSrv.LoadDefaultSystemSettings();
END_IF
