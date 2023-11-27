	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   __   ______  ______   ______   __  __    //
	// /\ \_\ \ /\ \ /\__  _\/\  == \ /\  __ \ /\_\_\_\   //
	// \ \  __ \\ \ \\/_/\ \/\ \  __< \ \ \/\ \\/_/\_\/_  //
	//  \ \_\ \_\\ \_\  \ \_\ \ \_____\\ \_____\ /\_\/\_\ //
	//   \/_/\/_/ \/_/   \/_/  \/_____/ \/_____/ \/_/\/_/ //
    //													  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IHitboxConfig(_config = {}) constructor {
		
		owner			= _config[$ "owner"			] ?? undefined;
		sprite_index	= _config[$ "sprite_index"	] ?? undefined;
		x				= _config[$ "x"				] ?? undefined;	
		y				= _config[$ "y"				] ?? undefined;
		angle			= _config[$ "angle"			] ?? undefined;
		duration		= _config[$ "duration"		] ?? 10; 
		offset			= _config[$ "offset"		] ?? 0; 
		//facing		= _config[$ "facing"		] ?? 1; // unsure if necessary
		
		damage		= _config[$ "damage"	] ?? 0;
		knockback	= _config[$ "knockback" ] ?? undefined;
		
		hit_stun	= _config[$ "hit_stun"	] ?? 0;				// how long a char stays in hurt state
		hit_pause	= _config[$ "hit_pause"	] ?? 0;				// how long to pause animation and tween timers
		hit_vfx		= _config[$ "hit_vfx"	] ?? true;			// whether this hitbox creates vfx on hit
		hit_limit	= _config[$ "hit_limit" ] ?? noone;			// how many times this hitbox can collide before auto destroy
		hit_dir		= _config[$ "hit_dir"	] ?? HIT_DIR.PUSH;	// how to apply the knockback tween
		hit_text	= _config[$ "hit_text"	] ?? HIT_TEXT.BASIC;// whether this hitbox creates text on hit
		hit_area	= _config[$ "hit_area"	] ?? HIT_AREA.ALL;  // whether this hitbox can hit any part of a hurtbox
		
		stick_to_owner_pos	  = _config[$ "stick_to_owner_pos"	 ] ?? true;
		stick_to_owner_angle  = _config[$ "stick_to_owner_angle" ] ?? false;
		stick_to_owner_facing = _config[$ "stick_to_owner_facing"] ?? true;
		
		// collisions
		collision_objects = _config[$ "collision_objects"] ?? [ combox_collision_object_default() ];
	};
	