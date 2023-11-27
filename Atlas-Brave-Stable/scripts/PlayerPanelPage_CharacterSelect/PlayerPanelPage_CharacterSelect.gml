
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __       ______   ______   ______  //
	// /\  ___\ /\  ___\ /\ \     /\  ___\ /\  ___\ /\__  _\ //
	// \ \___  \\ \  __\ \ \ \____\ \  __\ \ \ \____\/_/\ \/ //
	//  \/\_____\\ \_____\\ \_____\\ \_____\\ \_____\  \ \_\ //
	//   \/_____/ \/_____/ \/_____/ \/_____/ \/_____/   \/_/ //
	//                                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_CharacterSelect(_config = {}) : PlayerPanelPage(_config) constructor {
		
		var _self = self;
		
		// private
		with (__) {
			static __render_character			 = function(_color = c_white) {
				
				var _cursor			= __.panel.get_cursor();
				var _cursor_index	= _cursor.index_get_i();
				var _character_type = global.hero_data_order[_cursor_index];
				var _character_data = HERO_CONFIG[$ _character_type];
				
				if (_character_data != undefined) {
					
					// high resolution sprite
					var _sprite_index  = _character_data.sprite.full;
					if (_sprite_index != undefined) {
						var _sprite_scale  =  4;
						var _sprite_x	   =  size_get_width() * 0.4 + __.character_sprite_x_spring.get();
						var _sprite_y	   =  __.character_sprite_y;
						var _shadow_offset =  15;
					
						// shadow
						draw_sprite_ext(_sprite_index, 0, _sprite_x + _shadow_offset, _sprite_y, 
							_sprite_scale, _sprite_scale, 0, c_black, 0.9);
					
						// sprite 
						draw_sprite_ext(_sprite_index, 0, _sprite_x, _sprite_y, 
							_sprite_scale, _sprite_scale, 0, _color, 1);
					}
						
					// nameplate
					var _sprite_index  = _character_data.sprite.nameplate;
					if (_sprite_index != undefined) {
						var _sprite_scale =  3;
						var _sprite_x	  =  0;// + iceberg.tween.wave(-10, 0, 10);
						var _sprite_y	  =  60;
					
						draw_sprite_ext(_sprite_index, 0, _sprite_x, _sprite_y,
							_sprite_scale, _sprite_scale, 0, _color, 1);
					}
				}
			};
			static __character_spring			 = function(_amount) {
				__.character_sprite_x_spring.fire(_amount);	
			};
			static __cursor_add_to_portrait		 = function() {
				
				var _cursor			   = __.panel.get_cursor();
				var _index_current	   = _cursor.index_get_i();
				var _index_previous    = _cursor.index_get_i_previous();
				var _portrait_current  = objc_character_select.portrait_get(_index_current );
				var _portrait_previous = objc_character_select.portrait_get(_index_previous);
				
				_portrait_previous.cursor_remove(self);
				_portrait_current .cursor_add(self);
				
			};
			static __cursor_remove_from_portrait = function() {
				var _cursor	  = __.panel.get_cursor();
				var _index	  = _cursor.index_get_i();
				var _portrait = objc_character_select.portrait_get(_index);
				_portrait.cursor_remove(self);
			};
			static __cursor_lerp_to_portrait	 = function() {
				
				var _cursor	= __.panel.get_cursor();
				var _index	= _cursor.index_get_i();
				
				// move to portrait
				var _portrait	= objc_character_select.portrait_get(_index);
				var _portrait_x = _portrait.position_get_x() + (_portrait.size_get_width () * 0.5);
				var _portrait_y = _portrait.position_get_y() + (_portrait.size_get_height() * 0.5);
				_cursor.position_set_x(_portrait_x, true);
				_cursor.position_set_y(_portrait_y, true);
				
			};
			static __cursor_snap_to_portrait	 = function() {
				
				var _cursor	= __.panel.get_cursor();
				var _index	= _cursor.index_get_i();
				
				// move to portrait
				var _portrait	= objc_character_select.portrait_get(_index);
				var _portrait_x = _portrait.position_get_x() + (_portrait.size_get_width () * 0.5);
				var _portrait_y = _portrait.position_get_y() + (_portrait.size_get_height() * 0.5);
				_cursor.position_set_x(_portrait_x, false);
				_cursor.position_set_y(_portrait_y, false);
				
			};
 			
			character_sprite_x_spring		 = new IB_Spring({
				tension:   0.30,
				dampening: 0.35,
				cutoff:	   0.001,
			});
			character_sprite_y_target		 = _self.size_get_height();
			character_sprite_y				 = character_sprite_y_target;
			character_sprite_y_offset		 = 0;
			character_sprite_y_offset_amount = 30;
			character_sprite_y_speed		 = 0.3;
			
			state.fsm.add_child("__", "character_select", {
				enter: function() {
					__.state.fsm.inherit();	
				},
				step:  function() {
					__.state.fsm.inherit();	
					
					__.character_sprite_y = lerp(
						__.character_sprite_y, 
						__.character_sprite_y_target + __.character_sprite_y_offset, 
						__.character_sprite_y_speed
					);
					__.character_sprite_x_spring.update();
					
					// open player settings
					var _player = __get_player();
					if (_player.input_options_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.panel.page_change("settings");
					}
				},
				draw:  function() {
					__.state.fsm.inherit();	
				},
				leave: function() {
					__.state.fsm.inherit();	
				},
			});
			state.fsm.add_child("character_select", "select", {
				enter: function() {
					__.state.fsm.inherit();
					__.panel.get_cursor().activate();
					__.panel.get_cursor().show();
					__.panel.get_cursor().state_change("character_select");
					__cursor_snap_to_portrait();
					__cursor_add_to_portrait();
					__.character_sprite_y_offset = 0;
				},
				step:  function() {
					__.state.fsm.inherit();
					
					var _player  = __.panel.get_player();
					var _cursor  = __.panel.get_cursor();
					var _profile = _player.profile_get();
						
					if (_player.input_right_pressed())	  _cursor.index_right();
					if (_player.input_left_pressed())	  _cursor.index_left();
					if (_player.input_next_pressed())	  _player.team_next();	
					if (_player.input_previous_pressed()) _player.team_previous();
					
					if (_player.input_select_pressed()) {
						_cursor.index_select();
						// see below for: on_activate.cursor.index_set_on_select();
					}
				
					if (_player.input_back_pressed()) {
						_profile.save_to_disk();
						__.panel.page_change("profile_setup");	
					}
						
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					__render_character(c_white, true);
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();		
				},
			});
			state.fsm.add_child("character_select", "locked", {
				enter: function() {
					__.state.fsm.inherit();
					__.panel.get_cursor().hide();
					__.panel.get_cursor().deactivate();
					__.character_sprite_y_offset = __.character_sprite_y_offset_amount;
				},
				step:  function() {
					__.state.fsm.inherit();
					
					// return to character select
					var _player = __.panel.get_player();
					if (_player.input_back_pressed()) {
						__.panel.get_cursor().index_deselect();
						__.state.fsm.change("select");	
					}
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					__render_character(c_gray, true);
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();		
				},
			});
		};
			
		// events
		on_initialize(function() {
			__.character_sprite_x_spring.initialize();
		});
		on_activate  (function() {
			
			var _cursor = __.panel.get_cursor();
				_cursor.index_set_i_max(HERO_COUNT);
				_cursor.index_set_j_max(0);
				_cursor.index_set_on_change	 (function() {
					__cursor_add_to_portrait();
					__cursor_lerp_to_portrait();
					__character_spring(10);
					__.panel.audio_play(sfx_navigate);
				});
				_cursor.index_set_on_select  (function() {
				
					var _cursor		= __.panel.get_cursor();
					var _index		= _cursor.index_get_i();
					var _hero_type  = global.hero_data_order[_index];
					
					// check if can select
					if (HERO_CONFIG[$ _hero_type] != undefined) {
			
						// assign selected type
						__.player.character_set_selected(_hero_type);
					
						// ready up
						objc_character_select.player_ready(__.player);
			
						// sfx
						var _character_data  = HERO_CONFIG[$ _hero_type];
						var _sfx_index_array = _character_data.audio.vocal.voice;
						var _array_length	 =  array_length(_sfx_index_array);
						var _array_index	 =  irandom(_array_length - 1);	
						var _audio			 = _sfx_index_array[_array_index];
						__.panel.audio_play(_audio);
						__.panel.audio_play(sfx_confirm);
						
						// change state
						__.state.fsm.change("locked");	
					}
					
				});
				_cursor.index_set_on_deselect(function() {
					__.player.character_set_selected(undefined);
					objc_character_select.player_unready(__.player);
					__.panel.audio_play(sfx_back);
				});
				
			__.state.fsm.change("select");
			
		});
		on_deactivate(function() {
			__cursor_remove_from_portrait();
			__.panel.get_cursor().deactivate();
			__.panel.get_cursor().hide();
		});
		on_cleanup	 (function() {
			__.character_sprite_x_spring.cleanup();
		});
	};
	