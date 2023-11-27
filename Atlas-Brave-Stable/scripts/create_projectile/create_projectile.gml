
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______      __   ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \    /\ \ /\  ___\ /\  ___\ /\__  _\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \  _\_\ \\ \  __\ \ \ \____\/_/\ \/\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\/\_____\\ \_____\\ \_____\  \ \_\ \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/\/_____/ \/_____/ \/_____/   \/_/  \/_/ \/_____/ \/_____/ //
	//                                                                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function create_projectile(_x, _y, _owner, _config = {}, _initialize = true) {

		// enforced params
		_config[$ "owner"] = _owner;
		
		var _projectile = instance_create_depth(_x, _y, 0, objp_projectile, _config);
		
		if (_initialize) _projectile.initialize();
		
		return _projectile;
	};