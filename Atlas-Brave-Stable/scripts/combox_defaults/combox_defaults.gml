
	function IComboxCollisionObjectConfig(_config = {}) constructor {
		index			 = _config[$ "index"		   ] ?? undefined;
		filter			 = _config[$ "filter"		   ] ?? undefined;
		on_start		 = _config[$ "on_start"		   ] ?? function(_combox, _collision_instance) {};
		on_stop			 = _config[$ "on_stop"		   ] ?? function(_combox, _collision_instance) {};
		ordered			 = _config[$ "ordered"		   ] ?? false;
		repetitions_per  = _config[$ "repetitions_per" ] ?? 1;
		repetitions_max  = _config[$ "repetitions_max" ] ?? 1;
		repetitions_rate = _config[$ "repetitions_rate"] ?? 1;
	};
	
	// collision object configs
	function combox_collision_object_default() {
		return new IComboxCollisionObjectConfig({
			index:	  obj_hurtbox,
			filter:   combox_collision_filter_ignore_self(),
			on_start: function(_hitbox, _hurtbox) {
				_hurtbox.apply_hitbox(_hitbox);
				_hitbox.get_owner().audio_play(sfx_impact_blade_1);
			},
		});
	};
	
	// filter configs
	function combox_collision_filter_ignore_self() {
		return {
			name:	  "ignore_self",
			condition: function(_hitbox, _hurtbox) {
				var _hitbox_owner  = _hitbox.get_owner().id;
				var _hurtbox_owner = _hurtbox.get_owner().id;
				return _hitbox_owner == _hurtbox_owner;
			},
		};
	};
