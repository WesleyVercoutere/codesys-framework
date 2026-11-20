{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_TaskStatus :
(
	NotStarted := 0,		// Task has not yet began (default value)
	Start,					// Task start external request
	Busy,					// Task is busy
	Successful,				// Task ended successful
	Failed,					// Task ended failure
	Tolerated,				// Task ended failure, but failure is tolerated
	Error,					// Task experiences error
	Interrupted,			// Task was interrupted
	Skipped,				// Task was skipped
	Timeout					// Task timed out
);
END_TYPE
