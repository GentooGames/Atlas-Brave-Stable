function template_abilities() {
var _data = {}
// https://patorjk.com/software/taag/#p=display&f=Big&t=
// -------------------------------------------------------------- //

//  _______                   _       _       
// |__   __|                 | |     | |      
//    | | ___ _ __ ___  _ __ | | __ _| |_ ___ 
//    | |/ _ \ '_ ` _ \| '_ \| |/ _` | __/ _ \
//    | |  __/ | | | | | |_) | | (_| | ||  __/
//    |_|\___|_| |_| |_| .__/|_|\__,_|\__\___|
//                     | |                    
//                     |_|					

// -------------------------------------------------------------- //

//          _   _             _    
//     /\  | | | |           | |   
//    /  \ | |_| |_ __ _  ___| | __
//   / /\ \| __| __/ _` |/ __| |/ /
//  / ____ | |_| || (_| | (__|   < 
// /_/    \_\__|\__\__,_|\___|_|\_\

_data[$ "Attack"] = {
	name:				"Attack",
	ability_type:		ABILITY.BASIC,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
	},
	
	on_update:			function(_ability) {
		
	},
	
	on_end:				function(_ability) {
		
	},
	
	phase_array: [
		new iPhase({ 
			
			on_init:			function(_ability) {
				
			},
			
			on_start:			function(_ability) {
				
			},
			
			on_update:			function(_ability) {
				
			},
			
			on_end:				function(_ability) {
				
			},
				
		}), // PHASE END
	]
}

//  _____        __                    
// |  __ \      / _|                   
// | |  | | ___| |_ ___ _ __  ___  ___ 
// | |  | |/ _ \  _/ _ \ '_ \/ __|/ _ \
// | |__| |  __/ ||  __/ | | \__ \  __/
// |_____/ \___|_| \___|_| |_|___/\___|
// 

_data[$ "Defense"] = {
	name:				"Defense",
	ability_type:		ABILITY.DEFENSE,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
	},
	
	on_update:			function(_ability) {
		
	},
	
	on_end:				function(_ability) {
		
	},
	
	phase_array: [
		new iPhase({ 
			
			on_init:			function(_ability) {
				
			},
			
			on_start:			function(_ability) {
				
			},
			
			on_update:			function(_ability) {
				
			},
			
			on_end:				function(_ability) {
				
			},
				
		}), // PHASE END
	]
}

//  _____      _                            
// |  __ \    (_)                           
// | |__) | __ _ _ __ ___   __ _ _ __ _   _ 
// |  ___/ '__| | '_ ` _ \ / _` | '__| | | |
// | |   | |  | | | | | | | (_| | |  | |_| |
// |_|   |_|  |_|_| |_| |_|\__,_|_|   \__, |
//                                     __/ |
//                                    |___/

_data[$ "Primary"] = {
	name:				"Primary",
	ability_type:		ABILITY.PRIMARY,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
	},
	
	on_update:			function(_ability) {
		
	},
	
	on_end:				function(_ability) {
		
	},
	
	phase_array: [
		new iPhase({ 
			
			on_init:			function(_ability) {
				
			},
			
			on_start:			function(_ability) {
				
			},
			
			on_update:			function(_ability) {
				
			},
			
			on_end:				function(_ability) {
				
			},
				
		}), // PHASE END
	]
}

//   _____                          _                  
//  / ____|                        | |                 
// | (___   ___  ___ ___  _ __   __| | __ _ _ __ _   _ 
//  \___ \ / _ \/ __/ _ \| '_ \ / _` |/ _` | '__| | | |
//  ____) |  __/ (_| (_) | | | | (_| | (_| | |  | |_| |
// |_____/ \___|\___\___/|_| |_|\__,_|\__,_|_|   \__, |
//                                                __/ |
//                                               |___/ 

_data[$ "Secondary"] = {
	name:				"Secondary",
	ability_type:		ABILITY.SECONDARY,
	
	on_start:			function(_ability) {
		_ability.set_cooldown();
	},
	
	on_update:			function(_ability) {
		
	},
	
	on_end:				function(_ability) {
		
	},
	
	phase_array: [
		new iPhase({ 
			
			on_init:			function(_ability) {
				
			},
			
			on_start:			function(_ability) {
				
			},
			
			on_update:			function(_ability) {
				
			},
			
			on_end:				function(_ability) {
				
			},
				
		}), // PHASE END
	]
}

return _data
}