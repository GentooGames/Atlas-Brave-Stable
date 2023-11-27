
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   __  __   ______  ______  ______   ______   __  __    //
	// /\ \_\ \ /\ \/\ \ /\  == \/\__  _\/\  == \ /\  __ \ /\_\_\_\   //
	// \ \  __ \\ \ \_\ \\ \  __<\/_/\ \/\ \  __< \ \ \/\ \\/_/\_\/_  //
	//  \ \_\ \_\\ \_____\\ \_\ \_\ \ \_\ \ \_____\\ \_____\ /\_\/\_\ //
	//   \/_/\/_/ \/_____/ \/_/ /_/  \/_/  \/_____/ \/_____/ \/_/\/_/ //
	//                                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_hurtbox.create //
	event_inherited();
	var _self = self;
	
	if (MEDIA_MODE) visible = false;
	
	stick_owner_set_offset_y(0);
	
	////////////////////
	
	// public
	apply_hitbox = function(_hitbox) {
		
		if (is_active()) {
			var _hurtbox_owner =  get_owner();
			var _hitbox_owner  = _hitbox.get_owner();
			
			// deal damage
			var _damage_amount = _hitbox.damage_get_amount();
			if (_damage_amount > 0) {
				_hurtbox_owner.damage(_hitbox.damage_get_amount(), _hitbox);
			}
			
			// apply knockback
			var _knockback_tween = _hitbox.knockback_get_tween();
			if (_knockback_tween !=  undefined) {
				_hurtbox_owner.tween_create("__knockback", _knockback_tween);
			}
		}
	};
	