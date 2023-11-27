
//   _____                           
//  / ____|                          
// | (___  _ __ ___   ___  __ _ _ __ 
//  \___ \| '_ ` _ \ / _ \/ _` | '__|
//  ____) | | | | | |  __| (_| | |   
// |_____/|_| |_| |_|\___|\__,_|_|   
/*                              
function iSmear(_config = {}) constructor {
	
	//state =				PHASE.START;
	owner =				_config[$ "owner"]				?? other.id;
	
	ability =			_config[$ "ability"]			?? noone;	// ref to iAbility
	hitbox =			_config[$ "hitbox"]				?? noone;	// ref to iHitbox
	anchor =			_config[$ "anchor"]				?? owner;	
	
	offset =			_config[$ "offset"]				?? noone;
	input_angle =		_config[$ "input_angle"]		?? noone;
	sprite_index =		_config[$ "sprite_index"]		?? noone;	// constructed from ability.sprite_prefix if not passed in
	image_speed =		_config[$ "image_speed"]		?? 1;		// uses frame control unless image_speed is passed in
	
	duration =			_config[$ "duration"]			?? noone;
	
	callback =			_config[$ "callback"]			?? function() {};	
	
	#region FRAME CONTROL
	
	total_steps =		_config[$ "total_steps"]		?? 9;
	step_count =		_config[$ "step_count"]			?? 0;
	cur_frame =			_config[$ "cur_frame"]			?? 0;
	
	frame_array =		_config[$ "frame_array"]		?? [2, 4, 2, 1];
	color_array =		_config[$ "color_array"]		?? [ col_smear_orange, col_smear_yellow, col_smear_yellow, col_smear_white   ];
	
	#endregion
	
	#region FUNCTIONS
	
	static init =			function() {
		state = PHASE.UPDATE;
		
		if ability != noone {
			if sprite_index == noone {		// construct sprite
				sprite_index = smear_set_sprite(ability);
			}
		}
		if hitbox != noone {
			if input_angle == noone {		// get input angle from hitbox
				input_angle = hitbox.input_angle;
			}
			
			if offset == noone {			// get offset from hitbox
				offset = hitbox.offset;		
			}
		}
	}
	init();
	
	#endregion
}