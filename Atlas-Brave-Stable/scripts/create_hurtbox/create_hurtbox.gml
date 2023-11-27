
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   __  __   ______  ______  ______   ______   __  __    //
	// /\ \_\ \ /\ \/\ \ /\  == \/\__  _\/\  == \ /\  __ \ /\_\_\_\   //
	// \ \  __ \\ \ \_\ \\ \  __<\/_/\ \/\ \  __< \ \ \/\ \\/_/\_\/_  //
	//  \ \_\ \_\\ \_____\\ \_\ \_\ \ \_\ \ \_____\\ \_____\ /\_\/\_\ //
	//   \/_/\/_/ \/_____/ \/_/ /_/  \/_/  \/_____/ \/_____/ \/_/\/_/ //
	//                                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function create_hurtbox(_x, _y, _owner, _config = {}, _initialize = true) {
		
		// enforced params
		_config[$ "owner"] = _owner;
		
		// create hurtbox instance
		var _hurtbox = instance_create_depth(_x, _y, 0, obj_hurtbox, _config);
		
		// assign collision data
		if (_config[$ "collision_objects"] != undefined) {
			var _collision_objects = _config.collision_objects;
			for (var _i = 0, _len_i = array_length(_collision_objects); _i < _len_i; _i++) {
			
				var _data = _collision_objects[_i];
				
				_hurtbox.collision_object_add(_data.index, _data.on_start, _data.on_stop, {
					ordered:		  _data[$ "ordered"		    ] ??  false,
					repetitions_per:  _data[$ "repetitions_per" ] ?? -1,
					repetitions_max:  _data[$ "repetitions_max" ] ?? -1,
					repetitions_rate: _data[$ "repetitions_rate"] ??  1,
				});
			
				// inject collision filter data into hitbox instance
				if (_data[$ "filter"] != undefined) {
				
					var _filter_name   = _data.filter.name;
					var _filter_method = _data.filter.condition;
				
					_hurtbox.collision_filter_set(_data.index, _filter_name, _filter_method);
				}
			};
		}
		
		if (_initialize) _hurtbox.initialize();
		
		return _hurtbox;
	};
	