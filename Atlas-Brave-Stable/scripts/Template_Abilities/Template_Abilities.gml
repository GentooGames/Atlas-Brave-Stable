
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

function Template_Abilities_Init() {
	
ABILITY_CONFIG[$ "Attack"]	= new IAbilityConfig({
	name:		  "Attack",
	type:		   ABILITY.BASIC,
	
	on_start:			function(_char, _ability) {
		_ability.set_cooldown();
	},
	
	on_end:				function(_char, _ability) {
		
	},
	
	phases:		   [
		new IAbilityPhaseConfig({ // ATTACK 1
			//sprite_index:	   spr_,
			
			on_update:		   function(_char, _ability) {
				
			},
		}), // PHASE END
	],
	
});

ABILITY_CONFIG[$ "Defense"]	= new IAbilityConfig({
	name:		  "Defense",
	type:		   ABILITY.DEFENSE,
	
	on_start:			function(_char, _ability) {
		_ability.set_cooldown();
	},
	
	on_end:				function(_char, _ability) {
		
	},
	
	phases:		   [
		new IAbilityPhaseConfig({ //
			//sprite_index:	   spr_,
			
			on_update:		   function(_char, _ability) {
				
			},
		}), // PHASE END
	],
	
});

ABILITY_CONFIG[$ "Primary"]	= new IAbilityConfig({
	name:		  "Primary",
	type:		   ABILITY.PRIMARY,
	
	on_start:			function(_char, _ability) {
		_ability.set_cooldown();
	},
	
	on_end:				function(_char, _ability) {
		
	},
	
	phases:		   [
		new IAbilityPhaseConfig({ //
			//sprite_index:	   spr_,
			
			on_update:		   function(_char, _ability) {
				
			},
		}), // PHASE END
	],
	
});

ABILITY_CONFIG[$ "Secondary"]	= new IAbilityConfig({
	name:		  "Secondary",
	type:		   ABILITY.SECONDARY,
	
	on_start:			function(_char, _ability) {
		_ability.set_cooldown();
	},
	
	on_end:				function(_char, _ability) {
		
	},
	
	phases:		   [
		new IAbilityPhaseConfig({ //
			//sprite_index:	   spr_,
			
			on_update:		   function(_char, _ability) {
				
			},
		}), // PHASE END
	],
	
});

}