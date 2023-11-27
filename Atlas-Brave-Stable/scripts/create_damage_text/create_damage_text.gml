
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______  __  __   ______  //
	// /\__  _\/\  ___\/\_\_\_\ /\__  _\ //
	// \/_/\ \/\ \  __\\/_/\_\/_\/_/\ \/ //
	//    \ \_\ \ \_____\/\_\/\_\  \ \_\ //
	//     \/_/  \/_____/\/_/\/_/   \/_/ //
    //									 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function create_damage_text(_text) {
		var _x = x;
		var _y = y - sprite_height;
		return instance_create_depth(_x, _y, 0, obj_text_floating, {
			text:			string(_text),
			scale:			0.5,
			y:			   _y,
			y_lerp_target: _y - 6,
			y_lerp_speed:	0.01,
		}).initialize();
	};
	