
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __   __    //
	// /\  ___\ /\  __ \ /\ \ /\ "-.\ \   //
	// \ \ \____\ \ \/\ \\ \ \\ \ \-.  \  //
	//  \ \_____\\ \_____\\ \_\\ \_\\"\_\ //
	//   \/_____/ \/_____/ \/_/ \/_/ \/_/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function coin_create(_x, _y, _config = {}, _initialize = true) {
		
		var _coin = instance_create_depth(_x, _y, 0, obj_coin, _config);
		
		if (_initialize) _coin.initialize();
		
		return _coin;
		
	};