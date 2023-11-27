
//  _______                      
// |__   __|                     
//    | __      _____  ___ _ __  
//    | \ \ /\ / / _ \/ _ | '_ \ 
//    | |\ V  V |  __|  __| | | |
//    |_| \_/\_/ \___|\___|_| |_|
/*
function iTween(_config = {}) constructor {
	
	//state =				PHASE.START;
	owner =				_config[$ "owner"]				?? other.id;
	type =				_config[$ "type"]				?? TWEEN_TYPE.MOVE;
														
	duration =			_config[$ "duration"]			?? 0;
	delay =				_config[$ "delay"]				?? 0;
	easing =			_config[$ "easing"]				?? EASE.OUT_QUINT;
														
	tween_var =			_config[$ "tween_var"]			?? ["x_speed","y_speed"];	
	tween_start =		_config[$ "tween_start"]		?? [0,0];
	tween_end =			_config[$ "tween_end"]			?? [0,0];
														
	callback =			_config[$ "callback"]			?? function() {};				
	
	pause =				false;	// pause tween during owner hit_pause
	cancel =			false;	// cancel tween on collision or hit_stun
	timer =				0;	
	
	#region TWEEN_TYPE.MOVE
	
	distance =			_config[$ "distance"]		?? noone;
	
	input_angle =		_config[$ "input_angle"]	?? 0;
	
	#endregion
	
	#region FUNCTIONS
	
	static init =		function() {
		state = PHASE.START;
		
		if type == TWEEN_TYPE.MOVE {

			tween_start[0] = owner.x; // x
			tween_start[1] = owner.y; // y
			
			tween_end[0] = tween_start[0] + lengthdir_x(distance, input_angle); // x
			tween_end[1] = tween_start[1] + lengthdir_y(distance, input_angle); // y
			
		}
		
		objc_tween.add(self);
	}
	
	static update =		function() {
		
		if !instance_exists(owner) { on_end(); exit; }
		
		var _val_x = ease(easing, timer, tween_start[0], tween_end[0], duration, delay) - owner.x;
		var _val_y = ease(easing, timer, tween_start[1], tween_end[1], duration, delay) - owner.y;
		
		owner[$ tween_var[0] ] = _val_x; // set x_speed
		owner[$ tween_var[1] ] = _val_y; // set y_speed
		
		if (duration == timer || cancel) on_end(); 
		if (!delay && !pause) timer ++;
		if (delay) delay --;
	}
	
	static on_end =		function() {
		callback();
		objc_tween.remove(self);
	}
		
	init();
	#endregion
}