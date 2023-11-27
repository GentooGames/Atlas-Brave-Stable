
	function EditorSprite(_config = {}) constructor {
		name				= _config[$ "name"				] ?? "";			// the name of this animation
		sprite				= _config[$ "sprite"			] ?? undefined;		// what sprite is assigned to this animation

		animation_speed		= _config[$ "animation_speed"	] ?? 1;	// any global anim_speed variable needs to ajust actual step_count		
	
		frame_list			= [];	// add a "Frame()" constructor to this list
		frame_current		= 0;	// the current frame this animation is on
		frame_total			= 0;
	
		static set_sprite			= function() {
			sprite = asset_get_index(name);
		}
		static set_frames			= function() {
			for (var _i = 0; _i < frame_total; _i++) {
			
				var _frame = new EditorFrame();
				array_push(frame_list, _frame)
			}
		}
	
		static get_sprite			= function() {
			return sprite;
		}
		static get_name				= function() {
			return name;
		}
		static get_frame_current	= function() {
			return frame_current;
		}
		static get_total_steps		= function() {
			var _steps = 0;
			for (var _i = 0; _i < array_length(frame_list); _i++) {
				_steps += frame_list[_i].step_count;
			}
			return _steps;
		}
	
		static reset				= function() {
			frame_current = 0;
		}
		static init					= function() {
		
			sprite =		asset_get_index(name);
			frame_total	=	sprite_get_number(sprite);
			reset();
		}
		static load_data			= function(_data) {
		
			// check if data != undefined
			// if it does, init defaults
		
			for (var _i = 0; _i < frame_total; _i++) {
			
				var _frame = new EditorFrame(_data[_i]);
				array_push(frame_list, _frame)
			}
		}
	
		static update				= function() {
		
			var _frame = frame_list[frame_current];
			_frame.frame_time += 1 / animation_speed;
		
			if (_frame.frame_time >= _frame.step_count) {
				_frame.frame_time = 0;
				frame_current ++;
				if (frame_current >= array_length(frame_list)) {
					frame_current = 0;
				}
			}
		}
	
		init();
	}