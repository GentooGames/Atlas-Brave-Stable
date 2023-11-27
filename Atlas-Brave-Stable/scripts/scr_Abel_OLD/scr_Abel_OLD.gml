/*
function scr_Abel_init_abilities_OLD() {
var _data = {}
// -------------------------------------------------------------- //

//           _          _            _     _ _ _ _   _           
//     /\   | |        | |     /\   | |   (_) (_) | (_)          
//    /  \  | |__   ___| |    /  \  | |__  _| |_| |_ _  ___  ___ 
//   / /\ \ | '_ \ / _ \ |   / /\ \ | '_ \| | | | __| |/ _ \/ __|
//  / ____ \| |_) |  __/ |  / ____ \| |_) | | | | |_| |  __/\__ \
// /_/    \_\_.__/ \___|_| /_/    \_\_.__/|_|_|_|\__|_|\___||___/

// -------------------------------------------------------------- //

//          _   _             _    
//     /\  | | | |           | |   
//    /  \ | |_| |_ __ _  ___| | __
//   / /\ \| __| __/ _` |/ __| |/ /
//  / ____ | |_| || (_| | (__|   < 
// /_/    \_\__|\__\__,_|\___|_|\_\

_data[$ "Abel Attack"] = {
	name:				"Abel Attack",
	ability_type:		ABILITY.BASIC,
	
	on_start:			function(_ability) {
	with _ability.owner {
		
		// Cancel coming from Arc Slash - Skip to phase 2
		if (cancel_trigger == ABILITY.SECONDARY) { 
			_ability.phase_id = 2;
			_ability.phase = _ability.phase_array[_ability.phase_id-1];
			cancel_trigger = noone;	
		}	
	}},
	
	phase_array: [
		new iPhase({ // ATTACK 1
			on_start:			function(_ability) {
			with _ability.owner {
				
				// Cancel coming from Roll - Skip to frame 3
				if (cancel_trigger == ABILITY.DEFENSE) { 
					image_index = 3; // skip to frame 3
					_ability.phase_array[0].input_window = [3,3];
					cancel_trigger = noone;
				}
			}},
 
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
						offset:				3,
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
				
			combo_window:		[4,7],
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
				 		duration:			15,
						distance:			6,
						easing:				EASE.OUT_QUINT
					});
					
					var _hitbox =	create(x,y,_d,_h,new iHitbox({	
						ability:			_ability,
						damage:				100,
						hit_stun:			30,
						offset:				3
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
					}));
				}}
			}],
 
			cancels: [{
				type:			ABILITY.DEFENSE,
				input_window:	[3,5],				
				exit_frame:		4,					
			}],
				
			combo_window:		[4,7],
		}), // PHASE END
		
		new iPhase({ // ATTACK 3	
			keyframes: [{
				frame:			6,
				func:			function(_ability) {
				with _ability.owner {
					var _d = -1, _h = obj_hitbox, _s = obj_smear;
					
					char_set_facing(_ability.input_angle);
					
					tween =			new iTween({	
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
						offset:				3
					}));
					
					var _smear =	create(x,y,_d,_s,new iSmear({	
						ability:		_ability,
						hitbox:			_hitbox
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

//  _____       _ _ 
// |  __ \     | | |
// | |__) |___ | | |
// |  _  // _ \| | |
// | | \ | (_) | | |
// |_|  \_\___/|_|_|

_data[$ "Roll"] = {
	name:				"Roll",
	ability_type:		ABILITY.DEFENSE,
 
	phase_array: [
		new iPhase({ // ROLL
			input_limit:		false,
 
			keyframes: [{
				frame:			0,
				func:			function(_ability) {
				with _ability.owner {
					
					char_set_facing(_ability.input_angle);
					
					tween =			new iTween({	
						input_angle:		_ability.input_angle,
				 		duration:			60,
						distance:			60,
						easing:				EASE.OUT_QUINT
					});
					
				}}
			}],
			
			cancels: [{
				type:			ABILITY.BASIC,	// Attack cancel on frame 7
				input_window:	[4,8],
				exit_frame:		8,
			}], 
		}), // PHASE END
	], 
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
	//super_armor:		ARMOR.SUPER,
 
	on_start:			function(_ability) {
	with _ability.owner { // Create Whirlwind VFX
			//var _smear_vfx = create_effect(x,y,sAbel_Whirlwind_Smear,oEffectAbove,id);	
			//_smear_vfx.duration = 120;
			
			// Apply Whirlwind MS slow
	}},
 
	phase_array: [
		new iPhase({ // SPIN
			image_speed:	1,
			tick_rate:		20,	// how often to do on_tick
			repetitions:	6,	// total repetitions
			move_enable:	true,
			
			on_tick:			function(_ability) {
			with _ability.owner {
				var _d = -1, _h = obj_hitbox;
					
				var _hitbox =	create(x,y,_d,_h,new iHitbox({	
					ability:			_ability,
					damage:				40,
					hit_stun:			25,
					hit_dir:			HIT_DIR.RADIAL,
					input_angle:		0,
					duration:			20,
				}));
			}},
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
	//super_armor:		ARMOR.SUPER,

	phase_array: [
		new iPhase({ // SLASH

			keyframes: [{
				frame:			5,
				func:			function(_ability) {
				with _ability.owner {
					var _d = -1, _h = obj_hitbox, _s = obj_smear;
					
					char_set_facing(_ability.input_angle);
					
					tween =			new iTween({	
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
			
				}}
			}],
 
			cancels: [{
				type:			ABILITY.BASIC,
				input_window:	[5,9],				
				exit_frame:		10,					
			}]
		}), // PHASE END
	],
};

return _data
}

/*







