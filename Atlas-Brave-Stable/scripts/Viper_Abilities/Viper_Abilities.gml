	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //	
	//  __   __ __   ______  ______   ______    //
	// /\ \ / //\ \ /\  == \/\  ___\ /\  == \   //
	// \ \ \'/ \ \ \\ \  _-/\ \  __\ \ \  __<   //
	//  \ \__|  \ \_\\ \_\   \ \_____\\ \_\ \_\ //
	//   \/_/    \/_/ \/_/    \/_____/ \/_/ /_/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function Viper_Abilities_Init() {
		
		ABILITY_CONFIG[$ "Viper Attack"] = new IAbilityConfig({
			name:  "Viper Attack",
			type:	ABILITY.BASIC,
			phases:	[
				new IAbilityPhaseConfig({
					on_update: function(_char, _ability, _phase) {
						if (_char.sprite_frame_hit(7)) {
						
							var _name		= _char.ability_get_unique_name(_ability);
							var _move_dir	= _char.input_move_vector_get_direction_snapshot();
						
							_char.sprite_set_facing();
							
							var _move_tween = new ITweenConfig({
								direction: _move_dir,
								distance:   10,
								duration:   20,
							}); 
						
							_char.tween_create (_name, _move_tween);
							_char.hitbox_create(_name, new IHitboxConfig({
								damage:		100,
								hit_stun:	20,
								knockback:	_move_tween,
							}));
							_char.smear_create (_name, new ISmearConfig());
						}
					},
				}),
			],
		});
		
	};
	