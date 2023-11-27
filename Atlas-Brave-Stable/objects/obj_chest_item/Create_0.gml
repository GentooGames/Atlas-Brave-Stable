
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______   ______  //
	// /\  ___\ /\ \_\ \ /\  ___\ /\  ___\ /\__  _\ //
	// \ \ \____\ \  __ \\ \  __\ \ \___  \\/_/\ \/ //
	//  \ \_____\\ \_\ \_\\ \_____\\/\_____\  \ \_\ //
	//   \/_____/ \/_/\/_/ \/_____/ \/_____/   \/_/ //
	//                                              //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_chest_item.create //
	event_inherited();
	var _self = self;
	
	// public
	open	 = function() {
		sprite_index = spr_chest_item_open;
		image_index  = 0;
		image_speed  = 1;
		__.state	 = "opening";
		audio_play_sound_on(__.audio_emitter, sfx_env_chestopen, false, 0);
		return self;
	};
	close	 = function(_refill = true) {
		sprite_index = spr_chest_item_close;
		image_index  = 0;
		image_speed  = 0;
		__.state	 = "closed";
		if (_refill) __.spawned = false;
		return self;
	};
	can_open = function() {
		return !is_open();
	};
	is_open  = function() {
		return (__.state != "closed");
	};
	
	// private
	with (__) {
		spawn_items   =  method(_self, function(_n_items = 3) {
			
			static _max_speed = 1.5;
			
			for (var _i = 0; _i < _n_items; _i++) {
				var _hspeed  = iceberg.math.remap(0, _n_items - 1, -_max_speed, _max_speed, _i);
				var _yoffset = iceberg.math.remap(0, _n_items - 1, -_n_items,   _n_items,   _i);
				item_create("Potion", x - 2, bbox_bottom + _yoffset, {
					hspeed: _hspeed,
				});
			};	
			
		});
		state		  = "closed";
		spawned		  =  false;
		audio_emitter =  audio_emitter_create();
	//	hurtbox		  =  create_hurtbox(_self.x, _self.y, _self, {
	//		sprite_index: spr_chest_item_mask,
	//	}, false);
	};
	
	// events
	on_initialize(function() {
		mask_index   = spr_chest_item_mask;
		sprite_index = spr_chest_item_close;
		image_speed  = 0;
	//	__.hurtbox.initialize();
	});
	on_update	 (function() {
		depth = -bbox_bottom;
		audio_emitter_position(__.audio_emitter, x, y, 0);
		
		switch (__.state) {
			case "opening":
				// open animation finished
				if (image_index >= image_number - 1) {
					image_index  = image_number - 1;
					image_speed  = 0;
					__.state	 = "opened";
				}
				
				// spawn items keyframe
				if (!__.spawned && image_index == 4) {
					 __.spawn_items();
					 __.spawned = true;
				}
				break;
		};
	});
	on_cleanup	 (function() {
		audio_emitter_free(__.audio_emitter);
	//	__.hurtbox.cleanup();
	});
	
	////////////////////////
	
	initialize();
	