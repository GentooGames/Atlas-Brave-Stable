
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  _____    __   ______  ______  __   ______   __  __   __       ______  __  __    //
	// /\  __-. /\ \ /\  ___\/\  ___\/\ \ /\  ___\ /\ \/\ \ /\ \     /\__  _\/\ \_\ \   //
	// \ \ \/\ \\ \ \\ \  __\\ \  __\\ \ \\ \ \____\ \ \_\ \\ \ \____\/_/\ \/\ \____ \  //
	//  \ \____- \ \_\\ \_\   \ \_\   \ \_\\ \_____\\ \_____\\ \_____\  \ \_\ \/\_____\ //
	//   \/____/  \/_/ \/_/    \/_/    \/_/ \/_____/ \/_____/ \/_____/   \/_/  \/_____/ //
	//                                                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	global.difficulty_data = {
		normal: {
			name:  "Normal",
			spawn: {
				budget_gain_log_function: logn,
				budget_start:			  function() {
					return 100;	
				},
				budget_gain:			  function() {
					var _base	   = data_remote[$ "normal"];
					var _limit     = 50;
					var _n_players = objc_game.player_get_active_count();
					return _base + logn(_n_players, _limit);
				},
			}
		},
	};
	#macro DIFFICULTY_DATA global.difficulty_data
	
	
	// spawn_budget_capacity
	// spawn_budget_current
	// spawn_budget_gain
	
	// enemy_level				 = enemy base stats
	// enemy_experience_capacity = 1;
	// enemy_experience_current  = 0;
	// enemy_experience_gain	 = 1.4;
	
	/*
	max enemy level = 50,
		brave difficulty:  limit = 45
		v hard difficulty: limit = 35
		hard difficulty:   limit = 30
		normal difficulty: limit = 25
	should map each different parts to log curves?
	*/

	