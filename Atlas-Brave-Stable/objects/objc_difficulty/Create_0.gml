
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  _____    __   ______  ______  __   ______   __  __   __       ______  __  __    //
	// /\  __-. /\ \ /\  ___\/\  ___\/\ \ /\  ___\ /\ \/\ \ /\ \     /\__  _\/\ \_\ \   //
	// \ \ \/\ \\ \ \\ \  __\\ \  __\\ \ \\ \ \____\ \ \_\ \\ \ \____\/_/\ \/\ \____ \  //
	//  \ \____- \ \_\\ \_\   \ \_\   \ \_\\ \_____\\ \_____\\ \_____\  \ \_\ \/\_____\ //
	//   \/____/  \/_/ \/_/    \/_/    \/_/ \/_____/ \/_____/ \/_____/   \/_/  \/_____/ //
	//                                                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_difficulty.create //
	event_inherited();
	var _self = self;
	var _data = self[$ "data"] ?? self;
	
	// public
	get_difficulty	 = function() {
		return __.difficulty;
	};
	set_difficulty	 = function(_difficulty) {
		__.difficulty = _difficulty;
		__.data		  = DIFFICULTY_DATA[$ _difficulty];
		return self;
	};
	get_spawn_budget = function() {
		return __.data.spawn.budget_start;
	};
	
	// private 
	with (__) {
		difficulty = "normal";
		data	   = DIFFICULTY_DATA[$ difficulty];
	};
	
	