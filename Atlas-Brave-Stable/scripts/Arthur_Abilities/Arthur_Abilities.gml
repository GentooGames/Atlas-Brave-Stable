// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
//  ______   ______  ______  __  __   __  __   ______    //
// /\  __ \ /\  == \/\__  _\/\ \_\ \ /\ \/\ \ /\  == \   //
// \ \  __ \\ \  __<\/_/\ \/\ \  __ \\ \ \_\ \\ \  __<   //
//  \ \_\ \_\\ \_\ \_\ \ \_\ \ \_\ \_\\ \_____\\ \_\ \_\ //
//   \/_/\/_/ \/_/ /_/  \/_/  \/_/\/_/ \/_____/ \/_/ /_/ //
//                                                       //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
function Arthur_Abilities_Init() {
	
	ABILITY_CONFIG[$ "Arthur Attack"] = new IAbilityConfig({
		name:  "Arthur Attack",
		type:	ABILITY.BASIC,
		phases: [
			new IAbilityPhaseConfig({ // ATTACK 1
				on_update: function(_char, _ability, _phase) {
					if (_char.sprite_frame_hit(4)) {
						var _name	   = _char.ability_get_unique_name(_ability);
						var _input_dir = _char.input_move_vector_get_direction_snapshot();
						
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
						
						_char.audio_play(sfx_Arthur_Attack_1);
						_char.audio_play_voice_chance(sfx_Arthur_Attack_voice_1);
					}
						
					// combo buffer
					if (_char.input_ability_basic_down() &&	_char.sprite_animation_end(4)) {
						_ability.phase_buffer();
					}
				},
			}),
			new IAbilityPhaseConfig({ // ATTACK 2
				on_update: function(_char, _ability, _phase) {
					if (_char.sprite_frame_hit(3)) {
						
						var _name		= _char.ability_get_unique_name(_ability);
						var _input_dir	= _char.input_move_vector_get_direction_snapshot();
						
						_char.sprite_set_facing();
						
						_char.tween_create (_name, new ITweenConfig({
							direction: _input_dir,
							distance:   4,
							duration:   10,
						})); 
						_char.hitbox_create(_name, new IHitboxConfig({
							damage:		1,
							hit_stun:	30,
							offset:		3,
							knockback:	new ITweenConfig({
								direction: _input_dir,
								distance:   4,
								duration:   10,
							})
						}));
						_char.smear_create (_name, new ISmearConfig());
						
						_char.audio_play(sfx_Arthur_Attack_2);
						_char.audio_play_voice_chance(sfx_Arthur_Attack_voice_2);
					}
						
					// combo buffer
					if (_char.input_ability_basic_down() &&	_char.sprite_animation_end(4)) {
						_ability.phase_buffer();
					}
				},
			}),
			new IAbilityPhaseConfig({ // ATTACK 3
				charge_min:	0,
				charge_max:	20,
				on_update:	function(_char, _ability, _phase) {
					if (_char.sprite_frame_hit(6)) { // charge
						//	if charge_start effect_create()
						//	
						//	if holding_attack {
						//		add to charge value through abilityPhase
						//		pause _char animation
						//	}
					}
					
					if (_char.sprite_frame_hit(7)) { // slam
						var _name		= _char.ability_get_unique_name(_ability);
						var _input_dir	= _char.input_move_vector_get_direction_snapshot();
						_char.sprite_set_facing();
						
						_char.tween_create (_name, new ITweenConfig({
							direction: _input_dir,
							distance:   2,
							duration:   5,
						})); 
					
						var _hb_x = _char.position_get_x() + lengthdir_x(30, _input_dir);
						var _hb_y = _char.position_get_y() + lengthdir_y(30, _input_dir) + 5;
						
						_char.hitbox_create(_name, new IHitboxConfig({
							damage:		1.2,
							hit_stun:	35,
							angle:		0,
							x:			_hb_x,
							y:			_hb_y,
							knockback:	new ITweenConfig({
								direction: _input_dir,
								distance:   15,
								duration:   10,
							})
						}));
						_char.smear_create (_name, new ISmearConfig({
							angle: 0,
						}));
						
						_char.audio_play(sfx_Arthur_Attack_3);
						_char.audio_play_voice_chance(sfx_Arthur_Attack_voice_3);	
					}
					
				},
			}),
		],
	});
	ABILITY_CONFIG[$ "Defend"		] = new IAbilityConfig({
		name:  "Defend",
		type:	ABILITY.DEFENSE,
		phases:	[
			new IAbilityPhaseConfig({ // DEFEND
				on_update: function(_char, _ability, _phase) {
					if (_char.sprite_frame_hit(2)) {
						
						var _name = _char.ability_get_unique_name(_ability);
						
						_char.sprite_set_facing();
							
						_char.shield_create(_name, new IHitboxConfig({}));
	
						_char.audio_play(sfx_Arthur_Defend);
					}
				
				},
			}),
		],
	});
	ABILITY_CONFIG[$ "Hammer Throw"	] = new IAbilityConfig({
		name:	 "Hammer Throw",
		type:	  ABILITY.PRIMARY,
		phases:	  [
			new IAbilityPhaseConfig({ // THROW
				on_update: function(_char, _ability, _phase) {
					if (_char.sprite_frame_hit(6)) {
						
						var _name	   = _char.ability_get_unique_name(_ability);
						var _input_dir = _char.input_move_vector_get_direction_snapshot();
						
						_char.sprite_set_facing();
						_char.projectile_create(_name, new IProjectileConfig({
							direction:		_input_dir,
							duration:		SECOND*3,
							tween:		new ITweenConfig({
								auto_destroy:	false,
								value_end:		100,
								duration:		30
							})
						}));
						
						_char.audio_play(sfx_Arthur_Hammer_Throw_swing);
						_char.audio_play_voice_chance(sfx_Arthur_Hammer_Throw_voice);
					}
				
				},
			}),
		],
	});
	ABILITY_CONFIG[$ "Earthbreaker"	] = new IAbilityConfig({
		name:	 "Earthbreaker",
		type:	  ABILITY.SECONDARY,
		on_start: function(_char, _ability, _phase) {
			// set super armor
		},
		phases:	  [
			new IAbilityPhaseConfig({ // LEAP
				on_update: function(_char, _ability, _phase) {
					if (_char.sprite_frame_hit(5)) {
						
						var _name = _char.ability_get_unique_name(_ability);

						_char.sprite_set_facing();
						
						_char.tween_create(_name, new ITweenConfig({
							height:	  10,
							duration: 15,
						})); 
	
						_char.audio_play(sfx_Arthur_Earthbreaker_jump);
						_char.audio_play_voice_chance(sfx_Arthur_Earthbreaker_jump_voice);
					}
				},
			}),
			new IAbilityPhaseConfig({ // SPIN
			//	duration:	60,
			//	charge_min:	20,
			//	charge_max:	60,
				on_update:	function(_char, _ability, _phase) {
					// charge code
					// is input held
					// create charge vfx
					_char.audio_play(sfx_Arthur_Earthbreaker_jump);
				},
			}),
			new IAbilityPhaseConfig({ // DIVE
				on_start:	function(_char, _ability, _phase) {
					var _name = _char.ability_get_unique_name(_ability);
				
					_char.tween_create(_name, new ITweenConfig({
						direction: 0,
						distance:  5,
						height:	  -10,
						duration:  10,
					})); 
				},
				
				on_update:	function(_char, _ability, _phase) {
					if (_char.sprite_frame_hit(2)) {	
						_char.audio_play(sfx_Arthur_Earthbreaker_smash);
						_char.audio_play_voice_chance(sfx_Arthur_Earthbreaker_smash_voice);
					}
					
				},
			}),
		],
	});

};