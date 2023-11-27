
	/*
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __       __   ______  __  __    //
	// /\  __ \ /\  == \ /\ \ /\ \     /\ \ /\__  _\/\ \_\ \   //
	// \ \  __ \\ \  __< \ \ \\ \ \____\ \ \\/_/\ \/\ \____ \  //
	//  \ \_\ \_\\ \_____\\ \_\\ \_____\\ \_\  \ \_\ \/\_____\ //
	//   \/_/\/_/ \/_____/ \/_/ \/_____/ \/_/   \/_/  \/_____/ //
	//                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	global.ability_config.backflip	 = new IAbilityConfig({
		type:	  ABILITY.DEFENSE,
		name:	 "Backflip",
		on_start: function(_char, _ability) {
			var _move_dir = _char.input_move_vector_get_direction_inverted();
			_char.move_velocity_max_out(_move_dir);
		},
		phases:	  [
			new IAbilityPhaseConfig({
				sprite_string: "Abel_Roll",
				image_speed:	0.25,
				on_update:		function(_char, _ability) {
					// tween : we cant guarantee that there will be any sort of input
					// or steer vector being registered at this point. in order to 
					// ensure proper movement still, we need to grab the output vectors
					// direction and use that for controlling the tween.
					var _name	   = _char.ability_get_unique_name();
					var _vector    = _char.move_velocity_get_vector_output();
					var _tween_dir = _vector.get_direction();
					_char.move_adjust_position_by_tween(_name, _tween_dir);
				},
	 			keyframes:		[ 
					{	frame: 0,
						callback: function(_char, _ability) {
							var _name = _char.ability_get_unique_name();
							_char.tween_create_type(_name, "roll");
							_char.audio_play(sfx_abel_roll);
							_char.audio_play_voice_chance(sfx_abel_roll_voice);
						},
					}
				],
			}),
		],
	});
	global.ability_config.item_consume = new IAbilityConfig({
		type:	ABILITY.BASIC,
		name:  "Item Use",
		phases:	[
			new IAbilityPhaseConfig({
				sprite_string: "Item_Consume",
				image_speed:    0.15,
			}),
		],
	});
		