
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______  ______  //
	// /\  == \/\  __ \ /\  == \/\__  _\ //
	// \ \  _-/\ \ \/\ \\ \  __<\/_/\ \/ //
	//  \ \_\   \ \_____\\ \_\ \_\ \ \_\ //
	//   \/_/    \/_____/ \/_/ /_/  \/_/ //
	//                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Port(_config = {}) : IB_Base(_config) constructor {
		
		// public
		static check_pressed		 = function(_verb) {
			if (is_active()) {
				return __input_devices_check_pressed(_verb);
			}
			return false;
		};
		static check_down			 = function(_verb) {
			if (is_active()) {
				return __input_devices_check_down(_verb);
			}
			return false;
		};
		static check_released		 = function(_verb) {
			if (is_active()) {
				return __input_devices_check_released(_verb);
			}
			return false;
		};
									 
		static devices_add			 = function(_input_device) {
			if (devices_contains(_input_device) == false) {
				array_push(__.input_devices, _input_device);
				__.device_count++;
			}
			return self;
		};
		static devices_set			 = function(_input_devices_array) {
			__.input_devices = _input_devices_array;
			__.device_count  =  array_length(__.input_devices);
			return self;
		};
		static devices_clear		 = function() {
			__.input_devices = [];
			__.device_count  = 0;
			return self;
		};
		static devices_remove		 = function(_input_device) {
			if (devices_contains(_input_device)) {
				iceberg.array.find_delete(__.input_devices, _input_device);
				__.device_count--;
			}
			return self;
		};
		static devices_get			 = function() {
			return __.input_devices;	
		};
		static devices_get_count	 = function() {
			return __.device_count;	
		};
		static devices_contains		 = function(_input_device = undefined) {
			if (_input_device == undefined) {
				return __.device_count > 0;	
			}
			return iceberg.array.contains(__.input_devices, _input_device);
		};
		static devices_contains_type = function(_input_device_type) {
			for (var _i = 0; _i < __.device_count; _i++) {
				var _device = __.input_devices[_i];
				if (_device.get_type() == _input_device_type) {
					return true;	
				}
			};
			return false;
		};
		
		static profile_get			 = function() {
			return __.profile;	
		};
		static profile_set			 = function(_profile) {
			__.profile = _profile;
			return self;
		};
		
		// private
		with (__) {
			static __input_devices_check_pressed  = function(_verb) {
				if (__.input_devices != undefined) {
					for (var _i = 0; _i < __.device_count; _i++) {
						var _device  = __.input_devices[_i];
						if (__.profile != undefined) {
							if (_device.check_pressed(_verb, __.profile.keybindings_get())) {
								return true;	
							}
						}
						else if (_device.check_pressed(_verb)) {
							return true;	
						}
					};
				}
				return false;
			};
			static __input_devices_check_down	  = function(_verb) {
				if (__.input_devices != undefined) {
					for (var _i = 0; _i < __.device_count; _i++) {
						var _device  = __.input_devices[_i];
						if (__.profile != undefined) {
							if (_device.check_down(_verb, __.profile.keybindings_get())) {
								return true;	
							}
						}
						else if (_device.check_down(_verb)) {
							return true;	
						}
					};
				}
				return false;
			};
			static __input_devices_check_released = function(_verb) {
				if (__.input_devices != undefined) {
					for (var _i = 0; _i < __.device_count; _i++) {
						var _device  = __.input_devices[_i];
						if (__.profile != undefined) {
							if (_device.check_released(_verb, __.profile.keybindings_get())) {
								return true;	
							}
						}
						else if (_device.check_released(_verb)) {
							return true;	
						}
					};
				}
				return false;
			};
			
			port_index	  = _config[$ "port_index"   ] ?? iceberg.input.__.ports.get_size();
			input_devices = _config[$ "input_devices"] ?? undefined;
			profile		  = _config[$ "profile"      ] ?? undefined;
			device_count  =  0;
		};
		
		// events
		on_deactivate(function() {
			__.input_devices = [];
			__.profile		 = undefined;
			__.device_count  = 0;
		});
	};

	