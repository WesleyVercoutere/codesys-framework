METHOD UserRequest : BOOL
VAR_INPUT
	nRequest	: UINT;
	pData		: POINTER TO ARRAY [0..255] OF BYTE := 0;
	pSize		: ULINT := 0;
END_VAR
