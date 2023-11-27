
//  _____           _           _   _ _      
// |  __ \         (_)         | | (_| |     
// | |__) _ __ ___  _  ___  ___| |_ _| | ___ 
// |  ___| '__/ _ \| |/ _ \/ __| __| | |/ _ \
// | |   | | | (_) | |  __| (__| |_| | |  __/
// |_|   |_|  \___/| |\___|\___|\__|_|_|\___|
//                _/ |                       
//               |__/                        
/*
function iProjectile(_config = {}) constructor {
	
	//state =				PHASE.START;
	owner =				_config[$ "owner"]				?? other.id;
	
	tween =				_config[$ "tween"]				?? noone;	// ref to iTween
	anchor =			_config[$ "anchor"]				?? owner;	
	
	offset =			_config[$ "offset"]				?? 0;
	input_angle =		_config[$ "input_angle"]		?? 0;		// grabbed from phase.input_angle if not passed in
	sprite_index =		_config[$ "sprite_index"]		?? noone;	// constructed from ability.sprite_prefix if not passed in

	distance =			_config[$ "distance"]			?? noone;
	duration =			_config[$ "duration"]			?? noone;
	//speed =				_config[$ "speed"]				?? 0;

	move_script =		_config[$ "move_script"]		?? function() {};
	callback =			_config[$ "callback"]			?? function() {};
	
	on_end =			_config[$ "on_end"]				?? function() {instance_destroy()};
	
	x_start =	owner.x;
	y_start =	owner.y;
	
	x_speed =	0;
	y_speed =	0;
	
	timer =		0;

	#region FUNCTIONS
	
	static init =			function() {
		state = PHASE.UPDATE;
	}
	init();
	
	#endregion
}