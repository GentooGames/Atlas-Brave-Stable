
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   __   ______  ______    //
	// /\  ___\ /\  == \/\  == \ /\ \ /\__  _\/\  ___\   //
	// \ \___  \\ \  _-/\ \  __< \ \ \\/_/\ \/\ \  __\   //
	//  \/\_____\\ \_\   \ \_\ \_\\ \_\  \ \_\ \ \_____\ //
	//   \/_____/ \/_/    \/_/ /_/ \/_/   \/_/  \/_____/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function SpriteController(_config = {}) : IB_Base(_config) constructor {
		
		// public
		static change			= function(_sprite_name, _frame_index = undefined) {
			
			__.sprite_current   = __.sprites.get(_sprite_name);
			__.sprite_current ??= -1;
			
			// update frame_index?
			if (_frame_index != undefined && __.sprite_current != -1) {
				__.sprite_current.set_frame_index(_frame_index);
			}
			
			return __.sprite_current;
		};
		static animation_end	= function(_frame_cushion = 0) {
			if (__.sprite_current == -1) return false;
			return __.sprite_current.animation_end(_frame_cushion);
		};
		static frame_hit		= function(_frame_index) {
			if (__.sprite_current == -1) return false;
			return __.sprite_current.frame_hit(_frame_index);	
		};
		static frame_in_window	= function(_frame_index = get_frame_index(), _window_min = 0, _window_max = undefined) {
			if (__.sprite_current == -1) return false;
			return __.sprite_current.frame_in_window(_frame_index, _window_min, _window_max);	
		};
			
		static get_sprite_index = function(_sprite_name = __.sprite_name) {
			
			var _sprite = (_sprite_name == __.sprite_name)
				? __.sprite_current
				: __.sprites.get(_sprite_name);
				
			_sprite ??= -1;
			
			if (_sprite == -1) return -1;
			
			return _sprite.get_sprite_index();
		};
		static get_frame_index  = function() {
			if (__.sprite_current == -1) return -1;
			return __.sprite_current.get_frame_index();
		};
		static get_speed_scale	= function() {
			return __.speed_scale;
		};
		static set_frame_index	= function(_frame_index) {
			if (__.sprite_current == -1) exit;
			__.sprite_current.set_frame_index(_frame_index);
		};
		
		// private
		with (__) {
			static __parse_sprite_key	= function(_sprite_name) {
				var _sprite_key		  = "";
				var _underscore_count = 0;
				for (var _i = 1, _len_i = string_length(_sprite_name); _i <= _len_i; _i++) {
					var _char = string_char_at(_sprite_name, _i);
					if (_underscore_count < 2) {
						if (_char == "_") {
							_underscore_count++;
						}
					}
					else {
						_sprite_key += _char;	
					}
				};
				return _sprite_key;
			};
			static __setup_sprite_data	= function() {
				if (__.sprite_data == undefined) exit;
					
				var _sprite_names = variable_struct_get_names(__.sprite_data);
				var _sprite_count = array_length(_sprite_names);
					
				for (var _i = 0; _i < _sprite_count; _i++) {
					var _sprite_name = _sprite_names[_i];
					var _sprite_key  = __parse_sprite_key(_sprite_name);
					var _frames		 = __.sprite_data[$ _sprite_name];
					var _sprite		 = new SpriteController_Sprite({
						sprite_name: _sprite_name,
						sprite_key:  _sprite_key,
						frames:		 _frames,
					});
					_sprite.initialize();
					__.sprites.set(_sprite_key, _sprite);
				};	
			};
			static __setup_sprite_start = function() {
				if (__.sprite_data != undefined
				&&	__.sprite_name != undefined
				&&	__.sprite_name != ""
				&& !__.sprites.is_empty()
				) {
					__.sprite_current = get_sprite_index(__.sprite_name);
				}
			};
			
			character		= _config[$ "character"  ] ?? owner;
			sprite_data		= _config[$ "sprite_data"] ?? undefined;
			sprite_name		= _config[$ "sprite_name"] ?? "";
			speed_scale		= _config[$ "speed_scale"] ?? 1;
			sprite_current	= -1;
			sprite_previous	= -1;
			sprites			=  new IB_Collection_Struct();	
		};
		
		// events
		on_initialize(function() {
			__setup_sprite_data();
			__setup_sprite_start();
		});
		on_update	 (function() {
			if (__.sprite_current != -1) {
				__.sprite_current.update(__.speed_scale);	
			}
		});
	};
	function SpriteController_Sprite(_config = {}) constructor {
		
		var _owner = other;
		
		// public
		static animation_end	 = function(_frame_cushion = 0) {
			return frame_hit(__.sprite_number - (1 + _frame_cushion));
		};
		static frame_hit		 = function(_frame_index) {
			return (__.frame_did_hit && _frame_index == __.frame_last_hit);
		};
		static frame_in_window	 = function(_frame_index = get_frame_index(), _window_min = 0, _window_max = undefined) {
			_window_max ??= get_sprite_number() - 1;
			return (_frame_index >= _window_min 
				&&	_frame_index <= _window_max
			);
		};
			
		static get_sprite_name	 = function() {
			return __.sprite_name;	
		};
		static get_sprite_key	 = function() {
			return __.sprite_key;
		};
		static get_sprite_index	 = function() {
			return __.sprite_index;
		};
		static get_sprite_number = function() {
			return __.sprite_number;
		};
		static get_frame_index	 = function() {
			if (__.frame_current == undefined) return -1;
			return __.frame_current.get_frame_index();	
		};
		static get_frame_speed	 = function(_scaled = true) {
			if (!_scaled) return __.frame_speed;
			return __.frame_speed * get_speed_scale();
		};
		static get_speed_scale	 = function() {
			return __.speed_scale;
		};
		static set_frame_index	 = function(_frame_index) {
			__.frame_did_hit = false;
			__.frame_index	 = _frame_index;
			__.frame_current = __.frames[_frame_index];
			__.frame_current.__reset();
		};
		static set_speed_scale	 = function(_speed_scale) {
			__.speed_scale = _speed_scale;
			return self;
		};
		
		// private
		__ = {};
		with (__) {
			static __setup_frames = function() {
				if (__.frame_count <= 0) exit;
				
				var _frames = [];
				for (var _i = 0; _i < __.frame_count; _i++) {
					var _data  = __.frames[_i];
					var _frame = new SpriteController_Sprite_Frame({
						frame_index: _i,
						step_count:  _data.step_count,
					});
					_frame.initialize();
					array_push(_frames, _frame);	
				};
				__.frames		 = _frames;
				__.frame_current = __.frames[0];
			};
			static __next_frame   = function() {
				
				// next frame index
				__.frame_index++;
				
				// wrap if exceeding array
				if (__.frame_index >= __.frame_count) {
					__.frame_index  = 0;	
				}
				
				// update current frame reference for next frame
				__.frame_current = __.frames[__.frame_index];
				
				// prep next frame
				__.frame_current.__.step_index = 0;
			};
			
			owner		   = _owner;
			sprite_name	   = _config[$ "sprite_name"] ?? "";
			sprite_key     = _config[$ "sprite_key" ] ?? "";
			frames		   = _config[$ "frames"	   ] ?? [];
			frame_speed	   = _config[$ "frame_speed"] ?? 1;
			speed_scale	   = _config[$ "speed_scale"] ?? 1;
			sprite_index   =  asset_get_index(sprite_name);
			sprite_number  =  sprite_get_number(sprite_index);
			frame_index	   = -1;
			frame_current  =  undefined;
			frame_count	   =  array_length(frames);
			frame_last_hit = -1;
			frame_did_hit  =  false;
			initialized	   =  false;
		};
		
		// events
		static initialize = function() {
			if (__.initialized) exit;
			__setup_frames();
			__.initialized = true;
		};
		static update	  = function(_scale = 1) {
			if (!__.initialized) exit;
			if (__.frame_current != undefined) {
				
				// update current frame
				var _speed_scaled = get_frame_speed(true) * _scale;
				__.frame_current.update(_speed_scaled);	
			
				// check for frame change
				if (__.frame_current.get_step_finished()) {
					__next_frame();
				}
				
				// update bool flag for frame_hit()
				if (__.frame_did_hit == false) {
					if (__.frame_index != __.frame_last_hit) {
						__.frame_last_hit = __.frame_index;	
						__.frame_did_hit  = true;
					}
				}
				else {
					__.frame_did_hit = false;	
				}
			}
		};
	};
	function SpriteController_Sprite_Frame(_config = {}) constructor {
	
		var _owner = other;
	
		// public
		static get_frame_index	 = function() {
			return __.frame_index;	
		};
		static get_step_count	 = function() {
			return __.step_count;	
		};
		static get_step_index	 = function() {
			return __.step_index;
		};
		static get_step_speed	 = function() {
			return __.step_speed;	
		};
		static get_step_finished = function() {
			return __.step_index >= 1;	
		};
	
		// private
		__ = {};
		with (__) {
			static __reset = function() {
				__.step_index = 0;	
			};
			
			owner		= _owner;
			frame_index = _config[$ "frame_index"] ?? -1;
			step_count  = _config[$ "step_count" ] ??  1;
			step_speed  =  1 / step_count;
			step_index  =  0;
			initialized =  false;
		};
		
		// events
		static initialize = function() {
			if (!__.initialized) {
				 __.initialized = true;	
			}
		};
		static update	  = function(_scale = 1) {
			__.step_index += (__.step_speed * _scale);
		};
	};
	