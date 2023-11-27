	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __       ______   ______    //
	// /\  ___\ /\  __ \ /\ \     /\  __ \ /\  == \   //
	// \ \ \____\ \ \/\ \\ \ \____\ \ \/\ \\ \  __<   //
	//  \ \_____\\ \_____\\ \_____\\ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function ColorFlash(_config = {}) : IB_Base(_config) constructor {
		
		// public
		static flash		 = function(_color = __.color, _alpha = __.alpha_max, _duration = __.duration) {
			set_color(_color);
			__.alpha = _alpha;
			__.timer.set_period(_duration);
			__.timer.start();
			return self;
		};
		static set_alpha_min = function(_alpha) {
			__.alpha_min = _alpha;
			return self;
		};
		static set_alpha_max = function(_alpha) {
			__.alpha_max = _alpha;
			return self;	
		};
		static set_color	 = function(_color) {
			if (__.color != _color) {
				__.color   = _color;
				__.color_r =  color_get_red  (_color);
				__.color_g =  color_get_green(_color);
				__.color_b =  color_get_blue (_color);
			}
			return self;
		};
		static set_duration  = function(_duration) {
			__.duration = _duration;
			return self;
		};
		
		// private
		with (__) {
			static __shader = IB_Shader_ColorBlend;
			
			alpha_max = _config[$ "alpha_max"] ?? 1.0;
			alpha_min = _config[$ "alpha_min"] ?? 0.0;
			color	  = _config[$ "color"	 ] ?? c_white;
			duration  = _config[$ "duration" ] ?? 15;
			
			alpha		   = 0.0;
			color_r		   = color_get_red  (color); 
			color_g		   = color_get_green(color);
			color_b		   = color_get_blue (color);
			u_color		   = shader_get_uniform(__shader, "u_color");
			u_blend_amount = shader_get_uniform(__shader, "u_blend_amount");
			timer		   = new IB_TimeSource({
				period:		 duration,
				repetitions: 1,
			});
		};
		
		// events
		on_initialize  (function() {
			__.timer.initialize();
		});
		on_update	   (function() {
			if (__.timer.is_running()) {
				__.alpha = iceberg.math.remap(
					0, 
					1, 
					__.alpha_min, 
					__.alpha_max, 
					__.timer.get_percent_completed()
				);
			}
		});
		on_render_begin(function() {
			if (__.alpha > 0) {
				shader_set(__shader);
				shader_set_uniform_f_array(__.u_color, [
					__.color_r, __.color_g, __.color_b,
				]);
				shader_set_uniform_f(__.u_blend_amount, __.alpha);
			}
		});
		on_render_end  (function() {
			if (__.alpha > 0) {
				shader_reset();	
			}
		});
		on_cleanup	   (function() {
			__.timer.cleanup();
		});
	};
	