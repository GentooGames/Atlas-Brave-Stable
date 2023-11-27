
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______  __  __   ______  //
	// /\__  _\/\  ___\/\_\_\_\ /\__  _\ //
	// \/_/\ \/\ \  __\\/_/\_\/_\/_/\ \/ //
	//    \ \_\ \ \_____\/\_\/\_\  \ \_\ //
	//     \/_/  \/_____/\/_/\/_/   \/_/ //
    //									 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_text_floating.create //
	event_inherited();
	var _self = self;
	var _data = self[$ "data"] ?? self;
	
	// private
	with (__) {
		life_update  = method(_self, function() {
			__.life--;
			if (__.life <= 0) destroy();	
		});
		alpha_update = method(_self, function() {
			alpha_set(__.life / __.life_start);	
		});
		
		font	   = _data[$ "font"] ?? fnt_clark_16;
		text	   = _data[$ "text"] ?? "";
		life	   = _data[$ "life"] ?? SECOND;
		life_start =  life;
	};
	
	// events
	on_update(function() {
		__.alpha_update();
		__.life_update();
	});
	on_render(function() {
		var _alpha = alpha_get();
		if (_alpha > 0) {
			var _color = color_get();
			draw_set_font(__.font);
			draw_text_transformed_color(
				position_get_x(),
				position_get_y(),
				__.text,
				scale_get_x(true, false),
				scale_get_y(true),
				angle_get(),
				_color,
				_color,
				_color,
				_color,
				_alpha,
			);
			objc_game.font_reset();
		}
	});
	