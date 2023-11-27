
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
	
	#region tween
	
	   	tween_create		= function(_tween_name, _config = {}, _start = true) {
			
			if (_config.distance != undefined)	_config.value_end = _config.distance;
			
			_config[$ "var_name"	]	??=	"move_adjust_position_by_value";
			_config[$ "var_owner"	]	??=	self;
			
			var _tween = __.tween.controller.create_tween(_tween_name, _config, _start);
			if (_start) _tween.start();
			
			return _tween;
		};
		
		// private
		__[$ "tween"] ??= {};
		with (__.tween) {
			
		}
			
	#endregion
	
	// events
	
	//on_render	 (function() {
	//	draw_self();
	//});
