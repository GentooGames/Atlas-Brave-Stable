
//   _____            _ _       
//  / ____|          (_| |      
// | (___  _ __  _ __ _| |_ ___ 
//  \___ \| '_ \| '__| | __/ _ \
//  ____) | |_) | |  | | ||  __/
// |_____/| .__/|_|  |_|\__\___|
//        | |                   
//        |_|          
/*
function iSprite(_config={}) constructor {
	
	anim =			_config[$ "anim"]			?? other.anim; // not sure if this works
	name =			_config[$ "name"]			?? "Idle";
	full_name =		_config[$ "full_name"]		?? "spr_Abel_Idle";
	index =			_config[$ "index"]			?? 0;
	
	frame_list =	[];
	
	frame =			0;	// decimal value
	frame_index =	0;	// rounded whole number
	frame_total =	0;
	frame_speed =	0;
	
	#region FUNCTIONS
	
	static init =				function(_data=false) {
		
		index =			asset_get_index(full_name);
		frame_total =	sprite_get_number(index);
		
		if index != -1 {
			set_frame_list(_data);
			set_frame_speed();
		}
	}
		
	static start =				function() {
		frame =			0;
		frame_index =	0;
		hit_frame =		0;
		set_frame_speed();
	}
	
	static update =				function() {
		
		frame += frame_speed;
		if (floor(frame) > frame_index) set_next_frame();
	}
	
	static cleanup =			function() {	
		if anim.ended	start();
	}

	static set_next_frame =		function() {
		
		frame_index = floor(frame);
		hit_frame =	frame_index;
		
		if frame_index == frame_total
			anim.ended = true
		else
			set_frame_speed();
	}
	
	static set_frame_speed =	function() {
		
		var _step_count = frame_list[frame_index].step_count;
		frame_speed = 1 / _step_count;
		
		//print("FRAME SPEED " +string(frame_speed));
	}
	
	static set_frame_list =		function(_data) {
	
		if _data != false {
			for (var i = 0; i < frame_total; ++i) {		// LOAD 
			   frame_list[i] = _data[i];
			}
		} else {
			for (var i = 0; i < frame_total; ++i) {		// DEFAULT
			   frame_list[i] = {step_count: 4};
			}
		}
	}
	
	#endregion
}