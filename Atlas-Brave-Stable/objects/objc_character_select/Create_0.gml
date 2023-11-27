
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __       ______   ______   ______  //
	// /\  ___\ /\  ___\ /\ \     /\  ___\ /\  ___\ /\__  _\ //
	// \ \___  \\ \  __\ \ \ \____\ \  __\ \ \ \____\/_/\ \/ //
	//  \/\_____\\ \_____\\ \_____\\ \_____\\ \_____\  \ \_\ //
	//   \/_____/ \/_____/ \/_____/ \/_____/ \/_____/   \/_/ //
	//                                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_character_select.create //
	
	active  = false;
	visible = false;
	
	////////////////
	
	event_inherited();
	var _self = self;
	
	#region player
	
		// public
		player_ready   = function(_player_instance) {
			if (!iceberg.array.contains(__.player.ready, _player_instance)) {
				array_push(__.player.ready, _player_instance);
				
				if (array_length(__.player.ready) == objc_game.player_get_active_count()) {
					__.state.fsm.change("countdown");		
				}
			}
			return self;
		};
		player_unready = function(_player_instance) {
			iceberg.array.find_delete(__.player.ready, _player_instance);
			if (state_is("countdown")) {
				__.state.fsm.change("selecting");	
			}
			return self;
		};
		
		// private
		__[$ "player"] ??= {};
		with (__.player) {
			ready = [];		
		};
			
		// events
		on_room_start(function() {
		//	__.player.ready = [];
		});
	
	#endregion
	#region background
	
		// private
		__[$ "background"] ??= {};
		with (__.background) {
			render = method(_self, function() {
				static _width  = sprite_get_width(spr_character_select_bg_elements);
				static _height = sprite_get_height(spr_character_select_bg_elements);
				var	   _scale  = SURF_W / _width;
				var    _x	   = 0;
				var	   _y	   = (SURF_H - (_height * _scale)) * 0.5;
				draw_sprite_ext(spr_character_select_bg_elements, 0, _x, _y, _scale, _scale, 0, c_white, 1);
			});
		};
		
		// events
		on_render_gui(function() {
			__.background.render();
		});
	
	#endregion
	#region countdown
	
		// private
		__[$ "countdown"] ??= {};
		with (__.countdown) {
			time  =  CHARACTER_SELECT_COUNTDOWN_TIME;
			timer = -1;	
		};
		
	#endregion
	#region portrait
	
		// public
		portrait_get	   = function(_index) {
			return __.portrait.instances.get(_index);
		};
		portrait_get_count = function() {
			return __.portrait.count;	
		};
		
		// private
		__[$ "portrait"] ??= {};
		with (__.portrait) {
			create			 = method(_self, function(_index, _config = {}) {
				// enforced
				_config[$ "owner" ] =  self;
				_config[$ "index" ] = _index;
				_config[$ "type"  ] =  global.hero_data_order[_config.index];
			
				// optionals
				_config[$ "scale" ] ??= __.portrait.scale;
				_config[$ "width" ] ??= __.portrait.calculate_width();
				_config[$ "height"] ??= __.portrait.calculate_height();
				_config[$ "x"	  ] ??= __.portrait.calculate_x(_index);
				_config[$ "y"	  ] ??= __.portrait.calculate_y(_index);
			
				var _portrait = new CharacterSelectPortrait(_config).initialize();
				__.portrait.instances.set(_index, _portrait);
			
				return _portrait;
			});
			calculate_height = method(_self, function() {
				static _SPRITE_HEIGHT = sprite_get_height(spr_character_select_unknown);
				return _SPRITE_HEIGHT;
			});
			calculate_width	 = method(_self, function() {
				static _SPRITE_WIDTH = sprite_get_width(spr_character_select_unknown);
				return _SPRITE_WIDTH;
			});
			calculate_x		 = method(_self, function(_index = undefined) {
				// return specific portrait x
				if (_index != undefined) {
					var _portrait  = __.portrait.instances.get(_index);
					if (_portrait != undefined) {
						return _portrait.calculate_x();
					}
				}
				
				// calculate generic portrait x position
				var _portrait_inset = 0.75;
				var _portrait_width = __.portrait.calculate_width() * __.portrait.scale;
				var _portrait_x		= (_portrait_width * _portrait_inset) * _index;
				
				// center in middle of screen
				var _width_total = __.portrait.count * _portrait_width * _portrait_inset;
				var _width_delta = (SURF_W - _width_total) * 0.5;
				return _portrait_x + _width_delta - (_portrait_width * (_portrait_inset * 0.5));
			});
			calculate_y		 = method(_self, function(_index = undefined) {
				
				// get specific portrait's y position
				if (_index != undefined) {
					var _portrait  = __.portrait.instances.get(_index);
					if (_portrait != undefined) {
						return _portrait.calculate_y();
					}
				}
				
				// get generic portrait's y position
				var _portrait_height = __.portrait.calculate_height();
				var _zigzag_offset_0 = -((_index % 2 == 0) * (_portrait_height + 00));
				var _zigzag_offset_i =  ((_index % 2 == 1) * (_portrait_height - 10));
				var _zigzag_offset	 = _zigzag_offset_0 + _zigzag_offset_i;
				return __.portrait.position_y + _zigzag_offset;
				
			});
			remove			 = method(_self, function(_index) {
				var _portrait = __.portrait.instances.get(_index);
				__.portrait.instances.remove(_index);
				return _portrait;
			});
				
			count			 = array_length(global.hero_data_order);
			instances		 = new IB_Collection_Struct();
			position_y		 = SURF_H - 140;
			scale			 = 3;
		};
		
		// events
		on_initialize(function() {
			for (var _i = 0; _i < __.portrait.count; _i++) {
				__.portrait.create(_i);
			};
		});
		on_cleanup   (function() {
			__.portrait.instances.cleanup();
		});
	
	#endregion
	#region state
	
		// public
		state_get = function() {
			return __.state.fsm.get_current_state();
		};
		state_is  = function(_state_name) {
			return __.state.fsm.state_is(_state_name);	
		};
			
		// private
		__[$ "state"] ??= {};
		with (__.state) {
			fsm = new SnowState("idle", false, {
				owner: _self,
			});
			fsm.add("__", {
				enter: function() {},
				step:  function() {
					__.portrait.instances.for_each(function(_portrait) {
						_portrait.update();
					});
				},
				draw:  function() {
					__.portrait.instances.for_each(function(_portrait) {
						with (_portrait) {
							var _scale = 3;
							var _x	   = position_get_x() + (size_get_width () * 0.5);
							var _y	   = position_get_y() + (size_get_height() * 0.5);
							draw_sprite_ext(spr_character_select_unknown, 0, _x, _y, _scale, _scale, 0, c_gray, 1);
							render_gui();
						};
					});	
				},
				leave: function() {},
			});
			fsm.add_child("__", "idle",		 {
				enter: function() {
					__.state.fsm.inherit();
				},
				step:  function() {
					__.state.fsm.inherit();
				},
				draw:  function() {
					__.state.fsm.inherit();
				},
				leave: function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("__", "selecting", {
				enter: function() {
					__.state.fsm.inherit();
				},
				step:  function() {
					__.state.fsm.inherit();
				},
				draw:  function() {
					__.state.fsm.inherit();
				},
				leave: function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("__", "countdown", {
				enter: function() {
					__.state.fsm.inherit();
					__.countdown.timer = __.countdown.time;
				},
				step:  function() {
					__.state.fsm.inherit();
					__.countdown.timer--;
					if (__.countdown.timer == 0) {
						room_goto_next();
					}
				},
				draw:  function() {
					__.state.fsm.inherit();
					draw_set_halign(fa_center);
					
					var _time	= string_format(__.countdown.timer / SECOND, 1, 2);
					var _offset = 5;
					
					// shadow
					draw_text_transformed_color(
						SURF_W * 0.50 + _offset, 
						SURF_H * 0.05 + _offset, 
						"starting in: " + _time,
						2, 
						2,
						0,
						c_black,
						c_black,
						c_black,
						c_black,
						0.6
					);
					
					// text
					draw_text_transformed_color(
						SURF_W * 0.50, 
						SURF_H * 0.05, 
						"starting in: " + _time,
						2, 
						2,
						0,
						COLOR_WHITE,
						COLOR_WHITE,
						COLOR_WHITE,
						COLOR_WHITE,
						1
					);
					draw_set_halign(fa_left);
				},
				leave: function() {
					__.state.fsm.inherit();
					__.countdown.timer = -1;
				},
			});	
		};
	
		// events
		on_activate  (function() {
			__.state.fsm.change("selecting");
		});
		on_deactivate(function() {
			__.state.fsm.change("idle");
		});
		on_update	 (function() {
			__.state.fsm.step();
		});
		on_render_gui(function() {
			__.state.fsm.draw();
		});
	
	#endregion
	
	