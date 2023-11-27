
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   __  __   ______   ______    //
	// /\ "-./  \ /\  __ \ /\ \/\ \ /\  ___\ /\  ___\   //
	// \ \ \-./\ \\ \ \/\ \\ \ \_\ \\ \___  \\ \  __\   //
	//  \ \_\ \ \_\\ \_____\\ \_____\\/\_____\\ \_____\ //
	//   \/_/  \/_/ \/_____/ \/_____/ \/_____/ \/_____/ //
	//                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Device_Mouse(_config = {}) : __IB_System_Input_Device(_config) constructor {

		// public
		static get_x		   = function() {
			return __.pos.x.current;
		};
		static get_y		   = function() {
			return __.pos.y.current;
		};
		static get_description = function() {
			return __.desc;	
		};
		static is_moving	   = function() {
			return (__.pos.x.current != __.pos.x.previous 
				||	__.pos.y.current != __.pos.y.previous
			);
		};

		// private
		with (__) {
			static __update_pos = function() {
				__.pos.x.previous = __.pos.x.current;
				__.pos.y.previous = __.pos.y.current;
				__.pos.x.current  = device_mouse_x(__.device_index);
				__.pos.y.current  = device_mouse_y(__.device_index);	
			};
				
			type = "mouse";
			desc = "Mouse";
			pos  = {
				x: {
					current:  0,
					previous: 0,
				},
				y: {
					current:  0,
					previous: 0,
				},
			};
		};
		
		// events
		on_initialize(function() {
			__update_pos();
		});
		on_update	 (function() {
			__update_pos();
		});
	};