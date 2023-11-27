
//                 _                 _   _             
//     /\         (_)               | | (_)            
//    /  \   _ __  _ _ __ ___   __ _| |_ _  ___  _ __  
//   / /\ \ | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \ 
//  / ____ \| | | | | | | | | | (_| | |_| | (_) | | | |
// /_/    \_|_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|
/*
function iAnimation(_config = {}) constructor {
	
	owner =			_config[$ "owner"]			?? other.id;
	sprite =		noone;
	
	ended =			false;
	pause =			false;
	
	// this gets filled with iSprite structs in obj_character : create
	// Abel_Attack_1 =	new iSprite()
	
	#region FUNCTIONS
	
	static init =				function() {
		
	}
	
	static update =				function() {
		if pause exit;
		sprite.update();
	}
	
	static cleanup =			function() {
		sprite.cleanup();
		ended = false;
	}
	
	static set_sprite =			function(_string) {
		
		if sprite != self[$_string] { // set new sprite only if differnt from current	
			sprite = self[$_string]; 
			sprite.start();
		}
	}
	
	static add_sprite =			function(_sprite) {
		self[$_sprite.name] = _sprite;
		if (sprite == noone) sprite = _sprite // default starting sprite
	}	
		
	static hit_frame =			function(_frame) {
		return sprite.frame + sprite.frame_speed >= _frame && sprite.frame <= _frame
	}
	
	static frame_greater_than =	function(_frame) {
		return (sprite.frame_index >= _frame);
	}
	
	static frame_less_than =	function(_frame) {
		return (sprite.frame_index <= _frame);
	}
	
	static frame_in_window =	function(_window=[]) {
		if size(_window) == 0 return false
	
		var _min = _window[0];
		var _max = _window[1];
	
		if (_min == _max) return _min == sprite.hit_frame

		if frame_greater_than(_min) && frame_less_than(_max) {
			return true
		}
	
		return false
	}

	init();
	
	#endregion
	
}