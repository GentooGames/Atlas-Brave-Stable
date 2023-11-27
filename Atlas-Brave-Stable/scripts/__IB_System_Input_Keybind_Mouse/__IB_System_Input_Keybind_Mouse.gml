
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   __  __   ______   ______    //
	// /\ "-./  \ /\  __ \ /\ \/\ \ /\  ___\ /\  ___\   //
	// \ \ \-./\ \\ \ \/\ \\ \ \_\ \\ \___  \\ \  __\   //
	//  \ \_\ \ \_\\ \_____\\ \_____\\/\_____\\ \_____\ //
	//   \/_/  \/_/ \/_____/ \/_____/ \/_____/ \/_____/ //
	//                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Keybind_Mouse(_config = {}) : __IB_System_Input_Keybind(_config) constructor {

		// public
		static check_pressed  = function(_device_index) {
			return __check(device_mouse_check_button_pressed, _device_index);
		};
		static check_down	  = function(_device_index) {
			return __check(device_mouse_check_button, _device_index);
		};
		static check_released = function(_device_index) {
			return __check(device_mouse_check_button_released, _device_index);
		};
		static wheel_down	  = function() {};
		static wheel_up		  = function() {};
		
		// private
		with (__) {
			static __check = function(_button_function, _device_index) {
				for (var _i = 0; _i < __.keys_count; _i++) {
					var _key    = __.keys[_i];
					var _result = _button_function(_device_index, _key);
					if (__check_operator(_result)) {
						return true;	
					}
				};
				return false;
			};
			
			type = "mouse";
		};
	};