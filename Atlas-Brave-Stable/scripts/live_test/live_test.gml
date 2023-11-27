function live_test(_char, _ability, _phase){
	
	if (live_call(_char, _ability, _phase)) return live_result;
	
	if (_char.sprite_frame_hit(3)) {
		
		print("HIT FRAME 4");
						
		var _name		= _char.ability_get_unique_name(_ability);
		var _input_dir	= _char.input_move_vector_get_direction_snapshot();
								
		_char.sprite_set_facing();
						
		_char.tween_create (_name, new ITweenConfig({
			direction: _input_dir,
			distance:   20,
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
}