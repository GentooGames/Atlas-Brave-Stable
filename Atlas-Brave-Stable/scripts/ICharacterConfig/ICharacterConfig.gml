
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______   ______   ______   ______  ______   ______    //
	// /\  ___\ /\ \_\ \ /\  __ \ /\  == \ /\  __ \ /\  ___\ /\__  _\/\  ___\ /\  == \   //
	// \ \ \____\ \  __ \\ \  __ \\ \  __< \ \  __ \\ \ \____\/_/\ \/\ \  __\ \ \  __<   //
	//  \ \_____\\ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_____\  \ \_\ \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_/\/_/ \/_/\/_/ \/_/ /_/ \/_/\/_/ \/_____/   \/_/  \/_____/ \/_/ /_/ //
	//                                                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function ICharacterConfig(_config = {}) constructor {
		
		// meta
		meta = _config[$ "meta"] ?? {};
		meta[$ "type"] ??= undefined;
		meta[$ "name"] ??= "";
		meta[$ "desc"] ??= "";
		
		// sprite
		sprite = _config[$ "sprite"] ?? {};
		sprite[$ "full"		] ??= undefined;
		sprite[$ "portrait"	] ??= undefined;
		sprite[$ "nameplate"] ??= undefined;
		sprite[$ "mask"		] ??= undefined;
		sprite[$ "hurtbox"	] ??= undefined;
		
		// size
		size = _config[$ "size"] ?? {};
		size[$ "height"] ??= 12;
		
		// audio
		audio = _config[$ "audio"] ?? {};
		
		// movement
		movement = _config[$ "movement"] ?? {};
		movement[$ "movespeeds"] ??= [];
		movement[$ "movesets"  ] ??= [];
		movement[$ "collisions"] ??= {};
		movement.collisions[$ "objects"] ??= [];
		
		// combat
		combat = _config[$ "combat"] ?? {};
		combat[$ "hurtbox"] ??= undefined;
		
		// abilities
		abilities = _config[$ "abilities"] ?? {};
	};
	
	