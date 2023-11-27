
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______  ______   ______   ______  //
	// /\  ___\ /\  ___\/\  ___\/\  ___\ /\  ___\ /\__  _\ //
	// \ \  __\ \ \  __\\ \  __\\ \  __\ \ \ \____\/_/\ \/ //
	//  \ \_____\\ \_\   \ \_\   \ \_____\\ \_____\  \ \_\ //
	//   \/_____/ \/_/    \/_/    \/_____/ \/_____/   \/_/ //
    //                                                 	   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IEffectConfig(_config = {}) constructor {
	
		owner			= _config[$ "owner"			] ?? undefined;
		sprite_index	= _config[$ "sprite_index"	] ?? undefined;
		image_speed		= _config[$ "image_speed"	] ?? 1.0;
		x				= _config[$ "x"				] ?? undefined;	
		y				= _config[$ "y"				] ?? undefined;	
		angle			= _config[$ "angle"			] ?? 0;
		facing			= _config[$ "facing"		] ?? 1;
		duration		= _config[$ "duration"		] ?? 10;
		
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
		
		#region ext
		
		sprite_color	= _config[$ "sprite_color"		 ] ?? c_white;
		sprite_alpha	= _config[$ "sprite_alpha"		 ] ?? 1.0;
		angle_locked	= _config[$ "angle_locked"		 ] ?? false;
		facing_locked	= _config[$ "facing_locked"		 ] ?? false;
		scale			= _config[$ "scale"				 ] ?? 1.0;
		scale_x			= _config[$ "scale_x"			 ] ?? scale;
		scale_y			= _config[$ "scale_y"			 ] ?? scale;
		
		#endregion
	};
	