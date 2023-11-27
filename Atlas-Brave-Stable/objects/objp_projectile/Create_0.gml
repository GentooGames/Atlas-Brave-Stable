
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______      __   ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \    /\ \ /\  ___\ /\  ___\ /\__  _\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \  _\_\ \\ \  __\ \ \ \____\/_/\ \/\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\/\_____\\ \_____\\ \_____\  \ \_\ \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/\/_____/ \/_____/ \/_____/   \/_/  \/_/ \/_____/ \/_____/ //
	//                                                                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objp_projectile.create //
	event_inherited();
	var _self = self;
	
	// public
	get_x			= function() {
		return x;
	};
	get_y			= function(_apply_z = true) {
		if (_apply_z) {
			return y - __.z;	
		}
		return y;
	};
	get_z			= function() {
		return __.z;
	};
	set_x			= function(_x) {
		x = _x;
		return self;
	};
	set_y			= function(_y) {
		y = _y;
		return self;
	};
	set_z			= function(_z) {
		__.z = _z;
		return self;
	};
	duration_get	= function() {
		return __.duration;
	};
	duration_set	= function(_duration) {
		__.duration = _duration;
		return self;
	};
	direction_get	= function() {
		return __.direction;
	};
	direction_set	= function(_dir) {
		__.direction = _dir;
		return self;
	};
	speed_get		= function() {
		return __.speed;
	};
	speed_set		= function(_speed) {
		__.speed = _speed;
		return self;
	};
	angle_set		= function(_angle) {
		image_angle = _angle;
		return self;
	}
	
	// private
	with (__) {
		tween_init		=  method(_self, function() {
			if (__.tween != undefined) {
				__.tween =  new IB_TweenCurve(__.tween); // convert config to class
				__.tween.initialize();
				__.tween.start();
			};
		});
		tween_cleanup	=  method(_self, function() {
			if (__.tween != undefined) {
				__.tween.cleanup();
			}
		});
		duration_update	=  method(_self, function() {
			if (__.duration > 0) {
				__.duration--;	
			}
			else if (__.duration == 0) {
				__.duration = -1;
				destroy();
			};
		});
		distance_update	=  method(_self, function() {
			if (__.distance > 0) {
				var _dist_moved = point_distance(xstart,ystart,x,y);
				
				if _dist_moved >= __.distance {	
					destroy();
				};
			};
		});
		position_update	=  method(_self, function() {
			if (__.speed > 0)			__.move_by_speed();
			if (__.tween != undefined)	__.move_by_tween();
		});
		anim_update		=  method(_self, function() {
			if image_index >= image_number-1 {
				if (__.anim_end_pause)		image_speed = 0;	
				if (__.anim_end_destroy)	destroy();	
			}
		});
		move_by_speed	=  method(_self, function() {
			
			var _speed = speed_get();
			var _dir   = direction_get();
		
			var _xspeed = lengthdir_x(_speed,_dir);
			var _yspeed	= lengthdir_y(_speed,_dir);
		
			x += _xspeed;
			y += _yspeed;
		});
		move_by_tween	=  method(_self, function() {
			
			var _tween = __.tween;
			_tween.update();
			
			if (_tween.is_running()) {
				var _value = _tween.get_value_curve();
				x = xstart + lengthdir_x(_value, direction_get());
				y = ystart + lengthdir_y(_value, direction_get());
			}
			
		});
		hitbox_create	=  method(_self, function() {
			
			if (__.hitbox = undefined) exit
			
			var _sprite_name = sprite_get_name(__.sprite_index);
			var _hitbox_name = string_replace(_sprite_name,"_proj","_hitbox");
			var _sprite_index = asset_get_index(_hitbox_name);
			
			print("CREATING HITBOX " +_hitbox_name);
			
			__.hitbox[$ "x"			  ] ??= get_x(); // add attack range and offset
			__.hitbox[$ "y"			  ] ??= get_y(); // add attack range and offset
			__.hitbox[$ "sprite_index"] ??= _sprite_index;

			__.hitbox = create_hitbox(__.hitbox.x, __.hitbox.y, self, __.hitbox );
			__.hitbox.angle_set(direction_get());
			
		});
			
		sprite_index		= _self[$ "sprite_index"	] ?? undefined;
		direction			= _self[$ "direction"		] ?? 0;
		speed				= _self[$ "speed"			] ?? 0;
		tween				= _self[$ "tween"			] ?? undefined;	
		distance			= _self[$ "distance"		] ?? -1;
		duration			= _self[$ "duration"		] ?? -1;
		
		anim_end_pause		= _self[$ "anim_end_pause"	] ?? false;
		anim_end_destroy	= _self[$ "anim_end_destroy"] ?? false;
		destroy_on_end		= _self[$ "destroy_on_end"	] ?? true;
		on_destroy			= _self[$ "on_destroy"		] ?? undefined;
		move_script			= _self[$ "move_script"		] ?? undefined;
		
		hitbox				= _self[$ "hitbox"			] ?? undefined;
		
		z					= _self[$ "z"] ??  0;
		z_curve				=  new IB_TweenCurve({
			auto_destroy:   false, // DO NOT CHANGE!
			curve_index:   _self[$ "z_curve_index"   ] ??  crv_curves,
			curve_channel: _self[$ "z_curve_channel" ] ?? "linear",
			value_end:     _self[$ "z_curve_distance"] ??  0,
			duration:	   _self[$ "z_curve_duration"] ??  0,
		});
		z_curve.on_stop(method(_self, function() {
			__.z_curve.deactivate();
		}));
	};
	
	// events
	on_initialize(function() {
		__.tween_init();
		__.hitbox_create();
		__.z_curve.initialize();
		if (__.z_curve.get_value_end() > 0) {
			__.z_curve.start();	
		}
	});
	on_update	 (function() {
		__.z_curve.update();
		__.position_update();
		__.distance_update();
		__.duration_update();
		__.anim_update()
	});
	on_render	 (function() {
		draw_self();
	});
	on_cleanup	 (function() {
		__.z_curve.cleanup();
		__.tween_cleanup();
		__.hitbox.destroy();
	});
	