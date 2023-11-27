
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   __   ______  ______   ______   __  __    //
	// /\ \_\ \ /\ \ /\__  _\/\  == \ /\  __ \ /\_\_\_\   //
	// \ \  __ \\ \ \\/_/\ \/\ \  __< \ \ \/\ \\/_/\_\/_  //
	//  \ \_\ \_\\ \_\  \ \_\ \ \_____\\ \_____\ /\_\/\_\ //
	//   \/_/\/_/ \/_/   \/_/  \/_____/ \/_____/ \/_/\/_/ //
    //													  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_hitbox.create //
	event_inherited();
	var _self = self;
	
	// public
	damage_get_amount	= function() {
		return __.damage;	
	};
	knockback_get_tween = function() {
		return __.knockback;
	};
	
	// private
	with (__) {
		damage	  = _self[$ "damage"   ] ?? 0;
		knockback = _self[$ "knockback"] ?? undefined;
	};
	