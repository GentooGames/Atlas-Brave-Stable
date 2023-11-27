/*
var _data = {}
_data[$ "Abel Attack"] = new IAbilityConfig({
	name:	  "Abel Attack",
	uid:	  "abel_attack_combo",				//*g - can we remove this?
	type:	   ABILITY.BASIC,

	on_start:  function(_char, _ability) {
		_char.input_window_set_max(3);			//g* - elaborate on what's happening here
	},
	on_stop:   function(_char, _ability) {
		_char.input_window_clear();				//g* - elaborate on what's happening here
	},
	
	on_update: function(_char, _ability) {
		// roll cancel
		if (_char.input_ability_defense_pressed() && _ability.animation_ended(3)) { //g* - this should be frame window
			_char.ability_cancel();
			_char.ability_start("defense");
		}
	},
	
	phases:	   [
		new IAbilityPhaseConfig({ // 1st hit
			sprite_string:	  "Abel_Attack_1",	//g* - I think this can get removed (use ability name + phase ID)
			image_speed:	   0.25,			//g* - This will get removed, but ofc are necessary for now
			
			on_start:		   function(_char, _ability) {
				_char.input_move_vector_set_snapshot(); /// @override  g* - elaborate on what's happening here
			},
			
			buffer_next_phase: function(_char, _ability) {
				if (_char.input_ability_basic_down() && _ability.animation_ended(4))
					return true;
				else
					return false;
			},
	 		
			keyframes:		   [
				{	frame: 3,
					callback: function(_char, _ability) {
						var _name = _char.ability_get_unique_name(_ability);
						var _move_dir = _char.input_move_vector_get_direction();
						
						// tween
						_char.tween_create_movement(_name, "abel_attack_combo");
						
						// hitbox
						_char.hitbox_create(_name + "_1", "abel_attack_combo_1", _move_dir);
						
						// smear
						_char.effect_create_type(_name + "_1", "abel_attack_combo_1_smear");
						
						// audio
						_char.audio_play(sfx_abel_basic_1);
						_char.audio_play_voice_chance(_char.audio_get_voice_index());
					},
				}
			],
		}),
		new IAbilityPhaseConfig({ // 2nd hit
			sprite_string:    "Abel_Attack_2",
			image_speed:	   0.20,
			on_start:		   function(_char, _ability) {
				_char.input_move_vector_set_snapshot(); /// @override
			},
			buffer_next_phase: function(_char, _ability) {
				if (_char.input_ability_basic_down() 
				&&	_ability.animation_ended(4) // 4 frame window from animation end
				) {
					return true;
				}
				return false;
			},
			keyframes:		   [
				{	frame: 3,
					callback: function(_char, _ability) {
						var _name = _char.ability_get_unique_name(_ability);
							
						// hitbox
						var _move_dir = _char.input_move_vector_get_direction();
						_char.hitbox_create(_name + "_2", "abel_attack_combo_2", _move_dir);
							
						_char.tween_create_movement(_name, "abel_attack_combo");
						_char.effect_create_type(_name + "_2", "abel_attack_combo_2_smear");
						_char.audio_play(sfx_abel_basic_2);
						_char.audio_play_voice_chance(_char.audio_get_voice_index());
					},	
				}
			],
		}),
		new IAbilityPhaseConfig({ // 3rd hit
			sprite_string:    "Abel_Attack_3",
			image_speed:	   0.25,
			on_start:		   function(_char, _ability) {
				_char.input_move_vector_set_snapshot(); /// @override
			},
			buffer_next_phase: function(_char, _ability) {
				if (_char.input_ability_basic_down() 
				&&	_ability.animation_ended(4) // 4 frame window from animation end
				) {
					return true;
				}
				return false;
			},
			keyframes:		   [
				{	frame: 3,
					callback: function(_char, _ability) {
						var _name = _char.ability_get_unique_name(_ability);
							
						// hitbox
						var _move_dir = _char.input_move_vector_get_direction();
						_char.hitbox_create(_name + "_3", "abel_attack_combo_3", _move_dir);
							
						_char.tween_create_movement(_name, "abel_attack_combo");
						_char.effect_create_type(_name + "_3", "abel_attack_combo_3_smear");
						_char.audio_play(sfx_abel_basic_3);
						_char.audio_play_voice_chance(_char.audio_get_voice_index());
					},	
				}
			],
		}),
	],
})


_data[$ "Abel Attack v2"] = new IAbilityConfig({
	name:	  "Abel Attack",
	type:	   ABILITY.BASIC,

	on_start:  function(_char, _ability) {
		_char.input_window_set_max(3);			//g* - elaborate on what's happening here
	},
	on_stop:   function(_char, _ability) {
		_char.input_window_clear();				//g* - elaborate on what's happening here
	},
	
	on_update: function(_char, _ability) {		//g* - interesting idea, but removes flexability (you currently can't cancel out of Abel's 3rd attack
		// roll cancel
		if (_char.input_ability_defense_pressed() && _ability.animation_ended(3)) { //g* - this should be frame window
			_char.ability_cancel();

			_char.ability_start("defense");
		}
	},
	
	phases:	   [
		new IAbilityPhaseConfig({ // 1st hit
			sprite_string:	  "Abel_Attack_1",	//g* - I think this can get removed (use ability name + phase ID)
			image_speed:	   0.25,			//g* - This will get removed, but ofc are necessary for now
			
			on_start:		   function(_char, _ability) {
				_char.input_move_vector_set_snapshot(); /// @override  g* - elaborate on what's happening here
			},
			
			//buffer_next_phase: function(_char, _ability) { // this can get removed and added to update?
			//	if (_char.input_ability_basic_down() && _ability.animation_ended(4))
			//		return true
			//	else
			//		return false
			//},
	 		
			on_update:			function(_char, _ability) {
				
				if ( _char.hit_frame(3) ) { 
				
					//var _move_dir = _char.input_move_vector_get_direction();
						
					// it's really nice to be able to add iTween, iHitbox right here
					// it gives an easy way to reference the variables and defaults of those structs
					
					var _tween =	_char.tween_create_ability({	// removed move type, I think we could just make that an enum param
						input_angle:		_move_dir, // input_dir - could just pass in the ability, then we get name + input_dir
						distance:			6,
						duration:			15,
					});
					
					var _hitbox =	_char.hitbox_create_ability({	// if we don't pass x,y this will break how I offset impact hitboxes
						damage:				90,
						hit_stun:			30,
						offset:				3,
					});
					
					var _smear =	_char.smear_create_ability({	// I changed this to be smear to be more specific - smear is a specific type of effect that always comes with a hitbox
						hitbox:			_hitbox				// smears need a hitbox ref (normally), which allows them to destroy the hitbox when the smer ends
					});
						
					// audio
					_char.audio_play(sfx_abel_basic_1);
					_char.audio_play_voice_chance(_char.audio_get_voice_index());
				}
				
				// combo input
				if (_char.input.attack_pressed() && _char.hit_frame(5,6,7)) _ability.buffer_phase_next(true);
				
			},
			
		}), // PHASE END
	],
})



function scr_Abel_init_abilities() {
var _data = {}
// -------------------------------------------------------------- //

//           _          _            _     _ _ _ _   _           
//     /\   | |        | |     /\   | |   (_) (_) | (_)          
//    /  \  | |__   ___| |    /  \  | |__  _| |_| |_ _  ___  ___ 
//   / /\ \ | '_ \ / _ \ |   / /\ \ | '_ \| | | | __| |/ _ \/ __|
//  / ____ \| |_) |  __/ |  / ____ \| |_) | | | | |_| |  __/\__ \
// /_/    \_\_.__/ \___|_| /_/    \_\_.__/|_|_|_|\__|_|\___||___/

// -------------------------------------------------------------- //

_data[$ "Abel Attack"] = {
	name:				"Abel Attack",
	ability_type:		ABILITY.BASIC,
	
	init:			function(_ability) {
		var _char = _ability.owner;
		
		// init phase advance
		if (_char.get_cancel_trigger() == ABILITY.SECONDARY) { 
			_ability.phase_id = 2;
			_char.cancel_trigger = noone;
		}
		
		// init frame advance
		if (_char.get_cancel_trigger() == ABILITY.DEFENSE) { 
			_char.anim.sprite.frame = 3;
			//_ability.input_window = [3];
			_char.cancel_trigger = noone;
		}
	},
	
	phase_array: [
		new iPhase({ // ATTACK 1
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(3) ) {
					
					// unique name
					// input dir
					
					var _tween =	new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			15,
						distance:			6,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({		
						ability:			_ability,
						damage:				90,
						hit_stun:			30,
						offset:				3,
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
						
					// audio
				}
				
				// combo input
				if (_char.input.attack_pressed() && _ability.hit_frame(5,6,7)) _ability.buffer_phase_next(true);
				
				// defense cancel
<<<<<<< HEAD
				if (_char.input.defense_pressed() && _ability.hit_frame(5,6,7)) _char.set_cancel_trigger(ABILITY.DEFENSE); // coming from ABILITY.BASIC
=======
				if (_char.input.defense_pressed() && _ability.hit_frame(5,6,7)) _char.set_cancel_trigger(ABILITY.DEFENSE);
>>>>>>> gentoo
				
			},
			
		}), // PHASE END
		
		new iPhase({ // ATTACK 2
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(3) ) {
					
					// set character facing to input angle
					
					var _tween =	new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			15,
						distance:			6,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({		
						ability:			_ability,
						damage:				100,
						hit_stun:			30,
						offset:				3,
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
						
					// audio
				}
				
				// combo input
				if (_char.input.attack_pressed() && _ability.hit_frame(5,6,7)) _ability.buffer_phase_next(true);
				
				// defense cancel
				if (_char.input.defense_pressed() && _ability.hit_frame(5,6,7)) _char.set_cancel_trigger(ABILITY.DEFENSE);
				
			},
			
		}), // PHASE END
		
		new iPhase({ // ATTACK 3
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(6) ) {
					
					// set character facing to input angle
					
					var _tween =	new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			20,
						distance:			8,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({		
						ability:			_ability,
						damage:				120,
						hit_stun:			35,
						hit_dist:			20,
						offset:				3,
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
						
					// audio
				}
				
				// defense cancel
				if (_char.input.defense_pressed() && _ability.hit_frame(6,7,8,9)) _char.set_cancel_trigger(ABILITY.DEFENSE);
				
			},
			
		}), // PHASE END
	]
}

// Arc Slash -> Attack
// 


//  _____       _ _ 
// |  __ \     | | |
// | |__) |___ | | |
// |  _  // _ \| | |
// | | \ | (_) | | |
// |_|  \_\___/|_|_|

_data[$ "Roll"] = {
	name:				"Roll",
	ability_type:		ABILITY.DEFENSE,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// set invulnerability
	},
	
	phase_array: [
		new iPhase({ // ROLL
			
			input_limit:		false,	// remove default input limit so you can roll in any direction
			
			on_start:			function(_ability) {
				var _char = _ability.owner;
				// set character facing to input angle
					
				var _tween =	new iTween({	
					input_angle:		_ability.input_angle,
				 	duration:			60,
					distance:			60,
					easing:				EASE.OUT_QUINT
				});
						
				// audio
				// effect
			},
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				// attack cancel
				if (_char.input.attack_pressed() && _ability.hit_frame_window(4,8)) _char.set_cancel_trigger(ABILITY.BASIC);
			},
		
			on_end:				function(_ability) {
				// remove invulnerability
			},
			
		}), // PHASE END
	]
};

// __          ___     _      _          _           _ 
// \ \        / | |   (_)    | |        (_)         | |
//  \ \  /\  / /| |__  _ _ __| __      ___ _ __   __| |
//   \ \/  \/ / | '_ \| | '__| \ \ /\ / | | '_ \ / _` |
//    \  /\  /  | | | | | |  | |\ V  V /| | | | | (_| |
//     \/  \/   |_| |_|_|_|  |_| \_/\_/ |_|_| |_|\__,_|

_data[$ "Whirlwind"] = {
	name:				"Whirlwind",
	ability_type:		ABILITY.PRIMARY,
 
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// set super armor
	},
	
	on_end:				function(_ability) {
		// remove super armor
	},
 
	phase_array: [
		new iPhase({ // SPIN
			duration:		120,
			
			on_update:			function(_ability) {
					
				// enable char movement
				// check for player mastery to enable projectile breaking
				
				if ( _ability.hit_frame(0) ) {
				
					var _hitbox =	create(x,y,_d,_h,new iHitbox({	
						ability:			_ability,
						damage:				40,
						hit_stun:			25,
						hit_dir:			HIT_DIR.RADIAL,
						input_angle:		0,
						//duration:			20,
						//repetitions:		6
					}));
					
				}				
			},
			
		}), // PHASE END
	],
};

//                       _____ _           _     
//     /\               / ____| |         | |    
//    /  \   _ __ ___  | (___ | | __ _ ___| |__  
//   / /\ \ | '__/ __|  \___ \| |/ _` / __| '_ \ 
//  / ____ \| | | (__   ____) | | (_| \__ | | | |
// /_/    \_|_|  \___| |_____/|_|\__,_|___|_| |_|

_data[$ "Arc Slash"] = {
	name:				"Arc Slash",
	ability_type:		ABILITY.SECONDARY,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// set super armor
		// audio
	},

	on_end:				function(_ability) {
		// remove super armor
	},

	phase_array: [
		new iPhase({ // SLASH
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(5) ) {
					
					// set character facing to input angle
					
					var _tween =			new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			20,
						distance:			35,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({	
						ability:			_ability,
						damage:				150,
						hit_stun:			30,
						hit_dist:			20,
						offset:				8
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
						
					// audio
				}
				
				// attack cancel
				if (_char.input.attack_pressed() && _ability.hit_frame_window(5,9)) _char.set_cancel_trigger(ABILITY.BASIC);
			},
			
		}), // PHASE END
	],
};

return _data
}