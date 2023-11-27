
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __   __   __  __   __    __    //
	// /\  ___\ /\ "-.\ \ /\ \/\ \ /\ "-./  \   //
	// \ \  __\ \ \ \-.  \\ \ \_\ \\ \ \-./\ \  //
	//  \ \_____\\ \_\\"\_\\ \_____\\ \_\ \ \_\ //
	//   \/_____/ \/_/ \/_/ \/_____/ \/_/  \/_/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	enum ABILITY {
		BASIC,
		DEFENSE,
		PRIMARY,
		SECONDARY,
	};

	enum TWEEN_TYPE {
		NONE,
		MOVE,
	}

	enum TARGET_TYPE {
		ALLY,
		ENEMY,
		OBJ,
		ALL
	}
	
	enum DAMAGE_TYPE {
		BASIC,
		FIRE,
		ICE,
		LIGHTNING
	}
	
	enum RANGE_TYPE {
		MELEE,
		RANGED,
		NONE
	}
	
	enum HITBOX_TYPE {
		BASIC,
		TRAP,
		AURA
	}

	enum HIT_DIR {
		NONE,
		PUSH,
		PULL,
		RADIAL,
		POINT
	}

	enum HIT_TEXT {
		BASIC,
		SPECIAL,
		NONE
	}

	enum HIT_AREA {
		ALL,
		UPPER,
		LOWER
	}
	
	enum ARMOR {
		NONE,
		SUPER,
		ULTRA
	}

	// ENEMY
	//enum DIFFICULTY {
	//	NORMAL,
	//	HARD,
	//	VERY_HARD,
	//	BRAVE
	//}

	enum ENEMY_TIER {
		MELEE,
		RANGED,
		TANK,
		ELITE_MELEE,
		ELITE_RANGED,
		BOSS
	}

	enum ENEMY_TYPE {
		NONE,
		FODDER,
		MELEE,
		RANGED,
		MAGE,
		TANK,
		SPAWNER,
		TURRET,
		ASSASSIN
	}

	enum ENEMY_SUBTYPE {
		NONE,
		BASIC,
		ELITE,
		BOSS
	}

	enum REGION {
		TUVALE_FOREST,
		TUVALE_RUINS,
		KUFTAL_TUNNEL,
		KUFTAL_CATACOMBS,
		ELDERMYST_GROVE,
		ELDERMYST_SANCTUARY,
		MOONCREST_GARDEN,
		MOONCREST_CITADEL
	}
	
	enum ROOM_TYPE {
		BASIC,
		ELITE,
		BOSS,
		SHOP,
		BLACKSMITH,
		SHRINE,
		CHEST,
		HORDE
	}
	
	enum SPAWN_TYPE {
		NONE,
		BASIC,
		ELITE,
		BOSS,
		HORDE
	}

	enum REWARD_TYPE {
		CHEST,
		OFFER,
		GOLD,
		NONE
	}

	enum EXIT_DIR {
		RIGHT,
		LEFT,
		UP,
		DOWN
	}

	enum CHEST_TYPE {
		BASIC,
		GOLD,
		ELITE,
		BOSS
	}

	enum CHARACTER_TYPE {
		HERO,
		ENEMY,
		BOSS,
	};

	enum TEAM {
		FRIENDLY = 0,
		ENEMY = 1,
		
		FIRST = 0,
		LAST = 1,
	};


	
	