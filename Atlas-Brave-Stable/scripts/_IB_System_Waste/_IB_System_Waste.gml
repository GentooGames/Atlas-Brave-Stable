
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __     __   ______   ______   ______  ______    //
	// /\ \  _ \ \ /\  __ \ /\  ___\ /\__  _\/\  ___\   //
	// \ \ \/ ".\ \\ \  __ \\ \___  \\/_/\ \/\ \  __\   //
	//  \ \__/".~\_\\ \_\ \_\\/\_____\  \ \_\ \ \_____\ //
	//   \/_/   \/_/ \/_/\/_/ \/_____/   \/_/  \/_____/ //
	//                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_System_Waste(_config = {}) : _IB_System(_config) constructor {

		// public
		static flag_for_cleanup = function(_instance, _callback = undefined) {
			var _data = { 
				instance: _instance, 
				callback: _callback,
			};
			if ( instanceof(_instance) == "instance") {
				 array_push(__.object_queue, _data);
			}
			else array_push(__.constructor_queue, _data);
		};

		// private
		with (__) {	
			static __empty_waste = function() {
				// empty objects
				iceberg.array.for_each(__.object_queue, function(_data) {
					var _instance  = _data.instance;
					var _callback  = _data.callback;
					if (_callback !=  undefined) {
						_callback();
					}
					if (instance_exists(_instance)) {
						instance_destroy(_instance);
					}
				});
				__.object_queue = [];
			
				// empty constructors
				iceberg.array.for_each(__.constructor_queue, function(_data) {
					var _instance  = _data.instance;
					var _callback  = _data.callback;
					if (_callback !=  undefined) {
						_callback();
					}
				});
				__.constructor_queue = [];
			};
			
			object_queue	  = [];
			constructor_queue = [];
			
			// state
			state.fsm.add_child("__", "running", {
				begin_step: function() {
					__.state.fsm.inherit();
					__empty_waste();
				},
			});
		};
	};

