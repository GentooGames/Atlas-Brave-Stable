	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   __        //
	// /\  __ \ /\  == \ /\  ___\ /\ \       //
	// \ \  __ \\ \  __< \ \  __\ \ \ \____  //
	//  \ \_\ \_\\ \_____\\ \_____\\ \_____\ //
	//   \/_/\/_/ \/_____/ \/_____/ \/_____/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function Abel_Abilities_Init() {
		
		ABILITY_CONFIG[$ "Abel Attack"] = new IAbilityConfig({
			name:  "Abel Attack",
			type:   ABILITY.BASIC,
			phases: [
				new IAbilityPhaseConfig({ // ATTACK 1
					on_start:  function(_char, _ability, _phase) {
						// cancel buffer
						static _buffer_window = 60;
						if (_char.ability_is_previous_type("defense", _buffer_window)) {
							_char.sprite_set_frame_index(3);
							_char.input_move_vector_set_snapshot(,60);
						}
					},
					on_update: function(_char, _ability, _phase) {
						if (_char.sprite_frame_hit(3)) {
						
							var _name		= _char.ability_get_unique_name(_ability);
							var _input_dir	= _char.input_move_vector_get_direction_snapshot();
								
							_char.sprite_set_facing();
						
							_char.tween_create (_name, new ITweenConfig({
								direction: _input_dir,
								distance:   6,
								duration:   15,
							})); 
							_char.hitbox_create(_name, new IHitboxConfig({
								damage:		.9,
								hit_stun:	30,
								offset:		3,
								knockback:	new ITweenConfig({
									direction: _input_dir,
									distance:   6,
									duration:   15,
								}),
							}));
							_char.smear_create (_name, new ISmearConfig());
						
							_char.audio_play(sfx_Abel_Attack_1);
							_char.audio_play_voice_chance(sfx_Abel_Attack_voice_1);
						}
						
						// combo buffer
						if (_char.input_ability_basic_down() &&	_char.sprite_frame_in_window(4)) {
							_ability.phase_buffer();
						}
					
						// defense cancel
						if (_char.input_ability_defense_down() && _char.sprite_frame_in_window(4,7)) {
							_ability.cancel_buffer_set("defense", 6);
						}
					},
				}), // PHASE END
				new IAbilityPhaseConfig({ // ATTACK 2
					on_update: function(_char, _ability, _phase) {
						if (_char.sprite_frame_hit(3)) {
						
							var _name		= _char.ability_get_unique_name(_ability);
							var _input_dir	= _char.input_move_vector_get_direction_snapshot();
						
							_char.sprite_set_facing();
					
							_char.tween_create (_name, new ITweenConfig({
								direction: _input_dir,
								distance:   6,
								duration:   15,
							})); 
							_char.hitbox_create(_name, new IHitboxConfig({
								damage:		1,
								hit_stun:	30,
								offset:		3,
								knockback:	new ITweenConfig({
									direction: _input_dir,
									distance:   6,
									duration:   15,
								}),
							}));
							_char.smear_create (_name, new ISmearConfig());
						
							_char.audio_play(sfx_Abel_Attack_2);
							_char.audio_play_voice_chance(sfx_Abel_Attack_voice_2);
						}
						
						// combo buffer
						if (_char.input_ability_basic_down()   
						&&	_char.sprite_frame_in_window(4)
						) {
							_ability.phase_buffer();
						}
					
						// defense cancel
						if (_char.input_ability_defense_down() 
						&&	_char.sprite_frame_in_window(4,7)
						) {
							_ability.cancel_buffer_set("defense", 5);
						}
					},
				}), // PHASE END
				new IAbilityPhaseConfig({ // ATTACK 3
					on_update: function(_char, _ability, _phase) {
						if (_char.sprite_frame_hit(6)) {
						
							var _name		= _char.ability_get_unique_name(_ability);
							var _input_dir	= _char.input_move_vector_get_direction_snapshot();
						
							_char.sprite_set_facing();
						
							_char.tween_create (_name, new ITweenConfig({
								direction: _input_dir,
								distance:   8,
								duration:   20,
							})); 
							_char.hitbox_create(_name, new IHitboxConfig({
								damage:		1.2,
								hit_stun:	35,
								offset:		3,
								knockback:	new ITweenConfig({
									direction: _input_dir,
									distance:   20,
									duration:   20,
								}),
							}));
							_char.smear_create (_name, new ISmearConfig());
						
							_char.audio_play(sfx_Abel_Attack_3);
							_char.audio_play_voice_chance(sfx_Abel_Attack_voice_3);	
						}
					},
				}), // PHASE END
			],
		});
		ABILITY_CONFIG[$ "Roll"		  ] = new IAbilityConfig({
			name:  "Roll",
			type:	ABILITY.DEFENSE,
			phases:	[
				new IAbilityPhaseConfig({
					on_update: function(_char, _ability, _phase) {
						if (_char.sprite_frame_hit(0)) {
						
							var _name		= _char.ability_get_unique_name(_ability);
							var _input_dir	= _char.input_move_vector_get_direction();
								
							_char.sprite_set_facing();
								
							_char.tween_create(_name, new ITweenConfig({
								direction: _input_dir,
								distance:   60,
								duration:   60,
							}));
								
							_char.audio_play(sfx_Abel_Roll);
							_char.audio_play_voice_chance(sfx_Abel_Roll_voice);
						}
					
						// defense cancel
						if (_char.input_ability_basic_down() 
						&&	_char.sprite_frame_in_window(4,9)
						) {
							_ability.cancel_buffer_set("basic", 9);
						}
					},
				}), // PHASE END
			],
		});
		ABILITY_CONFIG[$ "Whirlwind"  ] = new IAbilityConfig({
			name:	 "Whirlwind",
			type:	  ABILITY.PRIMARY,
			on_start: function(_char, _ability, _phase) {
				var _name = _char.ability_get_unique_name(_ability);
				_char.move_velocity_add_scalar(_name, -0.5);
				_char.audio_play(sfx_Abel_Whirlwind);
			},
			on_stop:  function(_char, _ability, _phase) {
				var _name = _char.ability_get_unique_name(_ability);
				_char.move_velocity_remove_scalar(_name);
				_char.smear_destroy(_name);
			},
			phases:	  [
				new IAbilityPhaseConfig({ // WHIRLWIND
					on_update: function(_char, _ability, _phase) {
						if (_char.sprite_frame_hit(0)) {
							var _name = _char.ability_get_unique_name(_ability);
								
							_char.hitbox_create(_name, new IHitboxConfig({
								damage:	  0.4,
								hit_stun: 30,
								angle:	  0,
							}));
							_char.smear_create (_name, new ISmearConfig({
								angle:		 0,
								loop_on_end: true,
							}));
						}
					
					},
				}), // PHASE END
			],
		});
		ABILITY_CONFIG[$ "Arc Slash"  ] = new IAbilityConfig({
			name:  "Arc Slash",
			type:	ABILITY.SECONDARY,
			phases:	[
				new IAbilityPhaseConfig({	// SLASH
					on_update: function(_char, _ability, _phase) {
						if (_char.sprite_frame_hit(5)) {
						
							var _name		= _char.ability_get_unique_name(_ability);
							var _input_dir	= _char.input_move_vector_get_direction();
								
							_char.sprite_set_facing();
						
							_char.tween_create (_name, new ITweenConfig({
								direction: _input_dir,
								distance:   35,
								duration:   20,
								curve_channel:	"expo"
							})); 
							_char.hitbox_create(_name, new IHitboxConfig({
								damage:		1.5,
								hit_stun:	30,
								offset:		5,
								knockback:	new ITweenConfig({
									direction: _input_dir,
									distance:   10,
									duration:   20,
								}),
							}));
							_char.smear_create (_name, new ISmearConfig());
								
							_char.audio_play(sfx_Abel_Arc_Slash);
						}
					},
				
				}), // PHASE END
			],
		}); 
	
	};