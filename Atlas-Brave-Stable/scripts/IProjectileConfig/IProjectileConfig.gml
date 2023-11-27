	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______      __   ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \    /\ \ /\  ___\ /\  ___\ /\__  _\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \  _\_\ \\ \  __\ \ \ \____\/_/\ \/\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\/\_____\\ \_____\\ \_____\  \ \_\ \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/\/_____/ \/_____/ \/_____/   \/_/  \/_/ \/_____/ \/_____/ //
	//                                                                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IProjectileConfig(_config = {}) constructor {
	
		sprite_index		= _config[$ "sprite_index"		] ?? undefined;
		direction			= _config[$ "direction"			] ?? 0;
		speed				= _config[$ "speed"				] ?? 0;
		tween				= _config[$ "tween"				] ?? undefined;	
		distance			= _config[$ "distance"			] ?? -1;
		duration			= _config[$ "duration"			] ?? -1;
		
		anim_end_pause		= _config[$ "anim_end_pause"	] ?? false;
		anim_end_destroy	= _config[$ "anim_end_destroy"	] ?? false;
		destroy_on_end		= _config[$ "destroy_on_end"	] ?? true;
		on_destroy			= _config[$ "on_destroy"		] ?? undefined;
		move_script			= _config[$ "move_script"		] ?? undefined;
		
		hitbox				= _config[$ "hitbox"			] ?? undefined;
	
	};
	
	