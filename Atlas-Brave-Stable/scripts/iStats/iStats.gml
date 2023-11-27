
//   _____ _        _       
//  / ____| |      | |      
// | (___ | |_ __ _| |_ ___ 
//  \___ \| __/ _` | __/ __|
//  ____) | || (_| | |_\__ \
// |_____/ \__\__,_|\__|___/

function iStats() constructor {
	
	var _config = {};
	
	with other { switch (object_index) {
		case obj_hero:  _config = HERO_DATA [$ get_uid()];
		case obj_enemy: _config = ENEMY_DATA[$ get_uid()];
	}};
	
	level =				_config[$ "level"] ??		1;
	xp =				_config[$ "xp"] ??			0; // total experience gained for players - see below for enemy xp
	
	#region CORE STATS
	
		health =				_config[$ "health"]					?? 100;	 
		damage =  				_config[$ "damage"]					?? 10;		// total raw damage before ability scaling
		armor =					_config[$ "armor"]					?? 0;		// functions as shield that absorbs x amount of damage and is fully restored at the end of combat
		move_speed =			_config[$ "move_speed"]				?? 100;		// effects move speed - divided by 100 to be used as a scalar
		attack_speed =			_config[$ "attack_speed"]			?? 100;		// effects animation speed - divided by 100 to be used as a scalar
																
		cooldown =				_config[$ "cooldown"]				?? 0;		// cooldown reduction - converted to a percent
		crit = 					_config[$ "crit"]					?? 5;		// crit chance - converted to a percent						
		
		health_per_lv =			_config[$ "health_per_lv"]			?? 100;
		damage_per_lv =  		_config[$ "damage_per_lv"]			?? 10;
		armor_per_lv =			_config[$ "armor_per_lv"]			?? 10;
		move_speed_per_lv =		_config[$ "move_speed_per_lv"]		?? 100;
		attack_speed_per_lv =	_config[$ "attack_speed_per_lv"]	?? 100;
		
		//anim_speed = 			_config[$ "anim_speed"]				?? .25;
		input_limit = 			_config[$ "input_limit"]			?? 60;
	
		energy =				0; // current amount of available energy
	
		max_health =			health;
		max_armor =				armor;
		max_energy =			100;
	
	#endregion
	
	#region UNIQUE STATS
	
		// base crit damage is 1.5x
		// crit damage will only ever be additive, but get's applied to total damage as a scalar
		crit_damage = 			_config[$ "crit_damage"] ??			0;		// increases the damage of critical hits - converted to a percent and added to the base crit damage
	
		// this is different than a damage scalar as this doesn't actually increase the damage stat directly
		// this gets factored into the final damage output as a scalar, increasing damage by x%
		damage_increase = 		_config[$ "damage_increase"] ??		0;	// converted to a percent
	
		// this gets factored into the final damage output as a scalar, reducing incoming damage by x%
		damage_reduction =		_config[$ "damage_reduction"] ??	0;	// converted to a percent
	
		// increases the duration of your hit stuns by x%
		hit_stun_duration =		_config[$ "hit_stun_duration"] ??	0;	// converted to a percent
	
		// reduces the duration of incoming hit stuns by x%
		hit_stun_resist =		_config[$ "hit_stun_resist"] ??		0;	// converted to a percent
	
		// reduces the effectiveness of slows applied to a character by x%
		slow_resist =			_config[$ "slow_resist"] ??			0;	// converted to a percent
	
	#endregion	
	
	#region PLAYER SPECIFIC
	
		// increases the amount of energy gained from abilities by x%
		energy_gain =			_config[$ "energy_gain"] ??		0;	// converted to a percent
	
		// this will only ever be additive 
		max_cooldown =			_config[$ "max_cooldown"] ??	40;	// converted to a percent
		
		// used for enemy AI, this will increase the likelihood for enemies to target a player
		enmity =				_config[$ "enmity"] ??			0;	// converted to a percent
		
		// I was using this hold the total exp gained for each player during combat, which only gets applied at the end of combat
		temp_exp =			0;
		
	#endregion
	
	#region ENEMY SPECIFIC
		
		// for enemies, this is the amount of xp a player gets for defeating the enemy
		// this is also an important variable used in the spawning algorithim
		xp =					_config[$ "xp"] ??				0;
		
		// tier is a variable used in the spawning algorithim
		// see ENEMY_TIER enum in GLOBAL
		tier =					_config[$ "tier"] ??			0;
		
		// type is a more nuanced version of tier, mostly used to understand the enemies design intent
		// see ENEMY_TYPE enum in GLOBAL
		type =					_config[$ "type"] ??			0;
		
		// subtype is broad category which helps sort enemies for design purposes
		// see ENEMY_SUBTYPE enum in GLOBAL
		subtype =				_config[$ "subtype"] ??			0;
		
		// gold determines how much gold an enemy drops on death
		gold =					_config[$ "gold"] ??			0;
		
		// used in AI to decide whether an enemy should approach/attack
		aggression =			_config[$ "aggression"] ??		0;
		
	#endregion
	
}