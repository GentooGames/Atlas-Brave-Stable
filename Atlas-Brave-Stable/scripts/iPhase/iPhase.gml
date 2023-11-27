
//  _____  _                    
// |  __ \| |                   
// | |__) | |__   __ _ ___  ___ 
// |  ___/| '_ \ / _` / __|/ _ \
// | |    | | | | (_| \__ |  __/
// |_|    |_| |_|\__,_|___/\___|
/*
function iPhase(_config = {}) constructor {
	
	state =				PHASE.START;
	//anim				// ref to iAnimation
	
	sprite_index =		_config[$ "sprite_index"]		?? noone;	// Constructs index if not passed in
	
	input_angle =		_config[$ "input_angle"]		?? 0;		// The angle we end up using in the keyframe func
	input_limit =		_config[$ "input_limit"]		?? noone;	// How much to limit the range of the input angle		
	input_window =		_config[$ "input_window"]		?? [0,0];	// What frame(s) to get the input angle on, defaulted to frame 0	

	on_start =			_config[$ "on_start"]			?? function() {};
	on_update =			_config[$ "on_update"]			?? function() {};
	on_end =			_config[$ "on_end"]				?? function() {};
	
	duration =			0;
	
	
	#region FUNCTIONS
	
	static set_timer =			function() {
		if (tick_rate != noone) {
			timer = tick_rate * repetitions;
		}
	}
		
	#endregion
}

/*
	on_tick =			_config[$ "on_tick"]			?? noone;	// function() {};
	tick_rate =			_config[$ "tick_rate"]			?? noone;
	repetitions =		_config[$ "repetitions"]		?? noone;
	timer =				0;
	
	move_enable =		_config[$ "move_enable"]		?? false;
			
	on_start =			_config[$ "on_start"]			?? function() {};
	on_update =			_config[$ "on_update"]			?? function() {};
	on_end =			_config[$ "on_end"]				?? function() {};
	
	#region Charge
	chargeable =		_config[$ "chargeable"]			?? false;
	charge_min =		_config[$ "charge_min"]			?? 0;
	charge_max =		_config[$ "charge_max"]			?? 0;
	charge_frame =		_config[$ "charge_frame"]		?? 0;
	charge_offset =		_config[$ "charge_offset"]		?? [0,0];
	charge_timer =		_config[$ "charge_timer"]		?? 0;
	#endregion
	
	#region Keyframes
	keyframes =			_config[$ "keyframes"]			?? [];
		// frame
		// func
	#endregion
	
	#region Cancels
	cancels =			_config[$ "cancels"]			?? [];
		// type
		// input_window
		// exit_frame
	#endregion



