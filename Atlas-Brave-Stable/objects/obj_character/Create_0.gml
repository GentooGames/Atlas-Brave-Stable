
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______   ______   ______   ______  ______   ______    //
	// /\  ___\ /\ \_\ \ /\  __ \ /\  == \ /\  __ \ /\  ___\ /\__  _\/\  ___\ /\  == \   //
	// \ \ \____\ \  __ \\ \  __ \\ \  __< \ \  __ \\ \ \____\/_/\ \/\ \  __\ \ \  __<   //
	//  \ \_____\\ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_____\  \ \_\ \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_/\/_/ \/_/\/_/ \/_/ /_/ \/_/\/_/ \/_____/   \/_/  \/_____/ \/_/ /_/ //
	//																					 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_character.create //
	event_inherited();
	var _self = self;
	
	// .....................
	// core					
	// .....................
	#region meta/info
	
		// public
		log		   = function(_string, _log_flags = IB_LOG_FLAG.NONE) {
			__.IB.log(_string, IB_LOG_FLAG.CHARACTER & _log_flags);	
		};
		get_config = function() {
			return __.meta.config;
		};
		get_data   = function() {
			return __.meta.data;
		};
		get_desc   = function() {
			return __.meta.data.desc;
		};
		get_team   = function() {
			return __.meta.team;
		};
		get_stats  = function() {
			return __.stats;	
		};
	
		// private
		__[$ "meta"] ??= {};
		with (__.meta) {
			get_ability_data  = method(_self, function(_ability_type_enum) {
				if (iceberg.array.in_bounds(__.meta.data.abilities,_ability_type_enum)) {
					var _string  = __.meta.data.abilities[_ability_type_enum];
					if (_string != undefined) {
						return ABILITY_CONFIG[$ _string];
					}
				}
				return undefined;
			});
			get_ability_speed = method(_self, function(_ability_type_enum) {
				//var _data = __.meta.data.abilities[_ability_type_enum];
				//if (_data != undefined) {
				//	return _data.speed.multiplier;	
				//}
				return 1;
			});
			get_config		  = method(_self, function(_type) {
				switch (object_index) {
					case obj_hero:  return HERO_CONFIG [$ _type];
					case obj_enemy: return ENEMY_CONFIG[$ _type];
				};
				return undefined;
			});
			get_data		  = method(_self, function(_name) {
				switch (object_index) {
					case obj_hero:  return HERO_DATA [$ _name];
					case obj_enemy: return ENEMY_DATA[$ _name];
				};
				return undefined;
			});
				
            team    = _self[$ "team"] ?? undefined;
            config  =  HERO_CONFIG[$ _self.get_uid()];
            data	=  HERO_DATA  [$ _self.get_uid()];
			stats	=  new CharacterStats();
		};	
			
		// events 
		on_initialize(function() {
			log("stats initialize");
		});
		on_cleanup   (function() {
			__.meta.stats.cleanup();
			log("stats cleanup");
		});
	
	#endregion
	#region owner/player

		// public
		player_get			   = function() {
			return __.player.instance;	
		};
		player_set			   = function(_player) {
			
			__.player.instance = _player;
			__.input.enabled   = __.input.start_enabled();
			   //cpu_activate(_player == undefined);
			
			var _port_index = _player != undefined ? _player.input_get_port_index() : -1;
			log("set player: " + string(_port_index));
			
			return self;
		};
		player_exists		   = function() {
			return __.player.instance != undefined;	
		};
		player_remove		   = function() {
			player_set(undefined);
			return self;
		};
		player_lose_possession = function() {
			player_get().character_lose_possession(self);
			player_remove();
			return self;
		};
		player_gain_possession = function(_new_player) {
			player_set(_new_player);
			player_get().character_gain_possession(self);
			return self
		};

		// private
		__[$ "player"] ??= {};
		with (__.player) {
			instance = _self[$ "player"] ?? undefined;
		};
			
	#endregion
	#region cpu
	
		// public
		cpu_vision_scan			  = function(_x, _y, _radius) {
			return __.cpu.instance.vision_scan(_x, _y, _radius);
		};
		cpu_vision_target_add	  = function(_object_index, _precise = true, _notme = true) {
			__.cpu.instance.vision_target_add(_object_index, _precise, _notme);
			return self;
		};
		cpu_vision_target_remove  = function(_object_index) {
			__.cpu.instance.vision_target_remove(_object_index);
			return self;
		};
		cpu_navmesh_pathfind_to   = function(_target_instance, _on_path_end = undefined, _on_segment_end = undefined) {
			return __.cpu.instance.navmesh_pathfind_to(_target_instance, _on_path_end, _on_segment_end);
		};
		cpu_navmesh_pathfind_stop = function(_execute_callbacks = true) {
			__.cpu.instance.navmesh_pathfind_stop(_execute_callbacks);
			return self;
		};
		cpu_behavior_assign		  = function(_global_behavior_name) {
			__.cpu.instance.behavior_assign(_global_behavior_name);	
			return self;
		};
		cpu_behavior_evaluate	  = function() {
			__.cpu.instance.behavior_evaluate();
			return self;
		};
		
		// private
		__[$ "cpu"] ??= {};
		with (__.cpu) {
			instance = new CPU({
				owner: _self,
			});
		};
		
		// events
		on_initialize(function() {
			__.cpu.instance.initialize();
		});
		on_update	 (function() {
			__.cpu.instance.update();
			
			// debug 
			if (keyboard_check_pressed(vk_tab) 
			&&	object_index == obj_enemy
			) {
				cpu_behavior_assign("seek_and_attack_nearest");
				cpu_behavior_evaluate();
			}
		});
		on_render	 (function() {
			__.cpu.instance.render();
		});
		on_cleanup	 (function() {
			__.cpu.instance.cleanup();
		});
	
	#endregion
	#region inputs

		// input:general
		input_activate							 = function(_active = true) {
			if (_active) {
				__.input.enabled = true;	
				log("activated input");
			}
			else {
				input_deactivate();
			}
			return self;
		};
		input_deactivate						 = function() {
			__.input.enabled = false;
			log("deactivated input");
			return self;
		};
		input_get_devices						 = function() {
			if (__.player.instance != undefined) {
				return __.player.instance.input_get_devices();
			}
			return [];
		};
		input_has_device						 = function(_input_device = undefined) {
			if (__.player.instance != undefined) {
				return __.player.instance.input_has_device(_input_device);	
			}
			return false;
		};
		input_has_device_type					 = function(_device_type) {
			if (__.player.instance != undefined) {
				return __.player.instance.input_has_device_type(_device_type);	
			}
			return false;	
		};
		
		// input:window
		input_window_check						 = function(_window_array, _image_index) {
			var _min = _window_array[0];
			var _max = _window_array[1];
			return (_image_index >= _min && _image_index <= _max);
		};
		
		// input:lock
		input_lock_set							 = function(_lock_name, _lock_time = -1) {
			__.input.lock.set_lock(_lock_name, _lock_time);
			log("input lock set: " + _lock_name);
			return self;
		};
		input_lock_remove						 = function(_lock_name) {
			__.input.lock.remove_lock(_lock_name);
			log("input lock remove: " + _lock_name);
			return self;
		};
		input_lock_is_locked					 = function() {
			return __.input.lock.is_locked();
		};
		input_lock_is_unlocked					 = function() {
			return __.input.lock.is_unlocked();
		};
		
		// input:move_vector
		input_move_vector_get				     = function() {
			return __.input.move_vector;	
		};
		input_move_vector_get_snapshot			 = function() {
			return __.input.move_vector_snapshot;
		};
		input_move_vector_get_direction		     = function() {
			var _vector = input_move_vector_get();
			if (_vector.has_magnitude()) {
				return _vector.get_direction();
			}
			return sprite_get_angle();
		};
		input_move_vector_get_direction_inverted = function() {
			return input_move_vector_get_direction() + 180;
		};
		input_move_vector_get_direction_snapshot = function() {
			var _vector = input_move_vector_get_snapshot();
			if (_vector.has_magnitude()) {
				return _vector.get_direction();
			}
			return sprite_get_angle();
		};
		input_move_vector_set_direction			 = function(_direction) {
			__.input.move_vector.set_direction(_direction);
			return self;
		};
		input_move_vector_set_magnitude			 = function(_magnitude) {
			__.input.move_vector.set_magnitude(_magnitude);
			return self;
		};
		input_move_vector_set_snapshot			 = function(_vector = input_move_vector_get(), _limit = undefined) {
			
			__.input.move_vector_snapshot.assign_to(_vector);
			
			// restrict direction from going into vertical "zones"
			if (_limit != undefined) {
				__.input.move_vector_limit(_limit);
			}
			
			return self;
		};
		input_move_vector_lock_set				 = function(_lock_name, _lock_time = -1) {
			__.input.move_vector_lock.set_lock(_lock_name, _lock_time);
			log("vector_input lock set: " + _lock_name);
			return self;
		};
		input_move_vector_lock_remove			 = function(_lock_name) {
			__.input.move_vector_lock.remove_lock(_lock_name);
			log("vector_input lock remove: " + _lock_name);
			return self;
		};
		input_move_vector_lock_is_locked		 = function() {
			return __.input.move_vector_lock.is_locked();
		};
		input_move_vector_lock_is_unlocked		 = function() {
			return __.input.move_vector_lock.is_unlocked();
		};
		
		// input:aim_vector
		input_aim_vector_get				     = function() {
			return __.input.aim_vector;	
		};
		input_aim_vector_get_snapshot			 = function() {
			return __.input.aim_vector_snapshot;
		};
		input_aim_vector_get_direction		     = function() {
			var _vector = input_aim_vector_get();
			if (_vector.has_magnitude()) {
				return _vector.get_direction();
			}
			return sprite_get_angle();
		};
		input_aim_vector_get_direction_inverted  = function() {
			return input_aim_vector_get_direction() + 180;
		};
		input_aim_vector_get_direction_snapshot  = function() {
			var _vector = input_aim_vector_get_snapshot();
			if (_vector.has_magnitude()) {
				return _vector.get_direction();
			}
			return sprite_get_angle();
		};
		input_aim_vector_set_direction			 = function(_direction) {
			__.input.aim_vector.set_direction(_direction);
			return self;
		};
		input_aim_vector_set_magnitude			 = function(_magnitude) {
			__.input.aim_vector.set_magnitude(_magnitude);
			return self;
		};
		input_aim_vector_set_snapshot			 = function(_vector = input_aim_vector_get(), _limit = undefined) {
			
			__.input.aim_vector_snapshot.assign_to(_vector);
			
			// restrict direction from going into vertical "zones"
			if (_limit != undefined) {
				__.input.aim_vector_limit(_limit);
			}
			
			return self;
		};
		input_aim_vector_lock_set				 = function(_lock_name, _lock_time = -1) {
			__.input.aim_vector_lock.set_lock(_lock_name, _lock_time);
			log("vector_input lock set: " + _lock_name);
			return self;
		};
		input_aim_vector_lock_reaim				 = function(_lock_name) {
			__.input.aim_vector_lock.reaim_lock(_lock_name);
			log("vector_input lock reaim: " + _lock_name);
			return self;
		};
		input_aim_vector_lock_is_locked			 = function() {
			return __.input.aim_vector_lock.is_locked();
		};
		input_aim_vector_lock_is_unlocked		 = function() {
			return __.input.aim_vector_lock.is_unlocked();
		};
				
		#region input:check_pressed()/check_down()/check_released()
		
			input_left_pressed				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_left_pressed(__.input.check_enabled())
				);
			};
			input_left_down					 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_left_down(__.input.check_enabled())
				);
			};
			input_left_released				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_left_released(__.input.check_enabled())
				);
			};
			input_right_pressed				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_right_pressed(__.input.check_enabled())
				);
			};
			input_right_down				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_right_down(__.input.check_enabled())
				);
			};
			input_right_released			 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_right_released(__.input.check_enabled())
				);
			};
			input_up_pressed				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_up_pressed(__.input.check_enabled())
				);
			};
			input_up_down					 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_up_down(__.input.check_enabled())
				);
			};
			input_up_released				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_up_released(__.input.check_enabled())
				);
			};
			input_down_pressed				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_down_pressed(__.input.check_enabled())
				);
			};
			input_down_down					 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_down_down(__.input.check_enabled())
				);
			};
			input_down_released				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_down_released(__.input.check_enabled())
				);
			};
			input_select_pressed			 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_select_pressed(__.input.check_enabled())
				);
			};
			input_select_down				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_select_down(__.input.check_enabled())
				);
			};
			input_select_released			 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_select_released(__.input.check_enabled())
				);
			};
			input_back_pressed				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_back_pressed(__.input.check_enabled())
				);
			};
			input_back_down					 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_back_down(__.input.check_enabled())
				);
			};
			input_back_released				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_back_released(__.input.check_enabled())
				);
			};
			input_start_pressed				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_start_pressed(__.input.check_enabled())
				);
			};
			input_start_down				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_start_down(__.input.check_enabled())
				);
			};
			input_start_released			 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_start_released(__.input.check_enabled())
				);
			};
			input_options_pressed			 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_options_pressed(__.input.check_enabled())
				);
			};
			input_options_down				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_options_down(__.input.check_enabled())
				);
			};
			input_options_released			 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_options_released(__.input.check_enabled())
				);
			};
			input_next_pressed				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_next_pressed(__.input.check_enabled())
				);
			};
			input_next_down					 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_next_down(__.input.check_enabled())
				);
			};
			input_next_released				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_next_released(__.input.check_enabled())
				);
			};
			input_previous_pressed			 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_previous_pressed(__.input.check_enabled())
				);
			};
			input_previous_down				 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_previous_down(__.input.check_enabled())
				);
			};
			input_previous_released			 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_previous_released(__.input.check_enabled())
				);
			};
											    
			input_ability_basic_pressed		 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_basic_pressed(__.input.check_enabled())
				);
			};
			input_ability_basic_down		 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_basic_down(__.input.check_enabled())
				);
			};
			input_ability_basic_released	 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_basic_released(__.input.check_enabled())
				);
			};
			input_ability_defense_pressed	 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_defense_pressed(__.input.check_enabled())
				);
			};
			input_ability_defense_down		 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_defense_down(__.input.check_enabled())
				);
			};
			input_ability_defense_released	 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_defense_released(__.input.check_enabled())
				);
			};
			input_ability_primary_pressed	 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_primary_pressed(__.input.check_enabled())
				);
			};
			input_ability_primary_down		 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_primary_down(__.input.check_enabled())
				);
			};
			input_ability_primary_released	 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_primary_released(__.input.check_enabled())
				);
			};
			input_ability_secondary_pressed	 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_secondary_pressed(__.input.check_enabled())
				);
			};
			input_ability_secondary_down	 = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_secondary_down(__.input.check_enabled())
				);
			};
			input_ability_secondary_released = function() {
				return (__.player.instance != undefined
					&&	__.player.instance.input_ability_secondary_released(__.input.check_enabled())
				);
			};
			
		#endregion
			
		// private
		__[$ "input"] ??= {};
		with (__.input) {
			
			check_enabled = method(_self, function() {
				return (__.input.enabled
					&&	input_lock_is_unlocked()
				);
			});
			start_enabled = method(_self, function() {
				var _player = player_get();
				return (_player != undefined
					&&  _player.input_has_device()
				);
			});
			cursor_create = method(_self, function(_config = {}) {
				return instance_create_depth(x, y, 0, obj_character_cursor, _config);
			});
			enabled		  = start_enabled();
			lock		  = new IB_LockStack();
			cursor		  = cursor_create({
				character: _self,	
			});
					
			// move vector
			move_vector_update_check = method(_self, function() {
				return (__.input.check_enabled() // check superset
					&&	input_move_vector_lock_is_unlocked()
				);
			});
			move_vector_update		 = method(_self, function() {
				if (__.input.check_enabled()) {
					
					// edge case to handle gamepad axis direction
					var _used_gamepad = false;
					if (__.player.instance != undefined) {
						var _devices = __.player.instance.input_get_devices();
						for (var _i = 0, _len = array_length(_devices); _i < _len; _i++) {
							var _device = _devices[_i];
							if (_device.get_type() == "gamepad") {
								
								var _lh = _device.get_axis_value(gp_axislh);
								var _lv = _device.get_axis_value(gp_axislv);
								
								__.input.move_vector.x = _lh;
								__.input.move_vector.y = _lv;
								
								if (_lh != 0 || _lv != 0) {
									_used_gamepad = true;
								}
							}
						};
					}
					
					// get standard input checks
					if (!_used_gamepad) {
						__.input.move_vector.x = input_right_down() - input_left_down();
						__.input.move_vector.y = input_down_down () - input_up_down();	
					}
				}
			});
			move_vector_limit		 = method(_self, function(_limit_angle) {
				var _sign	 = sprite_get_facing();
				var _dir_old = __.input.move_vector_snapshot.get_direction();
				var _dir_new = iceberg.vector.get_direction_limited(_dir_old, _limit_angle, _sign);
				__.input.move_vector_snapshot.set_direction(_dir_new);
			});
			move_vector_lock		 = new IB_LockStack();
			move_vector				 = new XD_Vector2();
			move_vector_snapshot	 = new XD_Vector2();
									 
			// aim vector
			aim_vector_update_check  = method(_self, function() {
				return (__.input.check_enabled() // check superset
					&&	input_aim_vector_lock_is_unlocked()
				);
			});
			aim_vector_update		 = method(_self, function() {
				var _x   = x;
				var _y   = y;
				var _cx  = __.input.cursor.x;
				var _cy  = __.input.cursor.y;
				var _dir = point_direction(_x, _y, _cx, _cy);;
				__.input.aim_vector.set_direction(_dir);
				__.input.aim_vector.normalize();
			});
			aim_vector_limit		 = method(_self, function(_limit_angle) {
				var _sign	 = sprite_get_facing();
				var _dir_old = __.input.aim_vector_snapshot.get_direction();
				var _dir_new = iceberg.vector.get_direction_limited(_dir_old, _limit_angle, _sign);
				__.input.aim_vector_snapshot.set_direction(_dir_new);
			});
			aim_vector_lock			 = new IB_LockStack();
			aim_vector				 = new XD_Vector2();
			aim_vector_snapshot		 = new XD_Vector2();
		};
		
		// events
		on_initialize(function() {
			__.input.lock.initialize();
			__.input.move_vector_lock.initialize();
			__.input.aim_vector_lock.initialize();
			__.input.cursor.initialize();
		});
		on_update	 (function() {
			__.input.lock.update(); 
			__.input.move_vector_lock.update();
			__.input.move_vector_update();
			__.input.aim_vector_lock.update();
			__.input.aim_vector_update();
		});
		on_cleanup	 (function() {
			__.input.lock.cleanup();
			__.input.move_vector_lock.cleanup();
			__.input.aim_vector_lock.cleanup();
			__.input.cursor.destroy();
		});

	#endregion
	#region state
	
		// public
		state_get		   = function() {
			return __.state.fsm.get_current_state();	
		};
		state_get_current  = function() {
			return __.state.fsm.get_current_state();	
		};
		state_get_previous = function() {
			return __.state.fsm.get_previous_state();
		};
			
		// private
		__[$ "state"] ??= {};
		with (__.state) {
			fsm	= new SnowState("idle", false, { 
				owner: _self,
			});
			fsm.history_enable();
			fsm.history_set_max_size(1);
			
			// states
			fsm.add("__", character_state_base());
				fsm.add_child("__", "free", character_state_actions_free());
					fsm.add_child("free", "idle", character_state_idle());
					fsm.add_child("free", "move", character_state_move());
					
				fsm.add_child("__", "locked", character_state_actions_locked());
					fsm.add_child("locked", "hurt",	   character_state_hurt());
					fsm.add_child("locked", "death",   character_state_death());
					fsm.add_child("locked", "ability", character_state_ability());
					
			// triggers
			fsm.add_transition("t_idle",	 "free", "idle",	method(_self, character_state_trigger_idle));
			fsm.add_transition("t_move",	 "idle", "move",	method(_self, character_state_trigger_move));
			fsm.add_transition("t_ability",	 "free", "ability",	method(_self, character_state_trigger_ability));
					
			// hooks
			fsm.on("state changed", method(_self, function(_data) {
				var _state_to_name = _data;
				// ...
			}));
		};
		
		// events
		on_initialize  (function() {
			__.state.fsm.change("idle");
		});
		on_update_begin(function() {
			__.state.fsm.begin_step();
		});
		on_update	   (function() {
			__.state.fsm.step();
		});
		on_update_end  (function() {
			__.state.fsm.end_step();
		});
		on_render	   (function() {
			__.state.fsm.draw();
		});
		on_render_gui  (function() {
			__.state.fsm.draw_gui();
		});

	#endregion
	#region sprite
	
		// public
		sprite_change			= function(_sprite_name, _frame_index = undefined) {
			
			// register change with SpriteController
			__.sprite.controller.change(_sprite_name, _frame_index);
			
			// update sprite_index
			sprite_set_sprite_index(__.sprite.controller.get_sprite_index());
			
			// update image_index
			if (_frame_index != undefined) {
				sprite_set_image_index(_frame_index);
			}
			
			return self;
		};
		sprite_animation_end	= function(_frame_cushion = 0) {
			return __.sprite.controller.animation_end(_frame_cushion);	
		};
		sprite_frame_hit		= function(_frame_index) {
			return __.sprite.controller.frame_hit(_frame_index);
		};
		sprite_frame_in_window	= function(_window_min = 0, _window_max = undefined) {
			var _frame_index = sprite_get_frame_index()
			return __.sprite.controller.frame_in_window(_frame_index, _window_min, _window_max);	
		};
		sprite_flash_color		= function(_color = c_white, _alpha_max = 1, _duration = 30) {
			__.sprite.color_flash.flash(_color, _alpha_max, _duration);
			return self;
		};
			
		sprite_get_angle		= function() {
			return (sprite_get_facing() == 1) ? 0 : 180;
		};
		sprite_get_facing		= function() {
			// this is handled by the entity parent object
			return scale_get_facing();	
		};
		sprite_get_frame_index	= function() {
			return __.sprite.controller.get_frame_index();
		};
		sprite_get_sprite_index = function() {
			return __.sprite.controller.get_sprite_index();
		};
		sprite_set_frame_index	= function(_frame_index) {
			__.sprite.controller.set_frame_index(_frame_index);
			sprite_set_image_index(_frame_index);
			return self;
		};
		sprite_set_facing		= function() {
			__.sprite.set_facing_to_input()	
		};
		
		// private
		__[$ "sprite"] ??= {};
		with (__.sprite) {
			set_facing_to_input		 = method(_self, function() {
				var _facing  = sign(input_move_vector_get().x);
				if (_facing != 0) {
					scale_set_facing(_facing);
				}
			});
			set_facing_to_instance	 = method(_self, function(_instance) {
				if (_instance.x >= x) {
					 scale_set_facing(1);	
				}
				else scale_set_facing(-1);
			});
			set_facing_to_velocity	 = method(_self, function() {
				var _vector  = move_velocity_get_vector_output();
				var _facing  = sign(_vector.x);
				if (_facing != 0) {
					scale_set_facing(_facing);
				}
			});
			sync_frame_to_controller = method(_self, function() {
				sprite_set_image_index(__.sprite.controller.get_frame_index());
			});
			
			controller	= new SpriteController({
				character:   _self,	
				sprite_data:  global.character_sprite_data[$ _self.get_uid()],
				sprite_name: "Idle",
			});
			color_flash	= new ColorFlash({
				alpha_min: 0.0,
				alpha_max: 1.0,
				color:	   c_white,
				duration:  30,
			});
				
			// hook into IB_Object_Entity render pipeline
			_self.render_set_pre_render (method(color_flash, color_flash.render_begin));
			_self.render_set_post_render(method(color_flash, color_flash.render_end  ));
		};
		
		// events
		on_initialize(function() {
			__.sprite.controller.initialize();
			__.sprite.color_flash.initialize();
			sprite_change("Idle");
			// ^ needs to come before mask assignment
			mask_index = get_config().sprite.mask;
		});
		on_update	 (function() {
			depth = -bbox_bottom;
			__.sprite.controller.update();
			__.sprite.color_flash.update();
			__.sprite.sync_frame_to_controller();
			
			// on_animation_end()
			if (__.sprite.controller.animation_end()) {
				__.state.fsm.animation_end();	
			}
		});
		on_cleanup	 (function() {
			__.sprite.controller.cleanup();
			__.sprite.color_flash.cleanup();
		});
	
	#endregion
	#region audio
	 
		// public
		audio_play				= function(_audio_index, _mod_pitch = true) {
			
			static _pitch_min = 0.9;
			static _pitch_max = 1.1;
			
			if (_audio_index != undefined) {
				
				var _gain  =  1;
				var _pitch = _mod_pitch ? random_range(_pitch_min, _pitch_max) : 1;
					
				log("audio play: " + audio_get_name(_audio_index));
				return audio_play_sound_on(__.audio.emitter, _audio_index, false, 0, _gain, 0, _pitch);
			}
			return undefined;
		};
		audio_play_random		= function(_audio_index_array) {
			audio_play(iceberg.array.get_random(_audio_index_array));
			return self;
		};
		audio_play_chance		= function(_audio_index, _chance) {
			if (iceberg.math.percent(_chance)) {
				audio_play(_audio_index);	
			}
			return self;
		};
		audio_play_voice_chance = function(_audio_index, _chance = 0.5) {
			audio_play_chance(_audio_index, _chance);
			return self;
		};
			
		audio_get_hurt_index	= function(_array_index = -1) {
			
			var _character_data  =  get_config();
			var _sfx_index_array = _character_data.audio.vocal.hurt;
			var _array_length	 =  array_length(_sfx_index_array);
			
			if (_array_length > 0) {
				if (_array_index == -1) {
					_array_index  =  irandom(_array_length - 1);	
				}
				return _sfx_index_array[_array_index];
			}
			
			return undefined;
		};
		audio_get_death_index	= function(_array_index = -1) {
			
			var _character_data  =  get_config();
			var _sfx_index_array = _character_data.audio.death;
			var _array_length	 =  array_length(_sfx_index_array);
			
			if (_array_length > 0) {
				if (_array_index == -1) {
					_array_index  =  irandom(_array_length - 1);	
				}
				return _sfx_index_array[_array_index];
			}
			
			return undefined;
		};
		
		// private
		__[$ "audio"] ??= {};
		with (__.audio) {
			emitter = audio_emitter_create();
			
			//	dyanmicaly construct array of sound indexes using character name
			//	voice
			//	hurt
			//	death
			
			// need to account for character select scene global access
		};
		
		// events
		on_update (function() {
			audio_emitter_position(__.audio.emitter, x, y, 0);
		});
		on_cleanup(function() {
			audio_emitter_free(__.audio.emitter);
			log("audio emitter free");
		});
	
	#endregion
	#region movement
		
		// public
		move_controller_get				  = function() {
			return __.movement.controller;
		};
		move_controller_get_state		  = function() {
			return __.movement.controller.state_get();
		};
										     
		move_adjust_position_by_value	  = function(_value, _dir) {
			//print(_value);
			var _x_adjust = lengthdir_x(_value, _dir);
			var _y_adjust = lengthdir_y(_value, _dir);
			position_adjust_x(_x_adjust);
			position_adjust_y(_y_adjust);
			return self;
		};
		move_adjust_position_by_vector	  = function(_vector) {
			var _dir	  = _vector.get_direction();
			var _length	  = _vector.get_magnitude();
			var _x_adjust =  lengthdir_x(_length, _dir);
			var _y_adjust =  lengthdir_y(_length, _dir);
			position_adjust_x(_x_adjust);
			position_adjust_y(_y_adjust);
			return self;
		};
										     
		move_velocity_get_vector_output	  = function() {
			return __.movement.controller.velocity_get_vector_output();
		};
		move_velocity_get_vector_internal = function() {
			return __.movement.controller.velocity_get_vector_internal();
		};
		move_velocity_set_vector_internal = function(_velocity_vector) {
			__.movement.controller.velocity_set_x_internal(_velocity_vector.x);
			__.movement.controller.velocity_set_y_internal(_velocity_vector.y);
			return self;	
		};
		move_velocity_add_scalar		  = function(_scalar_name, _value, _duration = -1) {
			__.movement.controller.velocity_scalar_new_modifier_scalar(_scalar_name, _value, _duration);
			log("move_velocity_add_scalar: " + _scalar_name);
			return self;
		};
		move_velocity_remove_scalar		  = function(_scalar_name) {
			__.movement.controller.velocity_scalar_remove_modifier(_scalar_name);
			log("move_velocity_remove_scalar: " + _scalar_name);
			return self;
		};
		move_velocity_lock_set			  = function(_lock_name, _lock_duration = -1) {
			__.movement.controller.velocity_lock_set(_lock_name, _lock_duration);
			log("move_velocity_lock_set: " + _lock_name);
			return self;
		};
		move_velocity_lock_remove		  = function(_lock_name) {
			__.movement.controller.velocity_lock_remove(_lock_name);
			log("move_velocity_lock_remove: " + _lock_name);
			return self;
		};
		move_velocity_max_out			  = function(_dir) {
			__.movement.controller.velocity_max(_dir);
			return self;
		};
		move_velocity_zero_out			  = function() {
			__.movement.controller.velocity_clear();
			return self;
		};
		
		// private
		__[$ "movement"] ??= {};
		with (__.movement) {
			controller = new IB_MoveController_TopDown({
				owner: _self,	
			});
			controller.collision_object_add(obj_solid);
			controller.collision_object_add(obj_chest_item);
		};
		
		// events
		on_initialize(function() {
			var _move_data = __.meta.config.movement;
			with (__.movement.controller) {
				__collision_objects_init(_move_data.collisions.objects);
				//__moveset_init(_move_data.movesets);
				__movespeed_init(_move_data.movespeeds);	
			};
			__.movement.controller.initialize();
			log("movement initialized");
		});
		on_cleanup   (function() {
			__.movement.controller.cleanup();
			log("movement cleanup");
		});
		
	#endregion
	
	// .....................
	// stats & items
	// .....................
	#region life
	
		// public
		life_deplete	  = function(_amount = life_get_count()) {
			__.life.resource.deplete(_amount);
			log("life depleted: " + string(_amount));
			return self;
		};
		life_restore	  = function(_amount = life_get_space()) {
			__.life.resource.restore(_amount);
			log("life restored: " + string(_amount));
			return self;
		};
		life_get_count	  = function() {
			return __.life.resource.get_count();	
		};
		life_get_capacity = function() {
			return __.life.resource.get_capacity();	
		};
		life_get_space	  = function() {
			return life_get_capacity() - life_get_count();	
		};
		life_is_depleted  = function() {
			return __.life.resource.is_empty();
		};
	
		// private
		__[$ "life"] ??= {};
		with (__.life) {
			resource = new Resource({
				capacity: _self.__.meta.data.health,
				count:	  _self.__.meta.data.health,
			});
			resource.on_empty(method(_self, function() {
				log("life.resource empty");
				death();
			}));
		};
		
		// events
		on_initialize(function() {
			__.life.resource.initialize();
			log("life resource initialized");
		});
		on_update	 (function() {
			__.life.resource.update();
		});
		on_cleanup	 (function() {
			__.life.resource.cleanup();
			log("life resource cleanup");
		});
	
	#endregion
	#region armor
	
		// public
		armor_deplete	   = function(_amount = armor_get_count()) {
			__.armor.resource.deplete(_amount);
			log("armor depleted: " + string(_amount));
			return self;
		};
		armor_restore	   = function(_amount = armor_get_space()) {
			__.armor.resource.restore(_amount);
			log("armor restored: " + string(_amount));
			return self;
		};
		armor_get_count	   = function() {
			return __.armor.resource.get_count();	
		};
		armor_get_capacity = function() {
			return __.armor.resource.get_capacity();	
		};
		armor_get_space	   = function() {
			return armor_get_capacity() - armor_get_count();	
		};
		armor_is_depleted  = function() {
			return __.armor.resource.is_empty();
		};
	
		// private
		__[$ "armor"] ??= {};
		with (__.armor) {
			resource = new Resource({
				capacity: _self.__.meta.data[$ "armor"] ?? 0,
				count:	  _self.__.meta.data[$ "armor"] ?? 0,
			});
		};
		
		// events
		on_initialize(function() {
			__.armor.resource.initialize();
			log("armor resource initialized");
		});
		on_update	 (function() {
			__.armor.resource.update();
		});
		on_cleanup	 (function() {
			__.armor.resource.cleanup();
			log("armor resource cleanup");
		});
	
	#endregion
	#region stats
	
		// public
		stat_get = function(_stat_name) {
			return __.stats[$ _stat_name].get();
		};
		
		// private
		__[$ "stats"] ??= {};
		with (__.stats) {
			damage		 = new IB_Stat({ 
				value:		_self.get_data()[$ "damage"] ?? 1, 
				limit_min:	 0, 
				limit_apply: true,
			});
			defense		 = new IB_Stat({ 
				value:		_self.get_data()[$ "defense"] ?? 1, 
				limit_min:   0,
				limit_apply: true,
			});
			move_speed	 = new IB_Stat({ 
				value:		_self.get_data()[$ "move_speed"] ?? 1, 
				limit_min:	 0, 
				limit_apply: true,
			});
			attack_speed = new IB_Stat({ 
				value:		_self.get_data()[$ "attack_speed"] ?? 1,
				limit_min:	 0, 
				limit_apply: true,
			});
			attack_range = new IB_Stat({ 
				value:		_self.get_data()[$ "attack_range"] ?? 1,
				limit_min:	 0, 
				limit_apply: false,
			});
		};
		
		// events
		on_initialize(function() {
			__.stats.damage.initialize();
			__.stats.defense.initialize();
			__.stats.move_speed.initialize();
			__.stats.attack_speed.initialize();
			__.stats.attack_range.initialize();
			log("stats initialized");
		});
		on_update	 (function() {
			__.stats.damage.update();
			__.stats.defense.update();
			__.stats.move_speed.update();
			__.stats.attack_speed.update();
			__.stats.attack_range.update();
		});
		on_cleanup	 (function() {
			__.stats.damage.cleanup();
			__.stats.defense.cleanup();
			__.stats.move_speed.cleanup();
			__.stats.attack_speed.cleanup();
			__.stats.attack_range.cleanup();
			log("stats cleaned up");
		});
	
	#endregion
	#region gold
	
		// public
		gold_get	  = function() {
			return __.gold.amount;	
		};
		gold_increase = function(_amount = 1) {
			__.gold.amount += _amount;
			return self;
		};
		gold_decrease = function(_amount = 1) {
			__.gold.amount -= _amount;
			return self;
		}
		gold_aquire	  = function(_amount = 1) {
			gold_increase(_amount);
			audio_play(sfx_pickup_coin, false);
			return self;
		};
		gold_drop	  = function(_amount = 1) {
			repeat (_amount) {
				var _x = random_range(x - 10, x + 10);
				var _y = random_range(bbox_bottom, bbox_top);
				coin_create(_x, _y);
			};
			gold_decrease(_amount);
			return self;
		};
		
		// private
		__[$ "gold"] ??= {};
		with (__.gold) {
			interaction =  method(_self, function() {
				if (position_get_z_grounded() 
				&& !position_get_z_underground()
				) {
					var _coin  = instance_place(x, y, obj_coin);
					if (_coin != noone && _coin.is_grounded()) {
						_coin.destroy();
						gold_aquire(1);
					}
				}
			});
			amount		= _self[$ "gold"] ?? 100;
		};
		
		// events
		on_update(function() {
			__.gold.interaction();
			
			if (keyboard_check_pressed(ord("C"))) {
				gold_drop(irandom_range(1, 5));	
			}
		});
	
	#endregion
	#region item
	
		// public
		item_get	 = function(_inventory_index) {
			if (__.player.instance != undefined) {
				return __.player.instance.inventory_item_get(_inventory_index);
			}
			return undefined;
		};
		item_aquire	 = function(_item_instance) {
			
			// expecting an item_instance here acknowledges that there may 
			// be unique variations applied to the item_instance that could 
			// vary from the static defined global.item_data
			
			if (__.player.instance != undefined) {
				var _added = __.player.instance.inventory_item_add(_item_instance.get_uid());
				if (_added) {
					__.item.item_apply_stats(_item_instance);
					audio_play(sfx_pickup_item, false);
				}
			}
			
			return self;
			
		};
		item_holding = function(_item_uid) {
			if (__.player.instance != undefined) {
				return __.player.instance.inventory_item_exists(_item_uid);
			}
			return false;
		};
		item_drop    = function(_inventory_index, _x, _y) {
			if (__.player.instance != undefined) {
				var _uid = __.player.instance.inventory_item_get(_inventory_index);
				__.player.instance.inventory_item_remove(_inventory_index);
				item_create(_uid, _x, _y);	
			}
			return self;
		};
		item_sell    = function(_inventory_index) {
			if (__.player.instance != undefined) {
				// ...
			}
			return self;
		};
			
		// private
		__[$ "item"] ??= {};
		with (__.item) {
			// items
			item_apply_stats					= method(_self, function(_item_instance) {
				
				
				
			});
			item_purchase_check_interaction		= method(_self, function() {
				if (__.item.item_colliding_count > 0
				&&	input_select_pressed()
				) {
					// get nearest item stored in collision list
					var _item = __.item.item_colliding_list[|0];
					if (__.item.item_purchase_check(_item)) {
						__.item.item_purchase_apply(_item);
					}
				}
			});
			item_purchase_check					= method(_self, function(_item_instance) {
				return (
					_item_instance.get_cost() <= gold_get()
				);
			});
			item_purchase_apply					= method(_self, function(_item_instance) {
				
				// use gold to purchase
				gold_decrease(_item_instance.get_cost());
						
				// store in inventory
				item_aquire(_item_instance);
						
				// destroy item instance
				_item_instance.destroy();
				
			});
			item_interaction_update_collisions	= method(_self, function() {
				ds_list_clear(__.item.item_colliding_list);
				__.item.item_colliding_count = iceberg.collision.ellipse_list(
					x, 
					bbox_bottom,
					__.item.chest_interaction_radius,
					obj_item,
					false,
					false,
					__.item.item_colliding_list,
					true,
				);
			});
			item_interaction_radius				= 40;
			item_colliding_count				= 0;
			item_colliding_list					= ds_list_create();
			
			// chests
			chest_open_check_interaction		= method(_self, function() {
				if (__.item.chest_colliding_count > 0
				&&	input_select_pressed()
				) {
					// get nearest chest stored in collision list
					var _chest = __.item.chest_colliding_list[|0];
					if (_chest.can_open()) {
						_chest.open();
					}
				}
			});
			chest_interaction_update_collisions = method(_self, function() {
				ds_list_clear(__.item.chest_colliding_list);
				__.item.chest_colliding_count = iceberg.collision.ellipse_list(
					x, 
					bbox_bottom,
					__.item.item_interaction_radius,
					obj_chest,
					false,
					false,
					__.item.chest_colliding_list,
					true,
				);
			});
			chest_interaction_radius			= 40;
			chest_colliding_count				= 0;
			chest_colliding_list				= ds_list_create();
		};
		
		// events
		on_update (function() {
			__.item.item_interaction_update_collisions();
			__.item.chest_interaction_update_collisions();
		});
		on_cleanup(function() {
			ds_list_destroy(__.item.item_colliding_list);
			ds_list_destroy(__.item.chest_colliding_list);
		});
			
	#endregion

	// .....................
	// combat
	// .....................
	#region ability
	
		// public
		ability_get				  = function(_ability_type) {
			return __.ability[$ _ability_type].ability;
		};
		ability_get_current		  = function() {
			return __.ability.current;
		};
		ability_get_current_type  = function() {
			return __.ability.current_type;	
		};
		ability_is_current_type	  = function(_ability_type) {
			return __.ability.current_type == _ability_type;	
		};
		ability_get_previous	  = function() {
			return __.ability.previous;
		};
		ability_get_previous_type = function() {
			return __.ability.previous_type;
		};
		ability_is_previous_type  = function(_ability_type, _frame_window = -1) {
			var _current_time = current_time;
			var _delta_time	  = abs(_current_time - __.ability.previous_stored_on);
			return (__.ability.previous_type == _ability_type
				&& (_frame_window == -1 || _delta_time <= _frame_window)
			);
		};
								  
		ability_start			  = function(_ability_type) {
			var _ability  = ability_get(_ability_type);
			if (_ability != undefined) {
				log("ability " + _ability_type + " start");
				__.ability.set_current(_ability_type);
				__.state.fsm.change("ability");
			}
			return self;
		};
		ability_complete		  = function(_success = undefined, _ability_type = ability_get_current_type(), _return_state = "idle", _cooldown_start = true, _execute_callbacks = true) {
			var _ability  = ability_get(_ability_type);
			if (_ability != undefined) {
				log("ability " + _ability_type + " complete");
				_ability.complete(_success, _cooldown_start, _execute_callbacks);
				__.state.fsm.change(_return_state);
			}
			return self;
		};
		ability_can_start		  = function(_ability_type) {
			var	_ability = ability_get(_ability_type);
			if (_ability != undefined
			&&	_ability.is_ready()
			) {
				return true;	
			}
			return false;
		};
		ability_get_unique_name	  = function(_ability = ability_get_current(), _suffix = "") {
			return "__ability_" + _ability.get_name() + _suffix;
		};
								     
		ability_speed_mult_get	  = function(_ability_type) {
			return __.ability[$ _ability_type].speed_mult.get();
		};
		ability_speed_mult_set	  = function(_ability_type, _multiplier) {
			__.ability[$ _ability_type].speed_mult.set(_multiplier);
			log("ability " + _ability_type + " speed mult set: " + string(_multiplier));
			return self;
		};
		
		// private
		__[$ "ability"] ??= {};
		with (__.ability) {
			check_clear			= method(_self, function(_ability_type = ability_get_current_type()) {
				if (__.ability.current_type == _ability_type) {
					
					// store previous
					__.ability.previous_type	  = __.ability.current_type;
					__.ability.previous			  = __.ability.current;
					__.ability.previous_stored_on = current_time;
					
					// clear current
					__.ability.current_type	= "";
					__.ability.current		= undefined;
					
					log("ability cleared current");
				}
			});
			set_current			= method(_self, function(_ability_type) {
				
				var _ability	  = ability_get(_ability_type);
				var _ability_name = (_ability != undefined) ? _ability.get_name() : "undefined";
				
				__.ability.current		= _ability;
				__.ability.current_type	= _ability_type;
				log("ability set current: " + _ability_name);
			});
			on_phase_change		= method(_self, function(_char, _ability, _phase, _data) {
				_char.sprite_change(_phase.get_sprite_key(), 0);
			});
			on_cancel			= method(_self, function(_char, _ability, _phase, _data) {
				_char.ability_start(_ability.cancel_buffer_get_target());
			});
				
			lock				= new IB_LockStack();
			current				= undefined;
			current_type		= "";
			previous			= undefined;
			previous_type		= "";
			current_stored_on	= 0;
			previous_stored_on	= 0;
			
			// basic
			basic = {};
			with (basic) {
				var _data = _self.__.meta.get_ability_data(ABILITY.BASIC);
				ability	   = new Ability(_self, _data);
				speed_mult = new IB_Stat({
					value:    _self.__.meta.get_ability_speed("ability_basic"),
					limit_min: 0,
				});
				
				// hooks
				ability.on_phase_change(other.on_phase_change);
				ability.on_cancel	   (other.on_cancel		 );
			};
			
			// defense
			defense = {};
			with (defense) {
				var _data = _self.__.meta.get_ability_data(ABILITY.DEFENSE);
				ability	   = new Ability(_self, _data);
				speed_mult = new IB_Stat({
					value:    _self.__.meta.get_ability_speed("ability_defense"),
					limit_min: 0,
				});
					
				// hooks
				ability.on_phase_change(other.on_phase_change);
				ability.on_cancel	   (other.on_cancel		 );
			};
			
			// primary
			primary = {};
			with (primary) {
				var _data = _self.__.meta.get_ability_data(ABILITY.PRIMARY);
				ability	   = new Ability(_self, _data);
				speed_mult = new IB_Stat({
					value:    _self.__.meta.get_ability_speed("ability_primary"),
					limit_min: 0,
				});
				
				// hooks
				ability.on_phase_change(other.on_phase_change);
				ability.on_cancel	   (other.on_cancel		 );
			};
			
			// secondary
			secondary = {};
			with (secondary) {
				var _data = _self.__.meta.get_ability_data(ABILITY.SECONDARY);
				ability	   = new Ability(_self, _data);
				speed_mult = new IB_Stat({
					value:    _self.__.meta.get_ability_speed("ability_secondary"),
					limit_min: 0,
				});
					
				// hooks
				ability.on_phase_change(other.on_phase_change);
				ability.on_cancel	   (other.on_cancel		 );
			};
		};
		
		// events
		on_initialize(function() {
			
			__.ability.lock.initialize();
			
			if (__.ability.basic.ability	 != undefined) {
				__.ability.basic.ability.initialize();
			}
			if (__.ability.defense.ability   != undefined) {
				__.ability.defense.ability.initialize();
			}
			if (__.ability.primary.ability   != undefined) {
				__.ability.primary.ability.initialize();
			}
			if (__.ability.secondary.ability != undefined) {
				__.ability.secondary.ability.initialize();
			}
				
			__.ability.basic.speed_mult.initialize();
			__.ability.defense.speed_mult.initialize();
			__.ability.primary.speed_mult.initialize();
			__.ability.secondary.speed_mult.initialize();
			
			log("ability initialized");
		});
		on_update	 (function() {
			__.ability.lock.update();
		});
		on_cleanup   (function() {
			
			__.ability.lock.cleanup();
			
			if (__.ability.basic.ability	 != undefined) {
				__.ability.basic.ability.cleanup();
				
			}
			if (__.ability.defense.ability   != undefined) {
				__.ability.defense.ability.cleanup();
			}
			if (__.ability.primary.ability   != undefined) {
				__.ability.primary.ability.cleanup();
			}
			if (__.ability.secondary.ability != undefined) {
				__.ability.secondary.ability.cleanup();
			}
			
			__.ability.basic.speed_mult.cleanup();
			__.ability.defense.speed_mult.cleanup();
			__.ability.primary.speed_mult.cleanup();
			__.ability.secondary.speed_mult.cleanup();
			
			log("ability cleaned up");
		});
	
	#endregion
	#region hitbox
		
		// public
		hitbox_create		= function(_name, _config = {}, _init = true) {
			
			// optional parameters
			_config[$ "x"			] ??= position_get_x(); // add attack range and offset
			_config[$ "y"			] ??= position_get_y(); // add attack range and offset
			_config[$ "sprite_index"] ??= hitbox_get_sprite();
			_config[$ "angle"		] ??= input_move_vector_get_direction_snapshot();
			
			// create hitbox
			var _hitbox = create_hitbox(_config.x, _config.y, self, _config, false);
			_hitbox.angle_set(_config.angle);
			_hitbox.collision_assign_data(_config.collision_objects);
			
			// initialize?
			if (_init) _hitbox.initialize();
			
			// store instance reference
			__.hitbox.instances.set(_name, _hitbox);
			
			// make sure to remove from storage on_cleanup
			_hitbox.on_cleanup(function(_name) { 
				__.hitbox.instances.remove(_name);
			}, _name);
			
			return _hitbox;
		};
		hitbox_destroy		= function(_name) {
			var _hitbox  = __.hitbox.instances.get(_name);
			if (_hitbox != undefined && instance_exists(_hitbox)) {
				_hitbox.destroy();
			}
			__.hitbox.instances.remove(_name);
			log("hitbox destroyed: " + _name);
			return self;
		};
		hitbox_get			= function(_name) {
			return __.hitbox.instances.get(_name);
		};
		hitbox_exists		= function(_name) {
			return __.hitbox.instances.contains(_name);	
		};
		hitbox_get_sprite	= function(_ability = ability_get_current()) {
			return asset_get_index(_ability.get_sprite_prefix() + "_hitbox");
		};
		
		// private
		__[$ "hitbox"] ??= {};
		with (__.hitbox) {
			instances = new IB_Collection_Struct();	
		};
		
	#endregion
	#region hurtbox
	
		// public
		hurtbox_get = function() {
			return __.hurtbox.instance;	
		};
		
		// private
		__[$ "hurtbox"] ??= {};
		with (__.hurtbox) {
			instance = create_hurtbox(_self.x, _self.y, _self, {
				sprite_index: asset_get_index("spr_" + _self.get_uid() + "_hurtbox"),
			}, false);
		};
		
		// events
		on_initialize(function() {
			__.hurtbox.instance.initialize();
			log("hurtbox initialized");
		});
		on_cleanup	 (function() {
			__.hurtbox.instance.destroy();
			log("hurtbox destroyed");
		});
	
	#endregion
	#region projectile
		
		projectile_create		= function(_name, _config = {}, _init = true) {
			
			// optional parameters
			_config[$ "x"			] ??= position_get_x(); // add attack range and offset
			_config[$ "y"			] ??= position_get_y(); // add attack range and offset
			_config[$ "sprite_index"] ??= projectile_get_sprite();
			_config[$ "direction"	] ??= input_move_vector_get_direction_snapshot();
			
			// create projectile
			var _proj = create_projectile(_config.x, _config.y, self, _config);
			_proj.angle_set(_proj.direction_get());
			
			// initialize?
			if (_init) _proj.initialize();
			
			// store instance reference
			__.projectile.instances.set(_name, _proj);
			
			// make sure to remove from storage on_cleanup
			_proj.on_cleanup(function(_name) {
				__.projectile.instances.remove(_name);
			}, _name);
			
			return _proj;
		};
		projectile_destroy		= function(_name) {	
			var _proj  = __.projectile.instances.get(_name);
			if (_proj != undefined && instance_exists(_proj)) {
				_proj.destroy();
			}
			__.projectile.instances.remove(_name);
			return self;
		};
		projectile_get			= function(_name) {
			return __.projectile.instances.get(_name);
		};
		projectile_get_sprite	= function(_ability = ability_get_current()) {
			return asset_get_index(_ability.get_sprite_prefix() + "_proj");
		};
	
		// private
		__[$ "projectile"] ??= {};
		with (__.projectile) {
			instances = new IB_Collection_Struct();	
		};
		
	#endregion 
	#region damage
	
		// public
		damage = function(_amount, _damage_source) {
			if (__.damage.check()) {
				
				// effects
				//scale_squish(0.3);
				sprite_flash_color();
				audio_play(audio_get_hurt_index());
				create_damage_text(_amount);
				
				// damage effect
				
				effect_create("__hurt_Impact_vfx", new IEffectConfig({
					sprite_index:	spr_Impact_vfx,
				}));
			
				// deal damage to life resource
				life_deplete(_amount);
			
				// if dead, stop here
				if (life_get_count() <= 0) return self;
				////////////////////////////////////////
			
				// update sprite
				__.sprite.set_facing_to_instance(_damage_source);
			
				// go into hurt state
				__.state.fsm.change("hurt");
			}
			return self; 
		};
		
		// private
		__[$ "damage"] ??= {};
		with (__.damage) {
			check = method(_self, function() {
				return !is_dead();
			});
		};
		
	#endregion
	#region death
	
		// public 
		death	= function() {
			log("death");
			audio_play(audio_get_death_index());
			__.state.fsm.change("death");
			// player.character_death() handled on_cleanup
			return self;	
		};
		is_dead = function() {
			return __.death.is_dead;
		};
			
		// private
		__[$ "death"] ??= {};
		with (__.death) {
			is_dead = false;
		};
		
		// events
		on_cleanup(function() {
			if (__.player.instance != undefined) {
				__.player.instance.__.character.death(self);
				log("registered character_death");
			}
		});
	
	#endregion
	#region knockback
		
		// public
		knockback_tween			   = function(_tween_type, _dir) {
			var _name = "knockback_" + string(_tween_type) + string(current_time);
			tween_create_type(_name, _tween_type);
			tween_start(_name,,function(_tween) {
				
				var _tween_name = _tween.get_name();
				tween_stop(_tween_name, false);
				__.knockback.tweens.remove(_tween_name);
				
				// exit hurt state
				if (__.state.fsm.state_is("hurt")
				&&	__.knockback.tweens.is_empty()
				) {
					__.state.fsm.change("idle");	
				}
			});
			__.knockback.tweens.set(_name, { name: _name, dir: _dir });
			return self;
		};
		knockback_lock_set		   = function(_lock_name, _duration = -1) {
			__.knockback.lock_stack.set_lock(_lock_name, _duration);
			log("knockback_lock_set: " + _lock_name);
			return self;
		};
		knockback_lock_remove	   = function(_lock_name) {
			__.knockback.lock_stack.remove_lock(_lock_name);
			log("knockback_lock_remove: " + _lock_name);
			return self;
		};
		knockback_lock_is_locked   = function() {
			return __.knockback.lock_stack.is_locked();
		};
		knockback_lock_is_unlocked = function() {
			return __.knockback.lock_stack.is_unlocked();
		};
		
		// private
		__[$ "knockback"] ??= {};
		with (__.knockback) {
			tweens	   = new IB_Collection_Struct();
			lock_stack = new IB_LockStack();
		};
		
		// events
		on_initialize(function() {
			__.knockback.lock_stack.initialize();
			log("knockback_lock initialize");
		});
		on_update	 (function() {
			__.knockback.lock_stack.update();
			__.knockback.tweens.for_each(function(_data) {
				if (knockback_lock_is_unlocked()) {
					move_adjust_position_by_value(tween_get_value_step(_data.name), _data.dir);
				}
			});
		});
		on_cleanup	 (function() {
			__.knockback.lock_stack.cleanup();
			log("knockback_lock cleanup");
		});
	
	#endregion
	#region auras
	
		// public
		aura_create  = function(_name, _type) {
			var _aura = new Aura(_type, {
				owner:  other,
				name:  _name,
			});
			__.aura.instances.set(_name, _aura);
			_aura.initialize();
			log("aura created: " + _name);
			return _aura;
		};
		aura_destroy = function(_name) {
			var _aura  = __.aura.instances.get(_name);
			if (_aura != undefined) {
				__.aura.instances.remove(_name);
				_aura.destroy();
				log("aura destroyed: " + _name);
			}
			return self;
		};
		aura_get	 = function(_name) {
			return __.aura.instances.get(_name);
		};
		aura_exists  = function(_name) {
			return __.aura.instances.contains(_name);
		};
	
		// private
		__[$ "aura"] ??= {};
		with (__.aura) {
			instances = new IB_Collection_Struct();
		};
		
		// events
		on_update (function() {
			__.aura.instances.for_each(function(_aura) {
				_aura.update();
			});
		});
		on_cleanup(function() {
			__.aura.instances.for_each(function(_aura) {
				_aura.cleanup();
			});
		});
			
	#endregion
	
	// .....................
	// effects 
	// .....................
	#region smear
	
		// public
		smear_create	 = function(_name, _config = {}, _start = true) {
			
			_config[$ "x"			] ??= position_get_x(); // add attack range and offset
			_config[$ "y"			] ??= position_get_y(); // add attack range and offset
			_config[$ "sprite_index"] ??= smear_get_sprite();
			_config[$ "angle"		] ??= input_move_vector_get_direction_snapshot();
			
			var _smear = __.smear.controller.create_effect(_name, _config);
			_smear.set_angle(_config.angle);
			
			//_smear.on_cleanup( function(_name) { hitbox_destroy(_name) }, _name);
			
			if (_start) _smear.start();
			return _smear;
		};
		smear_destroy	 = function(_smear_name) {
			__.smear.controller.destroy_effect(_smear_name);
			log("smear destroyed: " + _smear_name);
			return self;
		};
		smear_start		 = function(_smear_name, _frame_index = 0, _on_stop_callback = undefined) {
			__.smear.controller.start_effect(_smear_name, _frame_index, _on_stop_callback);
			log("effect started: " + _smear_name);
			return self;
		};
		smear_stop		 = function(_smear_name, _execute_callbacks = true) {
			__.smear.controller.stop_effect(_smear_name, _execute_callbacks);
			log("smear stopped: " + _smear_name);
			return self;
		};
		smear_get_sprite = function(_ability = ability_get_current()) {
			return asset_get_index(_ability.get_sprite_prefix()+"_smear");	
		}
	
		// private
		__[$ "smear"] ??= {};
		with (__.smear) {
			controller = new EffectController();	
		};
		
		// events
		on_initialize(function() {
			__.smear.controller.initialize();
			log("smear controller initialized");
		});
		on_update	 (function() {
			__.smear.controller.update();
		});
		on_render	 (function() {
			__.smear.controller.draw_effects(
				position_get_x(), 
				position_get_y(),,, 
			//	sprite_get_facing(), 
			//	input_move_vector_get_direction_snapshot()
			);
		});
		on_cleanup	 (function() {
			__ .smear.controller.cleanup();
			log("smear controller cleanup");
		});
		
	#endregion	
	#region effect
		
		// public
		effect_create			= function(_uid, _config = {}, _init = true) {
			
			_config[$ "x"]	??= position_get_x(); // add attack range and offset
			_config[$ "y"]	??= position_get_y(); // add attack range and offset
			
			var _effect = __.effect.controller.create_effect(_uid, _config);
			//_effect.set_angle(_config.angle);
			
			if (_init) _effect.start();
			return _effect;
		};
		effect_destroy			= function(_effect_name) {
			__.effect.controller.destroy_effect(_effect_name);
			log("effect destroyed: " + _effect_name);
			return self;
		};
		effect_start			= function(_effect_name, _frame_index = 0, _on_stop_callback = undefined) {
			__.effect.controller.start_effect(_effect_name, _frame_index, _on_stop_callback);
			
			return self;
		};
		effect_stop				= function(_effect_name, _execute_callbacks = true) {
			__.effect.controller.stop_effect(_effect_name, _execute_callbacks);
			return self;
		};
		effect_set_image_index	= function(_effect_name, _image_index) {
			var _effect = __.effect.controller.get_effect(_effect_name);
			_effect.set_frame_index(_image_index);
			return self;
		};
		
		// private
		__[$ "effect"] ??= {};
		with (__.effect) {
			controller = new EffectController();	
		};
		
		// events
		on_initialize(function() {
			__.effect.controller.initialize();
			log("effect controller initialized");
		});
		on_update	 (function() {
			__.effect.controller.update();
		});
		on_render	 (function() {
		//	__.effect.controller.for_each_effect(function(_effect) {
		//		if (_effect.get_stick_to_owner_position()) {
		//				
		//		}
		//	});
			__.effect.controller.draw_effects(
				position_get_x(), 
				position_get_y(),,, 
			//	sprite_get_facing(), 
			//	input_move_vector_get_direction_snapshot(),
			);
		});
		on_cleanup	 (function() {
			__ .effect.controller.cleanup();
			log("effect controller cleanup");
		});
	
	#endregion
	#region tween
	
		// public
		tween_create		= function(_tween_name, _config = {}, _start = true) {
			
			if (_config.distance != undefined)	_config.value_end = _config.distance;
			
			_config[$ "var_name"	]	??=	"move_adjust_position_by_value";
			_config[$ "var_owner"	]	??=	self;
			
			var _tween = __.tween.controller.create_tween(_tween_name, _config, _start);
			if (_start) _tween.start();
			
			return _tween;
		};
		tween_destroy		= function(_tween_name) {
			log("tween destroyed: " + _tween_name);
			__.tween.controller.destroy_tween(_tween_name);
			return self;
		};
		tween_start			= function(_tween_name, _t = 0, _on_stop_callback = undefined) {
			__.tween.controller.start_tween(_tween_name, _t, _on_stop_callback);
			log("tween started: " + _tween_name);
			return self;
		};
		tween_stop			= function(_tween_name, _execute_callbacks = true) {
			__.tween.controller.stop_tween(_tween_name, _execute_callbacks);
			log("tween stopped: " + _tween_name);
			return self;
		};
		tween_pause			= function(_tween_name) {			
			__.tween.controller.pause_tween(_tween_name);
			log("tween paused: " + _tween_name);
			return self;
		};
		tween_get_value		= function(_tween_name) {
			return __.tween.controller.get_tween_value(_tween_name);
		};
		tween_is_running	= function(_tween_name) {
			return __.tween.controller.is_tween_running(_tween_name);	
		};
	
		// private
		__[$ "tween"] ??= {};
		with (__.tween) {
			controller = new IB_TweenController();
		};
		
		// events
		on_initialize(function() {
			__.tween.controller.initialize();
			log("tween controller initialized");
		});
		on_update	 (function() {
			__.tween.controller.update();
		});
		on_cleanup	 (function() {
			__.tween.controller.cleanup();
			log("tween controller cleanup");
		});
	
	#endregion
	
	on_update(function() {
		
		if (keyboard_check_pressed(ord("P"))) {
			//projectile_create_old("Caltrops", x, y, {
			//	move_dir: input_move_vector_get_direction(),
			//});
			
			projectile_create("Enzo Attack", new IProjectileConfig({
				sprite_index:	spr_Enzo_Attack_proj,
				direction:		30,
				distance:		150,
				speed:			5,
				anim_end_pause: true
				//duration:   30,
				//tween:		new ITweenConfig({
				//	auto_destroy:	false,
				//	value_end:		100,
				//	duration:		30
				//})
			})); 
		}
		
		if (keyboard_check_pressed(ord("I"))) {
			var _x = random_range(x - 2, x + 2);
			var _y = random_range(y - 2, y + 2);
			item_create("Potion", _x, _y);	
		}
		
		if (keyboard_check_pressed(ord("O"))) {
			with (obj_chest_item) {
				if ( is_open()) {
					 close();
				}
				else open();	
			};
		}
			
		if (keyboard_check(ord("Y"))) position_adjust_z(-1);	
		if (keyboard_check(ord("U"))) position_adjust_z( 1);	
	});
	