	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __    __   ______   __  __   __    //
	// /\ \ /\ "-./  \ /\  ___\ /\ \/\ \ /\ \   //
	// \ \ \\ \ \-./\ \\ \ \__ \\ \ \_\ \\ \ \  //
	//  \ \_\\ \_\ \ \_\\ \_____\\ \_____\\ \_\ //
	//   \/_/ \/_/  \/_/ \/_____/ \/_____/ \/_/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_imgui.create //
	event_inherited();
	
	var _self = self;
	
	// = PRIVATE ===============
	with (__) {
		file	= {};
		debug	= {};
		window	= {};
		rooms	= {};
		players = {};
		
		with (file	 ) {};
		with (debug	 ) {
			overlay_visible = false;
		};
		with (window ) {
			pos_x		   = window_get_x();
			pos_y		   = window_get_y();
			pos_target_x   = pos_x;
			pos_target_y   = pos_y;
			pos_lerp_speed = 0.2;
			update		   = method(_self, function() {
				__.window.pos_x = lerp(__.window.pos_x, __.window.pos_target_x, __.window.pos_lerp_speed);
				__.window.pos_y = lerp(__.window.pos_y, __.window.pos_target_y, __.window.pos_lerp_speed);
				if (abs(__.window.pos_x - __.window.pos_target_x) >= 1
				||	abs(__.window.pos_y - __.window.pos_target_y) >= 1
				) {
					window_set_position(__.window.pos_x, __.window.pos_y);
				}
			});
			snap_to		   = method(_self, function(_x = window_get_x(), _y = window_get_y()) {
				__.window.pos_x			= window_get_x();	
				__.window.pos_y			= window_get_y();	
				__.window.pos_target_x	= _x;
				__.window.pos_target_y	= _y;
			});
		};
		with (rooms  ) {
			combo_select_index = 0;
		};
		with (players) {
			character = {
				type_combo_select_index: 0,	
			};
		};
		
		// = EVENTS ============
		// move into pubic!

		_self.on_update_begin(method(_self, function() {
			__.window.update();
		}));

	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	