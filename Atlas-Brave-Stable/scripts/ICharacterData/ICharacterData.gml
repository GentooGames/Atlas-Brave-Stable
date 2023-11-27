
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______   ______   ______   ______  ______   ______    //
	// /\  ___\ /\ \_\ \ /\  __ \ /\  == \ /\  __ \ /\  ___\ /\__  _\/\  ___\ /\  == \   //
	// \ \ \____\ \  __ \\ \  __ \\ \  __< \ \  __ \\ \ \____\/_/\ \/\ \  __\ \ \  __<   //
	//  \ \_____\\ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_____\  \ \_\ \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_/\/_/ \/_/\/_/ \/_/ /_/ \/_/\/_/ \/_____/   \/_/  \/_____/ \/_/ /_/ //
	//                                                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function ICharacterData(_config = {}) constructor {
		
		hp_capacity			   = _config[$ "hp_capacity"		   ] ?? 100;
		hp_start			   = _config[$ "hp_start"			   ] ?? hp_capacity;
		
		// to be sorted ...
		hp_per_level		   = _config[$ "hp_per_level"		   ] ?? 5;
		armor				   = _config[$ "armor"				   ] ?? 10;
		armor_per_level		   = _config[$ "armor_per_level"	   ] ?? 1;
		move_speed			   = _config[$ "move_speed"			   ] ?? 100; // scale down between 0 - 1
		move_speed_per_level   = _config[$ "move_speed_per_level"  ] ?? 0.5;
		damage				   = _config[$ "damage"				   ] ?? 15;
		damage_per_level	   = _config[$ "damage_per_level"	   ] ?? 1;
		damage_primary_boost   = _config[$ "damage_primary_boost"  ] ?? 0;
		attack_speed		   = _config[$ "attack_speed"		   ] ?? 100; // scale down between 0 - 1
		attack_speed_per_level = _config[$ "attack_speed_per_level"] ?? 1;
		energy_capacity		   = _config[$ "energy_capacity"	   ] ?? 100;
		energy_scalar		   = _config[$ "energy_scalar"		   ] ?? 1.0;
		
	};
