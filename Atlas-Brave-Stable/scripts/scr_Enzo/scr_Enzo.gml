/*
function scr_Enzo_init_abilities() {
var _data = {}

// -------------------------------------------------------------- //

//  ______                           _     _ _ _ _   _           
// |  ____|                    /\   | |   (_) (_) | (_)          
// | |__   _ __  _______      /  \  | |__  _| |_| |_ _  ___  ___ 
// |  __| | '_ \|_  / _ \    / /\ \ | '_ \| | | | __| |/ _ \/ __|
// | |____| | | |/ / (_) |  / ____ \| |_) | | | | |_| |  __/\__ \
// |______|_| |_/___\___/  /_/    \_\_.__/|_|_|_|\__|_|\___||___/	

// -------------------------------------------------------------- //

//          _   _             _    
//     /\  | | | |           | |   
//    /  \ | |_| |_ __ _  ___| | __
//   / /\ \| __| __/ _` |/ __| |/ /
//  / ____ | |_| || (_| | (__|   < 
// /_/    \_\__|\__\__,_|\___|_|\_\

_data[$ "Enzo Attack"] = {
	name:				"Enzo Attack",
	ability_type:		ABILITY.BASIC,
	
	on_start:			function(_ability) {
		// check for attack buffer
		// check for backflip cancel
	},
	
	phase_array: [
		new iPhase({ // ATTACK
			
			on_start:			function(_ability) {
				// audio
			},
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
			
				// set input angle each frame
				// set facing based on angle
				
				var _charge_min = 0, _charge_max = 20;
				

				if ( _ability.hit_frame(5) ) {			// CHARGE
					
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
				
				if ( _ability.hit_frame(6) ) {			// RELEASE
					
					// create arrow proj
					// create hitbox
					// create vfx
					// audio
				}			
				
				// set attack buffer if attack_pressed
			},
				
		}), // PHASE END
	]
}

//  ____             _     __ _ _       
// |  _ \           | |   / _| (_)      
// | |_) | __ _  ___| | _| |_| |_ _ __  
// |  _ < / _` |/ __| |/ /  _| | | '_ \ 
// | |_) | (_| | (__|   <| | | | | |_) |
// |____/ \__,_|\___|_|\_\_| |_|_| .__/ 
//                               | |    
//                               |_|    

_data[$ "Backflip"] = {
	name:				"Backflip",
	ability_type:		ABILITY.DEFENSE,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// set invulnerability
	},
	
	phase_array: [
		new iPhase({ // BACKFLIP
			
			input_limit:		false,	// remove default input limit so you can flip in any direction
			
			on_start:			function(_ability) {
				var _char = _ability.owner;
				// set character facing to input angle
					
				var _tween =	new iTween({	
					input_angle:		_ability.input_angle-180,
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
				if (_char.input.attack_pressed() && _ability.hit_frame_window(5,10)) _char.set_cancel_trigger(ABILITY.BASIC);
				
				// sidewinder cancel
				if (_char.input.primary_pressed() && _ability.hit_frame_window(5,10)) _char.set_cancel_trigger(ABILITY.PRIMARY);
			},
			
			on_end:				function(_ability) {
				var _char = _ability.owner;
				// remove invulnerability
			},
				
		}), // PHASE END
	]
}

//   _____ _     _               _           _           
//  / ____(_)   | |             (_)         | |          
// | (___  _  __| | _____      ___ _ __   __| | ___ _ __ 
//  \___ \| |/ _` |/ _ \ \ /\ / / | '_ \ / _` |/ _ \ '__|
//  ____) | | (_| |  __/\ V  V /| | | | | (_| |  __/ |   
// |_____/|_|\__,_|\___| \_/\_/ |_|_| |_|\__,_|\___|_|   

_data[$ "Sidewinder"] = {
	name:				"Sidewinder",
	ability_type:		ABILITY.PRIMARY,
	
	on_start:			function(_ability) {
		var _char = _ability.owner;
		
		_ability.set_cooldown();
		// set super armor
		// check for backflip cancel
	},
	
	phase_array: [
		new iPhase({ // SIDEWINDER
			
			on_start:			function(_ability) {
				var _char = _ability.owner;
				// audio
			},
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				// get input angle for the first 4 frames
				
				if ( _ability.hit_frame(8) ) {
					
					// set character facing to input angle
					
					// create projectile
					// create hitbox
					// create vfx
					// audio
					
				}
				
			},
			
			on_end:				function(_ability) {
				var _char = _ability.owner;
				// remove super armor
			},
				
		}), // PHASE END
	]
}

//   _____      _ _                       
//  / ____|    | | |                      
// | |     __ _| | |_ _ __ __ _ _ __  ___ 
// | |    / _` | | __| '__/ _` | '_ \/ __|
// | |___| (_| | | |_| | | (_| | |_) \__ \
//  \_____\__,_|_|\__|_|  \__,_| .__/|___/
//                             | |        
//                             |_|        

_data[$ "Caltraps"] = {
	name:				"Caltraps",
	ability_type:		ABILITY.SECONDARY,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
		// set invulnerability
		// set super armor
	},
	
	phase_array: [
		new iPhase({ // CALTRAPS
			
			on_update:			function(_ability) {
				var _char = _ability.owner;
				
				if ( _ability.hit_frame(3) ) {
					// remove invulnerability
					
					// create projectiles
					// create hitboxes - slow debuff
					// create leap tween
					
				}
				
				// attack cancel
				if (_char.input.attack_pressed() && _ability.hit_frame_window(6,9)) _char.set_cancel_trigger(ABILITY.BASIC);
				
			},
			
			on_end:				function(_ability) {
				var _char = _ability.owner;
				// remove invulnerability - just in case
				// remove super armor
			},
				
		}), // PHASE END
	]
}

return _data
}








