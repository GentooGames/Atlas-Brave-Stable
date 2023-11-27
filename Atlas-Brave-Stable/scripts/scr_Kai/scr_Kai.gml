/*
function scr_Kai_init_abilitie() {
var _data = {}
// -------------------------------------------------------------- //

//  _  __     _            _     _ _ _ _   _           
// | |/ /    (_)     /\   | |   (_) (_) | (_)          
// | ' / __ _ _     /  \  | |__  _| |_| |_ _  ___  ___ 
// |  < / _` | |   / /\ \ | '_ \| | | | __| |/ _ \/ __|
// | . \ (_| | |  / ____ \| |_) | | | | |_| |  __/\__ \
// |_|\_\__,_|_| /_/    \_\_.__/|_|_|_|\__|_|\___||___/

// -------------------------------------------------------------- //

//          _   _             _    
//     /\  | | | |           | |   
//    /  \ | |_| |_ __ _  ___| | __
//   / /\ \| __| __/ _` |/ __| |/ /
//  / ____ | |_| || (_| | (__|   < 
// /_/    \_\__|\__\__,_|\___|_|\_\

_data[$ "Kai Attack"] = {
	name:				"Kai Attack",
	ability_type:		ABILITY.BASIC,
	
	phase_array: [
		new iPhase({ // ATTACK 1
			
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
						damage:				80,
						hit_stun:			25,
						offset:				10,
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
					
					// spear vfx
					// audio
				}
				
				// combo input
				if (_char.input.attack_pressed() && _ability.hit_frame(4,5,6,7)) _ability.buffer_phase_next(true);
				
				// defense cancel
				if (_char.input.defense_pressed() && _ability.hit_frame(4,5,6,7)) _char.set_cancel_trigger(ABILITY.DEFENSE);
				
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
						damage:				90,
						hit_stun:			25,
						offset:				10,
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
					
					// spear vfx
					// audio
				}
				
				// combo input
				if (_char.input.attack_pressed() && _ability.hit_frame(4,5,6,7)) _ability.buffer_phase_next(true);
				
				// defense cancel
				if (_char.input.defense_pressed() && _ability.hit_frame(4,5,6,7)) _char.set_cancel_trigger(ABILITY.DEFENSE);
				
			},
			
		}), // PHASE END
			
		new iPhase({ // ATTACK 3
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(3) ) {
					
					// set character facing to input angle
					
					var _tween =	new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			10,
						distance:			4,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({		
						ability:			_ability,
						damage:				40,
						hit_stun:			25,
						hit_dist:			2,
						offset:				10,
						duration:			6,
						repetitions:		3,
						//sfx
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:			_ability,
						hitbox:				_hitbox,
						repetitions:		3
					}));
					
					// spear vfx
					// flurry vfx
					// audio
				}
				
			},
			
		}), // PHASE END
			
	]
}

//  ______          _                
// |___  /         | |               
//    / / ___ _ __ | |__  _   _ _ __ 
//   / / / _ \ '_ \| '_ \| | | | '__|
//  / /_|  __/ |_) | | | | |_| | |   
// /_____\___| .__/|_| |_|\__, |_|   
//           | |           __/ |     
//           |_|          |___/      

_data[$ "Zephyr"] = {
	name:				"Zephyr",
	ability_type:		ABILITY.DEFENSE,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// set invulnerability
	},
	
	phase_array: [
		new iPhase({ // ZEPHYR
			
			on_start:			function(_ability) {
				// apply 50% move speed debuff
			},
			
			on_update:			function(_ability) {
				
				if ( _ability.hit_frame(3) ) {
					// remove 50% moves peed debuff
					// remove invulnerability
					
					// apply 100% evasion buff		- 2 second duration
					// apply 25% move speed buff	- 4 second duration
					// apply 25% attack speed buff	- 4 second duration
					
					// create bubble vfx
					// create evasion (ground) vfx
					// audio
				}
				
				// attack cancel
				if (_char.input.attack_pressed() && _ability.hit_frame(5,6,7)) _char.set_cancel_trigger(ABILITY.BASIC);
				
			},
				
		}), // PHASE END
	]
}

// __          ___           _                             
// \ \        / (_)         | |                            
//  \ \  /\  / / _ _ __   __| |_____      _____  ___ _ __  
//   \ \/  \/ / | | '_ \ / _` / __\ \ /\ / / _ \/ _ \ '_ \ 
//    \  /\  /  | | | | | (_| \__ \\ V  V /  __/  __/ |_) |
//     \/  \/   |_|_| |_|\__,_|___/ \_/\_/ \___|\___| .__/ 
//                                                  | |    
//                                                  |_|    

_data[$ "Windsweep"] = {
	name:				"Windsweep",
	ability_type:		ABILITY.PRIMARY,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// set super armor
	},
	
	phase_array: [
		new iPhase({ // WINDSWEEP
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(4) ) {
					
					// no input angle, always defaults to 0
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({		
						ability:			_ability,
						damage:				180,
						hit_stun:			25,
						hit_dist:			30,		// tween dist
						hit_time:			20,		// tween dur
						hit_dir:			HIT_DIR.RADIAL,
						destroy_proj:		1
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
					
				}
				
			},
			
			on_end:				function(_ability) {
				// remove super armor
			},
				
		}), // PHASE END
	]
}

//  _    _                 _                      
// | |  | |               (_)                     
// | |__| |_   _ _ __ _ __ _  ___ __ _ _ __   ___ 
// |  __  | | | | '__| '__| |/ __/ _` | '_ \ / _ \
// | |  | | |_| | |  | |  | | (_| (_| | | | |  __/
// |_|  |_|\__,_|_|  |_|  |_|\___\__,_|_| |_|\___|

_data[$ "Hurricane"] = {
	name:				"Hurricane",
	ability_type:		ABILITY.SECONDARY,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// apply super armor
		// audio
	},
	
	phase_array: [
		new iPhase({ 
			
			on_update:			function(_ability) {
				
				if ( _ability.hit_frame(4) ) {
					
					// set facing
					// remove super armor
					
					var _tween =	new iTween({	// character tween
						input_angle:		_ability.input_angle,
				 		duration:			20,
						distance:			-10,
					});
					
					var _tween =	new iTween({	// hitbox tween
				 		duration:			40,
						move_to_x:			_char.x + lengthdir_x(20,_ability.input_angle),
						move_to_y:			_char.y + lengthdir_y(20,_ability.input_angle),
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({		
						ability:			_ability,
						damage:				20,
						hit_stun:			30,
						// slow debuff
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
					
					// audio
				}
				
				// attack cancel
				if (_char.input.attack_pressed() && _ability.hit_frame(9,10,11,12)) _char.set_cancel_trigger(ABILITY.BASIC);		
				
			},
			
			on_end:				function(_ability) {
				// remove super armor
			},
				
		}), // PHASE END
	]
}

return _data
}