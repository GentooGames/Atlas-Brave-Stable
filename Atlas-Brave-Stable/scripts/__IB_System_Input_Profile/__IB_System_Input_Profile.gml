
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \ /\  ___\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \\ \  __\\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_\   \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/ \/_/    \/_/ \/_____/ \/_____/ //
	//                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Profile(_config = {}) : IB_Base(_config) constructor {
	
		// public
		static keybindings_get	= function() {
			return __.keybindings;	
		};
		static keybindings_set	= function(_keybindings_struct) {
			__.keybindings.keybindings_set(_keybindings_struct);
			return self;
		};
		static deadzone_get		= function() {
			return __.gamepad_deadzone;	
		};
		static deadzone_set		= function(_deadzone) {
			__.gamepad_deadzone = _deadzone;
			return self;
		};
		
		static save_to_disk		= function() {};
		static load_from_disk	= function() {};
		static delete_from_disk = function() {};
		
		// private
		with (__) {
			cursor_accel	 = _config[$ "cursor_accel"	   ] ?? iceberg.input.__.cursor_accel_default;
			cursor_fric		 = _config[$ "cursor_fric"	   ] ?? iceberg.input.__.cursor_fric_default;
			cursor_sense	 = _config[$ "cursor_sense"	   ] ?? iceberg.input.__.cursor_sense_default;
			gamepad_deadzone = _config[$ "gamepad_deadzone"] ?? iceberg.input.__.gamepad_deadzone_default;
			port_index		 = _config[$ "port_index"	   ] ?? undefined;
			keybindings		 =  new __IB_System_Input_Keybindings({
				keybindings: iceberg.input.__.keybindings
			});
		};
			
		// events
		on_initialize(function() {
			__.keybindings.initialize();
		});
		on_cleanup   (function() {
			__.keybindings.cleanup();
		});
	};

