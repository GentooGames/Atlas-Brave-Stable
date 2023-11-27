/*
function scr_Arthur_init_abilities() {
var _data = {}

// ------------------------------------------------------------------------- //

//                _   _                           _     _ _ _ _   _          
//     /\        | | | |                    /\   | |   (_| (_| | (_)         
//    /  \   _ __| |_| |__  _   _ _ __     /  \  | |__  _| |_| |_ _  ___ ___ 
//   / /\ \ | '__| __| '_ \| | | | '__|   / /\ \ | '_ \| | | | __| |/ _ / __|
//  / ____ \| |  | |_| | | | |_| | |     / ____ \| |_) | | | | |_| |  __\__ \
// /_/    \_|_|   \__|_| |_|\__,_|_|    /_/    \_|_.__/|_|_|_|\__|_|\___|___/

// ------------------------------------------------------------------------- //

//          _   _             _    
//     /\  | | | |           | |   
//    /  \ | |_| |_ __ _  ___| | __
//   / /\ \| __| __/ _` |/ __| |/ /
//  / ____ | |_| || (_| | (__|   < 
// /_/    \_\__|\__\__,_|\___|_|\_\

_data[$ "Arthur Attack"] = {
	name:				"Attack",
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
				if (_char.input.attack_pressed() && _ability.hit_frame(4,5,6)) _ability.buffer_phase_next(true);
			},
				
		}), // PHASE END

		new iPhase({ // ATTACK 2
			
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
				if (_char.input.attack_pressed() && _ability.hit_frame(4,5,6)) _ability.buffer_phase_next(true);
			},
				
		}), // PHASE END
		
		new iPhase({ // ATTACK 3
			
			input_limit:	45,
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				var _charge_min = 0, _charge_max = 20;

				if ( _ability.hit_frame(6) ) {			// CHARGE
					
					var _in_range = _ability.timer < _charge_max && _ability.timer >= _charge_min;
					
					// this should be a charge function
					if ( _char.input.attack_down() && _in_range ) {	// HOLD CHARGE
						var _charge_x = x+(-12*image_xscale);
						var _charge_y = y+4;
				
						if ( _ability.timer == 0 ) create(_charge_x,_charge_y,-1,obj_vfx,new iVFX({
							sprite_index:	spr_Charge_VFX,
						}));
				
						_char.anim.pause = true;
						_ability.timer ++;
		
					} else {
						_char.anim.pause = false;					// END CHARGE
					}
			
					if _ability.timer < _charge_min { // Hold min charge
						_ability.timer ++;
					}
				}
				
				if ( _ability.hit_frame(7) ) {			// SLAM
					
					// set character facing to input angle
					
					var _hb_offset = 30;
					var _hb_x = x +		lengthdir_x(_hb_offset,_ability.input_angle);
					var _hb_y = y + 5 +	lengthdir_y(_hb_offset,_ability.input_angle);
					
					//var _damage = base_damage * charge_time;
					
					var _tween =	new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			5,
						distance:			2,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(_hb_x,_hb_y,_d,_h,new iHitbox({	
						ability:			_ability,
						damage:				120,
						hit_stun:			35,
						hit_dist:			20,
						input_angle:		0,
						duration:			12,
						anchor:				false
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						input_angle:	_ability.input_angle,
					}));
					
					var _vfx =		create(_hb_x,_hb_y,_d,_v,new iVFX({ // Impact
						sprite_index:	spr_Arthur_impact_vfx,
					}));
						
					// audio
				}			
			},
				
		}), // PHASE END
	]
}

//  _____        __               _ 
// |  __ \      / _|             | |
// | |  | | ___| |_ ___ _ __   __| |
// | |  | |/ _ |  _/ _ | '_ \ / _` |
// | |__| |  __| ||  __| | | | (_| |
// |_____/ \___|_| \___|_| |_|\__,_|

_data[$ "Defend"] = {
	name:				"Defense",
	ability_type:		ABILITY.DEFENSE,
	
	on_end:				function(_ability) {
		_ability.set_cooldown();
		// set super armor
	},
	
	phase_array: [
		new iPhase({ // BLOCK
			
			on_start:			function(_ability) {
				
				// lock facing
				// apply 75% move speed slow
				
			},
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(2) ) { // this probably won't work with the move sprites
					
					// remove super armor
					
					// create shield obj
					
					if ( _char.input.defense_down() ) { // hold shield
						
						// enable movement
						
						if (move_input) 
							anim.sprite.index = spr_Arthur_Defend_move;
						else
							anim.sprite.index = spr_Arthur_Defend; 
						
					} else {
						_ability.end_ability();	
					}
		
				}
				
			},
			
			on_end:				function(_ability) {
				// remove facing lock
				// remove move speed slow
			},
				
		}), // PHASE END
	]
}

//  _    _                                       _______ _                       
// | |  | |                                     |__   __| |                      
// | |__| | __ _ _ __ ___  _ __ ___   ___ _ __     | |  | |__  _ __ _____      __
// |  __  |/ _` | '_ ` _ \| '_ ` _ \ / _ | '__|    | |  | '_ \| '__/ _ \ \ /\ / /
// | |  | | (_| | | | | | | | | | | |  __| |       | |  | | | | | | (_) \ V  V / 
// |_|  |_|\__,_|_| |_| |_|_| |_| |_|\___|_|       |_|  |_| |_|_|  \___/ \_/\_/  

_data[$ "Hammer Throw"] = {
	name:				"Primary",
	ability_type:		ABILITY.PRIMARY,
	
	on_start:			function(_ability) {
		// apply super armor - only if throwing
		
		if _hammer_obj_exists {
			// set hammer obj to return movement
			// end ability
		} 
	},
	
	phase_array: [
		new iPhase({ // THROW
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(5) ) {
					
					var _proj =		create(x,y,_d,_p,new iProjectile({
						sprite_index:		spr_Arthur_Hammer_proj,
						input_angle:		_ability.input_angle,
						duration:			150,
						anchor:				false,
					})); 
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({	// repeat 8 times - only after stopping at destination
						owner:				_proj,
						ability:			_ability,
						damage:				25,
						hit_stun:			20,
						input_angle:		0
					}));
					
					var _tween =	new iTween({	
						owner:				_proj,
						input_angle:		_ability.input_angle,
				 		duration:			30,
						distance:			100,
						easing:				EASE.OUT_QUINT
					});
						
					// add hammer _proj obj list
					// vfx
					// audio
				}
				
			},
			
			on_end:				function(_ability) {
				// remove super armor
			},
				
		}), // PHASE END
	]
}

function scr_Arthur_Hammer_return(_proj) {
with _proj {
	
	var _speed_min = 3;
	var _speed_max = 9;
	var _dir = point_direction(x,y,owner.x,owner.y);
	
	var _speed = ease(EASE.OUT_QUINT,timer,_speed_min,_speed_max,30,0);
	
	x_speed = lengthdir_x(_speed,_dir);
	y_speed = lengthdir_y(_speed,_dir);
	
	var _inst = place_meeting(x,y,owner);
	if (_inst)	instance_destroy(); // set ability cd
	
	
	timer ++;
}}


//  ______           _   _     _                    _             
// |  ____|         | | | |   | |                  | |            
// | |__   __ _ _ __| |_| |__ | |__  _ __ ___  __ _| | _____ _ __ 
// |  __| / _` | '__| __| '_ \| '_ \| '__/ _ \/ _` | |/ / _ | '__|
// | |___| (_| | |  | |_| | | | |_) | | |  __| (_| |   |  __| |   
// |______\__,_|_|   \__|_| |_|_.__/|_|  \___|\__,_|_|\_\___|_|                                                               


_data[$ "Earthbreaker"] = {
	name:				"Secondary",
	ability_type:		ABILITY.SECONDARY,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// set invulnerability
	},
	
	phase_array: [
		new iPhase({ // LEAP
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(5) ) {
					
					// create z tween
					
					// vfx
					// audio
				}
			},
				
		}), // PHASE END
		
		new iPhase({ // SPIN
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				var _charge_min = 20, _charge_max = 60;
				
				var _in_range = _ability.timer < _charge_max && _ability.timer >= _charge_min;
					
				if ( _char.input.secondary_down() && _in_range ) {	// HOLD CHARGE
				
					_ability.timer ++;
		
				} else {
					_ability.go_to_next_phase();					// END CHARGE
				}
			
				if _ability.timer < _charge_min { // Hold min charge
					_ability.timer ++;
				}
			
			},
				
		}), // PHASE END
		
		new iPhase({ // DIVE
			
			on_start:			function(_ability) {
				var _char = _ability.owner;
				
				// create downward z tween
			},
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(2) ) {
					
					// create hitbox
					// create impact vfx
					// audio
					
				}
			
			},
			
			on_end:			function(_ability) {
				var _char = _ability.owner;
				// set 15 frames of invulnerability
			},
				
		}), // PHASE END
	]
}

return _data
}