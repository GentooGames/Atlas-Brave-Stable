
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __     __   ______   ______   __   __    //
	// /\__  _\/\ \  _ \ \ /\  ___\ /\  ___\ /\ "-.\ \   //
	// \/_/\ \/\ \ \/ ".\ \\ \  __\ \ \  __\ \ \ \-.  \  //
	//    \ \_\ \ \__/".~\_\\ \_____\\ \_____\\ \_\\"\_\ //
	//     \/_/  \/_/   \/_/ \/_____/ \/_____/ \/_/ \/_/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function ITweenConfig(_config = {}) constructor {
													
		curve_index		= _config[$ "curve_index"	] ?? crv_curves;
		curve_channel	= _config[$ "curve_channel"	] ?? "quint";
		ease_function	= _config[$ "ease_function"	] ?? undefined;
													
		value_begin		= _config[$ "value_begin"	] ?? 0;
		value_end		= _config[$ "value_end"		] ?? 1;
		duration		= _config[$ "duration"		] ?? 1;
													
		direction		= _config[$ "direction"		] ?? undefined; //*new
		distance		= _config[$ "distance"		] ?? undefined; //*new
													
		var_owner		= _config[$ "var_owner"		] ?? undefined; 
		var_name		= _config[$ "var_name"		] ?? undefined;
													
		auto_destroy	= _config[$ "auto_destroy"	] ?? true;
	};												
	
	