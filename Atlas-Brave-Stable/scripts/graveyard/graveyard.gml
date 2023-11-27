/* :)

	hitbox_create	  = function(_name, _type, _dir = 0, _range_offset = 0, _config = {}) {
		var _x		= position_get_x();
		var _y		= position_get_y();
			
		var _hitbox = hitbox_create_ext(_name, _type, _x, _y, _dir, _range_offset, _config);
		return _hitbox;
	};
	hitbox_create_ext = function(_name, _type, _x = position_get_x(), _y = position_get_y(), _dir = 0, _range_offset = 0, _config = {}) {
			
		var _len = stat_get("attack_range") + _range_offset;
			
		_x += lengthdir_x(_len, _dir);
		_y += lengthdir_y(_len, _dir);
			
		var _hitbox = create_hitbox(_type, self, _x, _y, _dir, _config);
		__.hitbox.instances.set(_name, _hitbox);
			
		var _hitbox = instance_create_depth(_x, _y, 0, obj_hitbox, _config);
			
		// queue hitbox to remove itself on cleanup
		_hitbox.on_cleanup(function(_name) {
			hitbox_destroy(_name);
		}, _name);
			
		__.IB.log("hitbox createed: " + _name, IB_LOG_FLAG.CHARACTER);
		return _hitbox;
	};