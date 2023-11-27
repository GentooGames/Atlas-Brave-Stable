/*
function scr_Arthur_init_abilities_OLD() {
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
	name:				"Arthur Attack",	
	ability_type:		ABILITY.BASIC,	
		
	on_start:			function(_ability) {
	with _ability.owner {
			

	}},
	
	phase_array: [
		new iPhase({ // ATTACK 1	
 
			keyframes: [{
				frame:			3,
				func:			function(_ability) {
				with _ability.owner {
					var _d = -1, _h = obj_hitbox, _s = obj_smear;
					
					char_set_facing(_ability.input_angle);
					
					tween =			new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			15,
						distance:			6,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({	
						ability:			_ability,
						damage:				90,
						hit_stun:			30,
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
				
				}}
			}],
 
			cancels: [{
				type:			ABILITY.DEFENSE,	
				input_window:	[4,7],				
				exit_frame:		5,					
			}],
				
			combo_window:		[3,7],
		}), // PHASE END
	
		new iPhase({ // ATTACK 2	
 
			keyframes: [{
				frame:			3,
				func:			function(_ability) {
				with _ability.owner {
					var _d = -1, _h = obj_hitbox, _s = obj_smear;
					
					char_set_facing(_ability.input_angle);
					
					tween =			new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			10,
						distance:			4,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({	
						ability:			_ability,
						damage:				100,
						hit_stun:			30,
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));

				}}
			}],
 
			cancels: [{
				type:			ABILITY.DEFENSE,	// Using your Defense ability cancels remaining x frame of Abel's Attack
				input_window:	[3,5],					// What frames can this be pressed on (avoid spam buffering)
				exit_frame:		4,						// Earliest frame the animation can exit
			}],
				
			combo_window:		[3,7],
		}), // PHASE END
		
		new iPhase({ // ATTACK 3	
			input_limit:		45,
			chargeable:			true,
			charge_min:			0,
			charge_max:			20,
			charge_frame:		6,
			charge_offset:		[-12,4],
			
			keyframes: [{
				frame:			7,
				func:			function(_ability) {
				with _ability.owner {
					var _d = -1, _h = obj_hitbox, _s = obj_smear, _v = obj_vfx;
					
					char_set_facing(_ability.input_angle);
						
					var _hb_offset = 30;
					var _hb_x = x +		lengthdir_x(_hb_offset,_ability.input_angle);
					var _hb_y = y + 5 +	lengthdir_y(_hb_offset,_ability.input_angle);
					
					tween =			new iTween({	
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
						sprite_index:	spr_Arthur_Impact_VFX,
					}));
				}}
			}],
 
			cancels: [{
				type:			ABILITY.DEFENSE,	
				input_window:	[6,9],					
				exit_frame:		7,						
			}]
		}), // PHASE END
	],
};

//  _____        __               _ 
// |  __ \      / _|             | |
// | |  | | ___| |_ ___ _ __   __| |
// | |  | |/ _ |  _/ _ | '_ \ / _` |
// | |__| |  __| ||  __| | | | (_| |
// |_____/ \___|_| \___|_| |_|\__,_|

_data[$ "Defend"] = {
	name:				"Defend",
	ability_type:		ABILITY.DEFENSE,
		
	on_start:			function(_ability) {
	with _ability.owner {
			

	}},
	
	on_update:			function(_ability) {
	with _ability.owner {
		
		if anim.hit_frame(2) && input.ability_held[ABILITY.DEFENSE] {
			anim.pause = true;
			anim.sprite.frame = 2;
			anim.sprite.frame_index = 2;
		} else {
			anim.pause = false;
		}
	}},
	
	phase_array: [
		new iPhase({ // BLOCK
 
			keyframes: [{
				frame:			2,
				func:			function(_ability) {
				with _ability.owner {

					// create shield
			
				}}
			}],
 	
		}), // PHASE END
	],
};

//  _    _                                       _______ _                       
// | |  | |                                     |__   __| |                      
// | |__| | __ _ _ __ ___  _ __ ___   ___ _ __     | |  | |__  _ __ _____      __
// |  __  |/ _` | '_ ` _ \| '_ ` _ \ / _ | '__|    | |  | '_ \| '__/ _ \ \ /\ / /
// | |  | | (_| | | | | | | | | | | |  __| |       | |  | | | | | | (_) \ V  V / 
// |_|  |_|\__,_|_| |_| |_|_| |_| |_|\___|_|       |_|  |_| |_|_|  \___/ \_/\_/  

_data[$ "Hammer Throw"] = {
	name:				"Hammer Throw",
	ability_type:		ABILITY.PRIMARY,
		
	on_start:			function(_ability) {
	with _ability.owner {
		
		var _hammer = char_find_obj("Arthur_Hammer");		
		if _hammer != undefined {
			
			_hammer.move_script = scr_Arthur_Hammer_Return;
			ability_end(_ability);
		}	
	}},
	
	phase_array: [
		new iPhase({ // THROW
 
			keyframes: [{
				frame:			5,
				func:			function(_ability) {
				with _ability.owner {
					var _d = -1, _h = obj_hitbox, _p = obj_projectile;
					
					char_set_facing(_ability.input_angle);
					
					var _proj =		create(x,y,_d,_p,new iProjectile({
						sprite_index:		spr_Arthur_Hammer_Proj,
						input_angle:		_ability.input_angle,
						duration:			150,
						anchor:				false,
					})); 
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({	
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
						
					char_add_obj("Arthur_Hammer",_proj);
					
					//var _vfx
				}}
			}],
 	
		}), // PHASE END
	],
};

function scr_Arthur_Hammer_Return(_proj) {
with _proj {
	
	var _speed_min = 3;
	var _speed_max = 9;
	var _dir = point_direction(x,y,owner.x,owner.y);
	
	var _speed = ease(EASE.OUT_QUINT,timer,_speed_min,_speed_max,30,0);
	
	x_speed = lengthdir_x(_speed,_dir);
	y_speed = lengthdir_y(_speed,_dir);
	
	var _inst = place_meeting(x,y,owner);
	if (_inst)	instance_destroy();
	
	
	timer ++;
}}

//  ______           _   _     _                    _             
// |  ____|         | | | |   | |                  | |            
// | |__   __ _ _ __| |_| |__ | |__  _ __ ___  __ _| | _____ _ __ 
// |  __| / _` | '__| __| '_ \| '_ \| '__/ _ \/ _` | |/ / _ | '__|
// | |___| (_| | |  | |_| | | | |_) | | |  __| (_| |   |  __| |   
// |______\__,_|_|   \__|_| |_|_.__/|_|  \___|\__,_|_|\_\___|_|                                                               

_data[$ "Earthbreaker"] = {
	name:				"Earthbreaker",
	ability_type:		ABILITY.SECONDARY,
		
	on_start:			function(_ability) {
	with _ability.owner {
			
	}},
	
	phase_array: [
		new iPhase({ // ATTACK
 
			keyframes: [{
				frame:			3,
				func:			function(_ability) {
				with _ability.owner {

					
			
				}}
			}],
 	
		}), // PHASE END
	],
};

return _data
}