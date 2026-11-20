FUNCTION_BLOCK FB_JobManagerController
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	_fbJobSrv 				: I_JobService;
	
	_eJobType 				: E_JobRequests;
	_scJob 					: SC_JobRequest;
	
	_ascSrvJobs 			: ARRAY [1..cMaxNbrOfJobs] OF SC_JobRequest;
	_ascJobs 				: ARRAY [1..cMaxNbrOfJobs] OF SC_VisuJobInfo;
	_scEmptyJob 			: SC_VisuJobInfo;
	
	_i 						: UINT;
	
END_VAR

// --- BEGIN IMPLEMENTATION ---

_ascSrvJobs := _fbJobSrv.GetJobs();

FOR _i := 1 TO cMaxNbrOfJobs DO

	IF _ascSrvJobs[_i].eState <> E_JobStates.None THEN
		_ascJobs[_i].eJobType 		:= _ascSrvJobs[_i].eType;
		_ascJobs[_i].eJobState 		:= _ascSrvJobs[_i].eState;
		_ascJobs[_i].eJobPriority 	:= _ascSrvJobs[_i].ePriority;
		_ascJobs[_i].eFrame 		:= _ascSrvJobs[_i].scPosition.eStorage;
		_ascJobs[_i].eSide 			:= _ascSrvJobs[_i].scPosition.eSide;
	ELSE
		_ascJobs[_i] := _scEmptyJob;
	END_IF

END_FOR
