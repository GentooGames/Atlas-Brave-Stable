
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   ______  ______    //
	// /\  ___\ /\__  _\/\  __ \ /\__  _\/\  ___\   //
	// \ \___  \\/_/\ \/\ \  __ \\/_/\ \/\ \___  \  //
	//  \/\_____\  \ \_\ \ \_\ \_\  \ \_\ \/\_____\ //
	//   \/_____/   \/_/  \/_/\/_/   \/_/  \/_____/ //
	//                                              //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function CharacterStats(_config = {}) constructor {
		
		// public
		static initialize  = function() {};
		static cleanup	   = function() {};
		static serialize   = function() {
			return json_stringify(__);
		};
		static deserialize = function(_string) {
			__ = json_parse(_string);
		};
		
		// private
		__ = {};
		with (__) {
			attacks_used			= 0;
			attacks_hit				= 0;
			attack_accuracy			= 0;
			ability_uptime			= 0;
			ability_defensive_used	= 0;
			ability_secondary_used	= 0;
			ultimates_used			= 0;
			damage_taken			= 0;
			damage_avoided			= 0;
			life_healed				= 0;
			potions_used			= 0;
			exp_gained				= 0;
			enemies_killed			= 0;
			bosses_killed			= 0;
			items_equipped			= 0;
			items_purchased			= 0;
			items_sold				= 0;
			items_upgraded			= 0;
			auras_equipped			= 0;
			gold_aquired			= 0;
			footsteps_taken			= 0;
			rooms_traversed			= 0;
			rooms_explored			= 0;
			chests_opened			= 0;
			healing_totems_used		= 0;
		};
	};
	


