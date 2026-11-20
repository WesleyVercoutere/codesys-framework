FUNCTION_BLOCK ABSTRACT FB_MovingAverage IMPLEMENTS I_MovingAverage
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR CONSTANT
	cMaxNbrOfEntries 	: UINT := 100;
END_VAR
VAR
	_scSysPar 			: SC_SystemParametersMovingAverage;
	
	_alrValues 			: ARRAY[1..cMaxNbrOfEntries] OF LREAL;
	_lrAverage 			: LREAL;
	_iNbrOfItems 		: UINT;
	_iInsertIndex 		: UINT;
	_iNbrOfItemsInList 	: UINT;
END_VAR

// --- BEGIN IMPLEMENTATION ---

(*

	def calculate_ema(data, N):
		multiplier = 2 / (N + 1)
		ema = data[0]  # Initialize EMA with the first data point
		for i in range(1, len(data)):
			ema = (data[i] * multiplier) + (ema * (1 - multiplier))
		return ema
	
	# Example usage:
	data = [50.0, 52.0, 53.5, 55.0, 56.5]
	N = 3  # Number of periods for EMA
	ema_result = calculate_ema(data, N)
	print(f"The EMA({N}) is: {ema_result}")

*)


CheckNumberOfItems();
CalculateAverage(alrValues := _alrValues);
