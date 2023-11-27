
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______   ______   ______    //
	// /\  ___\ /\ \/\ \ /\  == \ /\  ___\ /\  __ \ /\  == \   //
	// \ \ \____\ \ \_\ \\ \  __< \ \___  \\ \ \/\ \\ \  __<   //
	//  \ \_____\\ \_____\\ \_\ \_\\/\_____\\ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_/ /_/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_character_cursor.create //
	event_inherited();
	var _self = self;
	var _data = self[$ "data"] ?? self;
	
	#region character
	
		// public
		character_get = function() {
			return __.character.instance;
		};
		
		// private
		__[$ "character"] ??= {};
		with (__.character) {
			instance = _data[$ "character"] ?? undefined;	
		};
	
	#endregion
	#region state
	
		// public
		state_get = function() {
			return __.state.fsm.get_current_state();	
		};
		state_set = function(_state_name) {
			__.state.fsm.change(_state_name);
			return self;
		};
		state_is  = function(_state_name) {
			return __.state.fsm.state_is(_state_name);	
		};
	
		// private
		__[$ "state"] ??= {};
		with (__.state) {
			fsm = new SnowState("__", false, {
				owner: _self,
			});
			fsm.add		 ("__",			   {
				enter: function() {},
				step:  function() {},
				leave: function() {},
			});
			fsm.add_child("__", "mouse",   {
				enter: function() {
					__.state.fsm.inherit();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					// x & y is the average of all mouse devices
					var _character =  character_get();
					var _devices   = _character.input_get_devices();
					var _count	   =  0;
					var _x_sum	   =  0;
					var _y_sum	   =  0;
					
					for (var _i = 0, _len = array_length(_devices); _i < _len; _i++) {
						var _device = _devices[_i];
						if (_device.get_type() == "keyboard_mouse"
						||	_device.get_type() == "mouse"
						) {
							_x_sum += _device.get_x();
							_y_sum += _device.get_y();
							_count++;
						}
					};
					
					if (_count > 0) {
						_x_sum /= _count;	
						_y_sum /= _count;	
					}
					
					x = _x_sum;
					y = _y_sum;
				},
				leave: function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("__", "gamepad", {
				enter: function() {
					__.state.fsm.inherit();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					var _character =  character_get();
					var _devices   = _character.input_get_devices();
					var _count	   =  0;
					var _x_sum	   =  0;
					var _y_sum	   =  0;
					
					for (var _i = 0, _len = array_length(_devices); _i < _len; _i++) {
						var _device = _devices[_i];
						if (_device.get_type() == "gamepad") {
							_x_sum += _device.get_axis_value(gp_axislh);
							_y_sum += _device.get_axis_value(gp_axislv);
							_count++;
						}
					};
					
					if (_count > 0) {
						_x_sum /= _count;	
						_y_sum /= _count;	
					}
					
					x = _character.position_get_x() + (_x_sum * get_distance());
					y = _character.position_get_y() + (_y_sum * get_distance());
					
				},
				leave: function() {
					__.state.fsm.inherit();
				},
			});
		};
		
		// events
		on_initialize(function() {
			var _character = character_get();
			if (_character.input_has_device_type("gamepad")) {
				__.state.fsm.change("gamepad");
			}
			else {
				__.state.fsm.change("mouse");
			}
		});
		on_update	 (function() {
			__.state.fsm.step();
		});
	
	#endregion
	#region properties
	
		// public
		get_distance = function() {
			return __.properties.distance;	
		};
		set_distance = function(_distance) {
			__.properties.distance = _distance;
			return self;
		};
	
		// private
		__[$ "properties"] ??= {};
		with (__.properties) {
			distance = _data[$ "distance"] ?? 20;	
		};
	
	#endregion
	
	