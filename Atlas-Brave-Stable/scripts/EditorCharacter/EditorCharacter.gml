
	function EditorCharacter(_config = {}) constructor {
		name				= _config[$ "name"				] ?? "";
		sprite_list		= [];
		sprite_current	= 0;
		
		static add_sprite		= function(_sprite) {
			array_push(sprite_list, _sprite);
		};
		
		static update			= function() {
			sprite_list[sprite_current].update();
		}
		static render			= function() {
			draw_sprite_ext(	sprite_list[sprite_current].get_sprite(), 
								sprite_list[sprite_current].get_frame_current(), 
								room_width/2, 
								room_height/2, 
								1, 
								1, 
								0, 
								c_white, 
								1);
		}
	}