
// -------------------------------------------------------------- //

//  _  __     _            _     _ _ _ _   _           
// | |/ /    (_)     /\   | |   (_) (_) | (_)          
// | ' / __ _ _     /  \  | |__  _| |_| |_ _  ___  ___ 
// |  < / _` | |   / /\ \ | '_ \| | | | __| |/ _ \/ __|
// | . \ (_| | |  / ____ \| |_) | | | | |_| |  __/\__ \
// |_|\_\__,_|_| /_/    \_\_.__/|_|_|_|\__|_|\___||___/

// -------------------------------------------------------------- //

function Kai_Abilities_Init() {
	
ABILITY_CONFIG[$ "Kai Attack"]	= new IAbilityConfig({
	name:		  "Kai Attack",
	type:		   ABILITY.BASIC,
	
	phases:		   [
		new IAbilityPhaseConfig({ // ATTACK 1

			on_update:		   function(_char, _ability, _phase) {
				
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
						damage:		.8,
						hit_stun:	25,
						offset:		10,
						knockback:	new ITweenConfig({
							direction: _input_dir,
							distance:   6,
							duration:   15,
						}),
					}));
						
					_char.smear_create (_name, new ISmearConfig());
						
					_char.audio_play(sfx_Kai_Attack_1);
					_char.audio_play_voice_chance(sfx_Kai_Attack_voice_1);
				};
				
				// combo buffer
				if (_char.input_ability_basic_down() &&	_char.sprite_frame_in_window(4)) {
					_ability.phase_buffer();
				}
				
			},
		}), // PHASE END
		
		new IAbilityPhaseConfig({ // ATTACK 2

			on_update:		   function(_char, _ability, _phase) {
				
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
						hit_stun:	25,
						offset:		10,
						knockback:	new ITweenConfig({
							direction: _input_dir,
							distance:   6,
							duration:   15,
						}),
					}));
						
					_char.smear_create (_name, new ISmearConfig());
						
					_char.audio_play(sfx_Kai_Attack_2);
					_char.audio_play_voice_chance(sfx_Kai_Attack_voice_2);
				};
				
				// combo buffer
				if (_char.input_ability_basic_down() &&	_char.sprite_frame_in_window(4)) {
					_ability.phase_buffer();
				}
				
			},
		}), // PHASE END
		
		new IAbilityPhaseConfig({ // ATTACK 3

			on_update:		   function(_char, _ability, _phase) {
				
				_phase.__.timer ++;
				
				if (_char.sprite_frame_hit(3)) {
					
					print("TIMER IS " + string(_phase.__.timer));
						
					var _name		= _char.ability_get_unique_name(_ability);
					var _input_dir	= _char.input_move_vector_get_direction_snapshot();
								
					_char.sprite_set_facing();
						
					_char.tween_create (_name, new ITweenConfig({
						direction: _input_dir,
						distance:   4,
						duration:   10,
					})); 
							
					_char.hitbox_create(_name, new IHitboxConfig({
						damage:		.4,
						hit_stun:	20,
						offset:		10,
						knockback:	new ITweenConfig({
							direction: _input_dir,
							distance:   2,
							duration:   5,
						}),
					}));
						
					_char.smear_create (_name, new ISmearConfig());
					
					_char.effect_create(_name+"_vfx", new IEffectConfig({ 
						sprite_index:	spr_Kai_Attack_3_vfx,
					}));
						
					_char.audio_play(sfx_Kai_Attack_3);
					_char.audio_play_voice_chance(sfx_Kai_Attack_voice_3);
				};
				
				if (_char.sprite_frame_hit(5)) {
					
					print("TIMER IS " + string(_phase.__.timer));
						
					var _name		= _char.ability_get_unique_name(_ability);
					var _input_dir	= _char.input_move_vector_get_direction_snapshot();
				
					_char.hitbox_create(_name, new IHitboxConfig({
						damage:		.4,
						hit_stun:	20,
						offset:		10,
						knockback:	new ITweenConfig({
							direction: _input_dir,
							distance:   2,
							duration:   5,
						}),
					}));
						
					_char.smear_create (_name, new ISmearConfig());
					
					_char.effect_create(_name+"_vfx", new IEffectConfig({ 
						sprite_index:	spr_Kai_Attack_3_vfx
					}));
				};
				
				if (_char.sprite_frame_hit(7)) {
					
					print("TIMER IS " + string(_phase.__.timer));
						
					var _name		= _char.ability_get_unique_name(_ability);
					var _input_dir	= _char.input_move_vector_get_direction_snapshot();
				
					_char.hitbox_create(_name, new IHitboxConfig({
						damage:		.4,
						hit_stun:	20,
						offset:		10,
						knockback:	new ITweenConfig({
							direction: _input_dir,
							distance:   2,
							duration:   5,
						}),
					}));
						
					_char.smear_create (_name, new ISmearConfig());
					
					_char.effect_create(_name+"_vfx", new IEffectConfig({ 
						sprite_index:	spr_Kai_Attack_3_vfx
					}));
				};
				
			},
		}), // PHASE END
		
		
	],
	
});

ABILITY_CONFIG[$ "Zephyr"]	= new IAbilityConfig({
	name:		  "Zephyr",
	type:		   ABILITY.DEFENSE,
	
	on_start:			function(_char, _ability, _phase) {

	},
	
	phases:		   [
		new IAbilityPhaseConfig({ //
			
			on_update:		   function(_char, _ability, _phase) {
				
			},
		}), // PHASE END
	],
	
});

ABILITY_CONFIG[$ "Windsweep"]	= new IAbilityConfig({
	name:		  "Windsweep",
	type:		   ABILITY.PRIMARY,
	
	on_start:			function(_char, _ability, _phase) {
		
	},
	
	phases:		   [
		new IAbilityPhaseConfig({ //
			
			on_update:		   function(_char, _ability, _phase) {
				
			},
		}), // PHASE END
	],
	
});

ABILITY_CONFIG[$ "Hurricane"]	= new IAbilityConfig({
	name:		  "Hurricane",
	type:		   ABILITY.SECONDARY,
	
	on_start:			function(_char, _ability, _phase) {
		
	},
	
	phases:		   [
		new IAbilityPhaseConfig({ //

			on_update:		   function(_char, _ability, _phase) {
				
			},
		}), // PHASE END
	],
	
});
	
	
	
	
	
	
	
	
	
	
	
	
}