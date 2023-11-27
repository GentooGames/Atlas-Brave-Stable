
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   __  __   ______  ______  ______   ______   __  __    //
	// /\ \_\ \ /\ \/\ \ /\  == \/\__  _\/\  == \ /\  __ \ /\_\_\_\   //
	// \ \  __ \\ \ \_\ \\ \  __<\/_/\ \/\ \  __< \ \ \/\ \\/_/\_\/_  //
	//  \ \_\ \_\\ \_____\\ \_\ \_\ \ \_\ \ \_____\\ \_____\ /\_\/\_\ //
	//   \/_/\/_/ \/_____/ \/_/ /_/  \/_/  \/_____/ \/_____/ \/_/\/_/ //
	//                                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IHurtboxConfig(_config = {}) constructor {
		
		// sprite_index
		sprite_index = _config[$ "sprite_index"] ?? IB_Sprite_Pixel_2x2_White_Precise;
		duration	 = _config[$ "duration"	   ] ?? -1; 

		// stick
		stick_to_owner_angle  = _config[$ "stick_to_owner_angle" ] ?? false; //g* - shouldn't need these for hurtboxes
		stick_to_owner_facing = _config[$ "stick_to_owner_facing"] ?? false;
		stick_to_owner_pos	  = _config[$ "stick_to_owner_pos"	 ] ?? true;
		
		// collisions
		collision_objects = _config[$ "collision_objects"] ?? [];
	};
	