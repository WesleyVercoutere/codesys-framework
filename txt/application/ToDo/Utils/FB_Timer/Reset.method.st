METHOD Reset
VAR_INPUT
END_VAR

// --- BEGIN IMPLEMENTATION ---

_tStart := TO_TIME(SysTimeGetMs());
_tEnd := TO_TIME(SysTimeGetMs());
_tDelta := T#0MS;
_tPrevious := T#0MS;
_tTotal := T#0MS;
