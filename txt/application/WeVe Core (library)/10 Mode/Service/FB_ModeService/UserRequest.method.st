METHOD UserRequest
VAR_INPUT
	nRequest	: UINT;
	pData		: POINTER TO ARRAY [0..255] OF BYTE := 0;
	pSize		: ULINT := 0;
END_VAR

// --- BEGIN IMPLEMENTATION ---

IF _afbModes[_nActiveMode] <> 0 THEN
	_afbModes[_nActiveMode].UserRequest(nRequest := nRequest, pData := pData,  pSize := pSize);
END_IF
