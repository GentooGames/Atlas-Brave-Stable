
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   ______  ______   __    __    //
	// /\ \ /\__  _\/\  ___\ /\ "-./  \   //
	// \ \ \\/_/\ \/\ \  __\ \ \ \-./\ \  //
	//  \ \_\  \ \_\ \ \_____\\ \_\ \ \_\ //
	//   \/_/   \/_/  \/_____/ \/_/  \/_/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function item_create(_uid, _x, _y, _config = {}, _initialize = true) {
		
		_config[$ "uid"] = _uid;
		
		var _item = instance_create_depth(_x, _y, 0, obj_item, _config);
		
		if (_initialize) _item.initialize();
		
		return _item;
		
	};
	