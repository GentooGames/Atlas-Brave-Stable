
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______    //
	// /\  __ \ /\ \/\ \ /\  == \ /\  __ \   //
	// \ \  __ \\ \ \_\ \\ \  __< \ \  __ \  //
	//  \ \_\ \_\\ \_____\\ \_\ \_\\ \_\ \_\ //
	//   \/_/\/_/ \/_____/ \/_/ /_/ \/_/\/_/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IAuraConfig(_config = {}) constructor {
	
		name   = _config[$ "name"  ] ?? "";
		hitbox = _config[$ "hitbox"] ?? undefined;
		
	};
	