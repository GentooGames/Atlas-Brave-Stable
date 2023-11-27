
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______    //
	// /\  == \/\  __ \ /\  ___\ /\  ___\   //
	// \ \  _-/\ \  __ \\ \ \__ \\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/\/_/ \/_____/ \/_____/ //
	//                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage(_config = {}) : IB_Entity(_config) constructor {

		var _self = self;
		
		// private
		with (__) {
			static __get_player			  = function() {
				return __.panel.get_player();
			};
			static __render_banner		  = function(_config = {}) {
				
				_config[$ "banner_color"		] ??= c_black;
				_config[$ "banner_alpha"		] ??= 0.5;
				_config[$ "banner_outline"		] ??= true;
				_config[$ "banner_outline_color"] ??= c_white;
				_config[$ "text"				] ??= "";
				_config[$ "text_scale"			] ??= 2;
				_config[$ "text_color"			] ??= c_white;
				_config[$ "text_alpha"			] ??= 1;
				
				#region // banner //////////////
				
				var _banner_width  =  size_get_width();
				var _banner_height =  60;
				var _banner_x	   =  0;
				var _banner_y	   = (size_get_height() - _banner_height) * 0.5;
				var _banner_color  = _config.banner_color;
				var _banner_alpha  = _config.banner_alpha;
				
				iceberg.draw.rectangle(
					_banner_x,
					_banner_y,
					_banner_width,
					_banner_height,
					 0,
					_banner_color,
					_banner_alpha,
				);
				
				#endregion
				#region // outline /////////////
				
				if (_config.banner_outline) {
					
					var _banner_outline_color = _config.banner_outline_color;
				
					draw_rectangle_color(
						_banner_x + 1, 
						_banner_y,
						_banner_x + _banner_width - 2,
						_banner_y + _banner_height,
						_banner_outline_color, 
						_banner_outline_color, 
						_banner_outline_color, 
						_banner_outline_color, 
						 true
					);
				}
				
				#endregion
				#region // text ////////////////
				
				var _text_x		= _banner_x + _banner_width  * 0.5;
				var _text_y		= _banner_y + _banner_height * 0.5;
				var _text		= _config.text;
				var _text_scale = _config.text_scale;
				var _text_color = _config.text_color;
				var _text_alpha = _config.text_alpha;
				
				draw_set_halign(fa_center);
				draw_set_valign(fa_center);
				draw_text_transformed_color(
					_text_x,
					_text_y,
					_text,
					_text_scale,
					_text_scale,
					 0,
					_text_color, 
					_text_color, 
					_text_color, 
					_text_color, 
					_text_alpha
				);	
				draw_set_halign(fa_left);
				draw_set_valign(fa_top );
				
				#endregion
			};
			static __render_surface_start = function(_color = c_black, _alpha = 0) {
				if (!surface_exists(__.surface)) {
					 __.surface = surface_create(size_get_width(), size_get_height());	
				}
				surface_set_target(__.surface);
				draw_clear_alpha(_color, _alpha);
			};									
			static __render_surface_end	  = function() {
				surface_reset_target();
				draw_surface_ext(
					__.surface, 
					position_get_x(), 
					position_get_y(), 
					scale_get_x(), 
					scale_get_y(), 
					angle_get(), 
					c_white, 
					alpha_get()
				);
			};
			
			panel	= owner;
			player  = panel.get_owner();
			surface	= surface_create(1, 1);
			
			state = {};
			with (state) {
				fsm  = new SnowState("__", false, {
					owner: _self,
				});
				fsm.add("__", {
					step: function() {
						// deactivate if input devices are remove 
						if (!__.panel.page_is("active")
						&&	!iceberg.input.port_has_device(__.panel.get_index())
						) {
							__.panel.page_change("active");
						}
					},
					draw: function() {},
				});
			};		
		};
			
		// events
		on_initialize(function() {
			surface_resize(__.surface, size_get_width(), size_get_height());
		});
		on_update	 (function() {
			__.state.fsm.step();
		});
		on_render_gui(function() {
			if (__.panel.page_get_current().get_name() != "character_select") {
				iceberg.draw.rectangle(
					position_get_x(), 
					position_get_y() + 70, 
					size_get_width(), 
					size_get_height() - 58,
					0, 
					c_black, 
					0.6,
				);
			}
			__.state.fsm.draw();
		});
		on_cleanup   (function() {
			surface_free(__.surface);
			iceberg.input.unsubscribe(__.sub_gamepad_removed);
		});
	};
	
	