
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \ /\  ___\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \\ \  __\\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_\   \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/ \/_/    \/_/ \/_____/ \/_____/ //
	//                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerProfile(_config = {}) constructor {
		
		// public
		static create			= function(_name, _port) {
			__.name			 =  _name;
			__.input_port	 =  _port;
			__.input_profile = __new_input_profile(_name, _port);
			__.color		 = __get_default_color();
			return self;
		};
		static save_to_disk		= function() {};	
		static load_from_disk	= function(_name, _port) {};
		static delete_from_disk	= function(_wipe_data = true) {};
		
		static get_name			= function() {
			return __.name;
		};
		static get_path			= function() {
			return __.path;
		};
		static get_color		= function() {
			return __.color;	
		};
			
		// private
		__ = {};
		with (__) {
			static __get_default_color = function() {
				switch (__.input_port) {
					case 0:  return COLOR_RED;	
					case 1:  return COLOR_BLUE;	
					case 2:  return COLOR_GREEN;	
					case 3:  return COLOR_YELLOW;	
					default: return COLOR_WHITE;
				};
			};
			static __new_input_profile = function(_name, _port) {
				if (__.input_profile != undefined) {
					__.input_profile.cleanup();	
				}
				__.input_profile = iceberg.input.profile_new(_name, _port);
				return __.input_profile;
			};
			
			input_port	  = _config[$ "input_port"] ?? -1;
			color		  = _config[$ "color"	  ] ??  COLOR_WHITE;
			version		  = "0.1";
			name		  = "";
			path		  = "";
			input_profile = undefined;
		};
		
		// events
		static initialize = function() {
			__.color = __get_default_color();	
		};
		static cleanup	  = function() {
			if (__.input_profile != undefined) {
				__.input_profile.cleanup();	
			}
		};
	};
	