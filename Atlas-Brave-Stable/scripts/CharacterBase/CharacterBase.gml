	
	
	function CharacterBase(_config = {}) constructor {
		
		// meta
		meta = _config[$ "meta"] ?? {};
		meta[$ "name"] ??= "";
		meta[$ "desc"] ??= "";
		
		// sprite
		sprite = _config[$ "sprite"] ?? {};
		sprite[$ "full"		] ??= undefined;
		sprite[$ "portrait"	] ??= undefined;
		sprite[$ "nameplate"] ??= undefined;
		sprite[$ "mask"		] ??= undefined;
		sprite[$ "hurtbox"	] ??= undefined;
		
		// gameplay
		combat = _config[$ "combat"] ?? {};
		combat[$ "hurtbox"] ??= undefined;
		// shadow
		// collision
		// bbox
		
		// abilities
		abilities = _config[$ "abilities"] ?? {};
	};