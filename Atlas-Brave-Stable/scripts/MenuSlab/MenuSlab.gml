
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __       ______   ______    //
	// /\  ___\ /\ \     /\  __ \ /\  == \   //
	// \ \___  \\ \ \____\ \  __ \\ \  __<   //
	//  \/\_____\\ \_____\\ \_\ \_\\ \_____\ //
	//   \/_____/ \/_____/ \/_/\/_/ \/_____/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function MenuSlab(_config = {}) : IB_Entity(_config) constructor {
	
		var _self = self;
		
		// = PUBLIC ================
		static select	  = function() {
			__execute_callback();
		};
		static set_x_lerp = function(_x_lerp) {
			__.x_lerp = _x_lerp;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			static __execute_callback = function() {
				if (__.callback != undefined) {
					__.callback();	
				}	
			};
			static __set_stack_index  = function() {
				var _stack = get_owner();
				_stack.set_index(__.index);
			};
			static __mouse_touching   = function() {
				var _mx = device_mouse_x_to_gui(0);
				var _my = device_mouse_y_to_gui(0);
				return intersecting_point(_mx, _my);
			};
			static __mouse_moved	  = function() {
				return iceberg.input.mouse_did_move();
			};
			static __mouse_clicked    = function() {
				return device_mouse_check_button_pressed(0, mb_left);
			};
			static __update_lerp	  = function() {
				position_set_x(lerp(position_get_x(), __.x_lerp, __.lerp_speed));
			};
			
			index		 = _config[$ "index"	   ];
			callback	 = _config[$ "callback"    ] ?? undefined;
			text		 = _config[$ "text"		   ] ?? "";
			text_color	 = _config[$ "text_color"  ] ?? c_white;
			text_scale	 = _config[$ "text_scale"  ] ?? 1;
			text_padding = _config[$ "text_padding"] ?? 0 * text_scale;
			x_lerp		 = _config[$ "x"		   ] ?? _self.position_get_x();
			lerp_speed	 =  0.1;
		};
		
		// = EVENTS ================
		on_update	 (function() {
			if (__mouse_touching()) {
			//	if (__mouse_clicked()) select();
				if (__mouse_moved()) __set_stack_index();
			}
			__update_lerp();
		});
		on_render_gui(function() {
			render_bbox(,false);
			draw_text_transformed_color(
				position_get_x() + __.text_padding,
				position_get_center_v(), 
				__.text, 
				__.text_scale,
				__.text_scale,
				0,
				__.text_color,
				__.text_color,
				__.text_color,
				__.text_color,
				1,
			);
		});
	};
	