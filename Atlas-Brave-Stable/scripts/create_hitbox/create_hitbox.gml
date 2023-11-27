
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   __   ______  ______   ______   __  __    //
	// /\ \_\ \ /\ \ /\__  _\/\  == \ /\  __ \ /\_\_\_\   //
	// \ \  __ \\ \ \\/_/\ \/\ \  __< \ \ \/\ \\/_/\_\/_  //
	//  \ \_\ \_\\ \_\  \ \_\ \ \_____\\ \_____\ /\_\/\_\ //
	//   \/_/\/_/ \/_/   \/_/  \/_____/ \/_____/ \/_/\/_/ //
    //													  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function create_hitbox(_x, _y, _owner, _config = {}, _initialize = true) {
	
		// enforced params
		_config[$ "owner"] = _owner;
	
		print(_x);
	
		var _hitbox = instance_create_depth(_x, _y, 0, obj_hitbox, _config);
		
		if (_initialize) _hitbox.initialize();
		
		return _hitbox;
	};
	