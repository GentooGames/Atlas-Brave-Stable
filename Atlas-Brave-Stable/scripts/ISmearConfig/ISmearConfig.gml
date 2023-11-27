
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//	 ______   __    __   ______   ______   ______      //
	//	/\  ___\ /\ "-./  \ /\  ___\ /\  __ \ /\  == \     //
	//	\ \___  \\ \ \-./\ \\ \  __\ \ \  __ \\ \  __<     //
	//	 \/\_____\\ \_\ \ \_\\ \_____\\ \_\ \_\\ \_\ \_\   //
	//	  \/_____/ \/_/  \/_/ \/_____/ \/_/\/_/ \/_/ /_/   //
    //                                           		   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function ISmearConfig(_config = {}) constructor {
	
		owner			= _config[$ "owner"			] ?? undefined;
		hitbox			= _config[$ "hitbox"		] ?? undefined;
		sprite_index	= _config[$ "sprite_index"	] ?? undefined;
		image_speed		= _config[$ "image_speed"	] ?? 1.0;
		x				= _config[$ "x"				] ?? undefined;	
		y				= _config[$ "y"				] ?? undefined;
		angle			= _config[$ "angle"			] ?? undefined;
		duration		= _config[$ "duration"		] ?? 10; 
		offset			= _config[$ "offset"		] ?? 0; 
		//facing		= _config[$ "facing"		] ?? 1; // unsure if necessary
		
		loop_on_end		= _config[$ "loop_on_end"	] ?? false;
		pause_on_end	= _config[$ "pause_on_end"	] ?? false; // needs implementation
		
		stick_to_owner_pos	  = _config[$ "stick_to_owner_pos"	 ] ?? true;
		stick_to_owner_angle  = _config[$ "stick_to_owner_angle" ] ?? false;
		stick_to_owner_facing = _config[$ "stick_to_owner_facing"] ?? true;
		
		#region frame config
		
		frame_config	= _config[$ "frame_config"] ?? [2,		 4,		  2,	   1	  ];
		color_config	= _config[$ "color_config"] ?? [c_white, c_white, c_white, c_white];
		alpha_config	= _config[$ "alpha_config"] ?? [1.0,	 1.0,	  1.0,	   1.0	  ];
		
		#endregion
	};
	