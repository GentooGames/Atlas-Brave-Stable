
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   ______  ______   __    __    //
	// /\ \ /\__  _\/\  ___\ /\ "-./  \   //
	// \ \ \\/_/\ \/\ \  __\ \ \ \-./\ \  //
	//  \ \_\  \ \_\ \ \_____\\ \_\ \ \_\ //
	//   \/_/   \/_/  \/_____/ \/_/  \/_/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function InventoryItem(_config = {}) constructor {
		
		// private
		__ = {};
		with (__) {
			uid			 = _config[$ "uid"			] ?? "";
			name		 = _config[$ "name"			] ?? "";
			rarity		 = _config[$ "rarity"		] ?? 0;
			cost		 = _config[$ "cost"			] ?? 0;
			price		 = _config[$ "price"		] ?? 0;
			weight		 = _config[$ "weight"		] ?? 1;
			health		 = _config[$ "health"		] ?? 0;
			damage		 = _config[$ "damage"		] ?? 0;
			armor		 = _config[$ "armor"		] ?? 0;
			attack_speed = _config[$ "attack_speed"	] ?? 0;
			move_speed	 = _config[$ "move_speed"	] ?? 0;
			cooldown	 = _config[$ "cooldown"		] ?? 0;
			crit		 = _config[$ "crit"			] ?? 0;
			recipe		 = _config[$ "recipe"		] ?? [];
			effects		 = _config[$ "effects"		] ?? [];
			desc		 = _config[$ "desc"			] ?? [];
			active		 = _config[$ "active"		] ?? false;
			active_cd	 = _config[$ "active_cd"	] ?? false;
		};
		
	};
	