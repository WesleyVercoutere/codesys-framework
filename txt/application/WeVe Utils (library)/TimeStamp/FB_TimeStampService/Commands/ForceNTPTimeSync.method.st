METHOD ForceNTPTimeSync : E_TaskStatus
VAR
	E_TaskFeedback			: E_TaskStatus;
END_VAR

// --- BEGIN IMPLEMENTATION ---

ForceNTPTimeSync := E_TaskStatus.Busy;

CASE _wForceNTPTimeSyncState OF
	
	0: 	
		E_TaskFeedback := SetTimeBase(eTimeBase := E_TimeBase.Manual);
			
		IF E_TaskFeedback = E_TaskStatus.Successful THEN
			_wForceNTPTimeSyncState := _wForceNTPTimeSyncState + 10;
		ELSIF E_TaskFeedback = E_TaskStatus.Failed THEN
			_wForceNTPTimeSyncState := 100;
		END_IF
		
		
	10:
		E_TaskFeedback := SetTimeBase(eTimeBase := E_TimeBase.NTP);
		
		IF E_TaskFeedback = E_TaskStatus.Successful THEN
			_wForceNTPTimeSyncState := _wForceNTPTimeSyncState + 10;
		ELSIF E_TaskFeedback = E_TaskStatus.Failed THEN
			_wForceNTPTimeSyncState := 100;
		END_IF
		
		
	20:
		ForceNTPTimeSync := E_TaskStatus.Successful;
		_wForceNTPTimeSyncState := 0;
		
		
	100:
		ForceNTPTimeSync := E_TaskStatus.Failed;
		_wForceNTPTimeSyncState := 0;	
		
END_CASE
