
// -------------------------------------------------------------- //

//  ______                           _     _ _ _ _   _           
// |  ____|                    /\   | |   (_) (_) | (_)          
// | |__   _ __  _______      /  \  | |__  _| |_| |_ _  ___  ___ 
// |  __| | '_ \|_  / _ \    / /\ \ | '_ \| | | | __| |/ _ \/ __|
// | |____| | | |/ / (_) |  / ____ \| |_) | | | | |_| |  __/\__ \
// |______|_| |_/___\___/  /_/    \_\_.__/|_|_|_|\__|_|\___||___/	

// -------------------------------------------------------------- //

function Enzo_Abilities_Init() {
	
ABILITY_CONFIG[$ "Enzo Attack"]	= new IAbilityConfig({
	name:				"Enzo Attack",
	type:				 ABILITY.BASIC,
	
	phases:		   [
		new IAbilityPhaseConfig({ // ATTACK
			on_update:		   function(_char, _ability, _phase) {
					
				if (_char.sprite_frame_hit(6)) {
					var _name		= _char.ability_get_unique_name(_ability);
					var _input_dir	= _char.input_move_vector_get_direction_snapshot();
						
					_char.projectile_create(_name, new IProjectileConfig({
						direction:		_input_dir,
						distance:		110,
						speed:			5,
						anim_end_pause: true,
						
						hitbox:		new IHitboxConfig({
							damage:		.8,
							hit_stun:	20,
							knockback:	new ITweenConfig({
								direction: _input_dir,
								distance:   5,
								duration:   10,
							}),
						})
					}));
						
				};
					
			},
		}), // PHASE END
	],
	
});

ABILITY_CONFIG[$ "Backflip"]	= new IAbilityConfig({
	name:		  "Backflip",
	type:		   ABILITY.DEFENSE,
	
	on_start:			function(_char, _ability) {
		//_ability.set_cooldown();
	},
	
	phases:		   [
		new IAbilityPhaseConfig({ // BACKFLIP
			on_update:		   function(_char, _ability, _phase) {
				
				if (_char.sprite_frame_hit(0)) {
					var _name		= _char.ability_get_unique_name(_ability);
					var _input_dir	= _char.input_move_vector_get_direction_snapshot();
					_char.sprite_set_facing();
						
					_char.tween_create (_name, new ITweenConfig({
						direction: _input_dir-180,
						distance:   60,
						duration:   60,
					})); 
					
				}
					
			},
				
		}), // PHASE END
	],
	
});

ABILITY_CONFIG[$ "Sidewinder"]	= new IAbilityConfig({
	name:		  "Sidewinder",
	type:		   ABILITY.PRIMARY,
	
	on_start:			function(_char, _ability) {
		//_ability.set_cooldown();
	},
	
	phases:		   [
		new IAbilityPhaseConfig({ // SIDEWINDER
			on_update:		   function(_char, _ability, _phase) {
					
				if (_char.sprite_frame_hit(8)) {
					var _name		= _char.ability_get_unique_name(_ability);
					var _input_dir	= _char.input_move_vector_get_direction_snapshot();
						
					_char.projectile_create(_name, new IProjectileConfig({
						direction:		_input_dir,
						distance:		160,
						speed:			5,
					}));
						
					_char.effect_create(_name+"_smoke", new IEffectConfig({ 
						sprite_index:	spr_Enzo_Sidewinder_smoke_vfx
					}));
						
					_char.effect_create(_name+"_ring", new IEffectConfig({ 
						sprite_index:	spr_Enzo_Sidewinder_ring_vfx
					}));
						
				};
			},
				
		}), // PHASE END
	],
	
});

ABILITY_CONFIG[$ "Caltraps"]	= new IAbilityConfig({
	name:		  "Caltraps",
	type:		   ABILITY.SECONDARY,
	
	on_start:			function(_char, _ability) {
		//_ability.set_cooldown();
	},

	phases:		   [
		new IAbilityPhaseConfig({ //
			on_update:		   function(_char, _ability, _phase) {
					
				if (_char.sprite_frame_hit(3)) {
					var _name		= _char.ability_get_unique_name(_ability);
					var _input_dir	= _char.input_move_vector_get_direction_snapshot();
					_char.sprite_set_facing();
						
					_char.tween_create (_name, new ITweenConfig({
						direction: _input_dir-180,
						distance:   20,
						duration:   30,
					})); 
						
					var _trap_count = 5
					
					for (var i = 1; i <= _trap_count; i++) {
						var _proj_dir =		(_input_dir-60) + i*20 + irandom_range(-5,5);
						var _proj_dist =	45+irandom_range(-5,5);
			
						if (i == 1 || i == 3) _proj_dist -= 15;
							
						_char.projectile_create(_name+"_"+string(i), new IProjectileConfig({
							direction:		_proj_dir,
							duration:		SECOND*5,
							tween:		new ITweenConfig({
								auto_destroy:	false,
								value_end:		_proj_dist,
								duration:		10
							})
						}));
						
					};
					
				};
			},
				
		}), // PHASE END
	],
	
});

}