
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __   __    //
	// /\  ___\ /\  __ \ /\ \ /\ "-.\ \   //
	// \ \ \____\ \ \/\ \\ \ \\ \ \-.  \  //
	//  \ \_____\\ \_____\\ \_\\ \_\\"\_\ //
	//   \/_____/ \/_____/ \/_/ \/_/ \/_/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_coin.create //
	event_inherited();
	var _self = self;
	
	// public
	get_x		= function() {
		return x;
	};
	get_y		= function(_apply_z = true) {
		if (_apply_z) {
			return y - __.z;
		}
		return y;
	};
	get_z		= function() {
		return __.z;	
	};
	is_grounded = function() {
		return __.grounded;	
	};
	
	// private
	with (__) {
		update_curves	= method(_self, function() {
			__.rise_curve.update();
			__.fall_curve.update();
		
			if (__.rise_curve.is_running()) {
				__.z = __.rise_curve.get_value_curve();
			}
			else if (__.fall_curve.is_running()) {
				__.z = __.fall_curve.get_value_curve();
			}
		});
		update_life		= method(_self, function() {
			__.life--;
			if (__.life < 0) {
				destroy();	
			}
		});
		update_blink	= method(_self, function() {
			if (__.life <= __.blink_threshold
			&&	iceberg.time.do_every_frame(__.blink_rate + __.blink_offset)
			) {
				__.blink_visible = !__.blink_visible;	
			}
		});
		render_shadow	= method(_self, function() {
			if (__.life <= __.blink_threshold) {
				var _alpha = iceberg.math.remap(0, __.blink_threshold, 0, 1, __.life);
			}
			else {
				var _alpha = 1;	
			}
			draw_shadow_ellipse(6, 4, x, bbox_bottom, -__.z, c_black, _alpha);
		});
		
		z				= _self[$ "z"				] ?? 0.0;
		life			= _self[$ "life"			] ?? SECOND * 5;
		blink_threshold = _self[$ "blink_threshold"	] ?? SECOND * 2;
		blink_rate		= _self[$ "blink_rate"		] ?? 8;
		blink_offset	= _self[$ "blink_offset"	] ?? 0;
		blink_visible	=  true;
		grounded		=  true; // set to false on rise_curve.start()
		rise_curve		=  new IB_TweenCurve({
			curve_index:    crv_coin,
			curve_channel: "rise",
			auto_destroy:   false,
			value_end:     _self[$ "rise_height"] ?? 20,
			duration:	   _self[$ "rise_time"  ] ?? 10,
		});
		fall_curve		=  new IB_TweenCurve({
			curve_index:    crv_coin,
			curve_channel: "fall",
			auto_destroy:   false,
			value_end:     _self[$ "rise_height"] ?? 20,
			duration:	   _self[$ "fall_time"  ] ?? 40,
		});
		
		rise_curve.on_stop(method(_self, function() {
			__.fall_curve.start();
			__.rise_curve.deactivate();
		}));
		fall_curve.on_stop(method(_self, function() {
			__.grounded = true;
			__.fall_curve.deactivate();
		}));
	};
	
	// events
	on_initialize(function() {
		
		__.rise_curve.initialize();
		__.fall_curve.initialize();
		
		if (__.rise_curve.get_value_end() > 0) {
			__.grounded = false;
			__.rise_curve.start();
		}
		image_index = irandom(image_number - 1);
		
		if (!audio_is_playing(sfx_env_coins)) {
			 audio_play_sound(sfx_env_coins, 0, false);
		}
	});
	on_update	 (function() {
		depth = -bbox_bottom;
		__.update_curves();
		__.update_life();
		__.update_blink();
	});
	on_render	 (function() {
		__.render_shadow();
		if (__.blink_visible) {
			draw_sprite(sprite_index, image_index, x, get_y(true));
		}
	});
	on_cleanup	 (function() {
		__.rise_curve.cleanup();
		__.fall_curve.cleanup();
	});
	
	