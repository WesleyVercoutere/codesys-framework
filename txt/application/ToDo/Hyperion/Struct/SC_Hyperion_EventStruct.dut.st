TYPE SC_Hyperion_EventStruct :
STRUCT
	Counter : UDINT;	(* uint32 *)
	Level : USINT;	(* uint8 *)
	Dummy1 : USINT;
	Dummy2 : USINT;
	Dummy3 : USINT;
	Identification : UDINT;	(* uint32 *)
	PayLoad : ARRAY[1..64] OF BYTE;	(* 64 * uint8 *)
	TimeStamp : STRING(23);	(* yyyy-mm-dd-hh:mm:ss.aaa = 23 characters *)
END_STRUCT
END_TYPE
