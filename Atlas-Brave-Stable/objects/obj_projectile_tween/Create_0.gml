
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______      __   ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \    /\ \ /\  ___\ /\  ___\ /\__  _\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \  _\_\ \\ \  __\ \ \ \____\/_/\ \/\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\/\_____\\ \_____\\ \_____\  \ \_\ \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/\/_____/ \/_____/ \/_____/   \/_/  \/_/ \/_____/ \/_____/ //
	//                                                                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_projectile_tween.create //
	event_inherited();
	var _self = self;
	
	// private
	__[$ "tween"] ??= {};
	with (__.tween) {
		destroy_on_end = _self[$ "destroy_on_end"] ?? false;
		curve		   =  new IB_TweenCurve({
			auto_destroy:   false, // DO NOT CHANGE!
			curve_index:   _self[$ "curve_index"   ] ??  crv_curves,
			curve_channel: _self[$ "curve_channel" ] ?? "linear",
			value_end:     _self[$ "curve_distance"] ??  100,
			duration:	   _self[$ "curve_duration"] ??  SECOND,
		});
		curve.on_stop(method(_self, function() {
			__.tween.curve.deactivate();
			if (__.tween.destroy_on_end) {
				destroy();	
			}
		}));
	};
	
	// events
	on_initialize(function() {
		__.tween.curve.initialize();
		__.tween.curve.start();
	});
	on_update	 (function() {
		__.tween.curve.update();
		if (__.tween.curve.is_running()) {
			var _value = __.tween.curve.get_value_curve();
			x = xstart + lengthdir_x(_value, __.move_dir);
			y = ystart + lengthdir_y(_value, __.move_dir);
		}
	});
	on_render	 (function() {
		draw_self();
	});
	on_cleanup	 (function() {
		__.tween.curve.cleanup();
	});
	