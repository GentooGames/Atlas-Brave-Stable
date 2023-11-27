
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______  ______   ______   ______  //
	// /\  ___\ /\  ___\/\  ___\/\  ___\ /\  ___\ /\__  _\ //
	// \ \  __\ \ \  __\\ \  __\\ \  __\ \ \ \____\/_/\ \/ //
	//  \ \_____\\ \_\   \ \_\   \ \_____\\ \_____\  \ \_\ //
	//   \/_____/ \/_/    \/_/    \/_____/ \/_____/   \/_/ //
    //                                                 	   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function EffectController(_config = {}) : IB_Base(_config) constructor {
		
		// public
		static get_effect		= function(_name) {
			return __.effects.get(_name);	
		};
		static create_effect	= function(_name, _config = {}, _auto_destroy = true) {
			
			_config[$ "name"		] = _name;
			_config[$ "active"		] =  false;
			_config[$ "visible"		] =  false;
			_config[$ "auto_destroy"] = _auto_destroy;
			
			var _instance = new Effect(_config);
				_instance.initialize();
			
			__.effects.set(_name, _instance);
			
			return _instance;
		};
		static destroy_effect	= function(_name) {
			var _instance  = __.effects.get(_name);
			if (_instance != undefined) {
				
				// remove effect from storage
				__.effects.remove(_name);
				
				// cleanup effect class instance
				_instance.cleanup();
			}
			return self;
		};
		static start_effect		= function(_name, _frame_index = 0, _image_speed = undefined, _on_stop_callback = undefined) {
			var _instance  = __.effects.get(_name);
			if (_instance != undefined) {
				_instance.start(_frame_index, _image_speed, _on_stop_callback);
			}
			return self;
		};
		static stop_effect		= function(_name) {
			var _instance  = __.effects.get(_name);
			if (_instance != undefined) {
				_instance.stop();
			}
			return self;
		};
		static draw_effects		= function(_x, _y, _xscale = undefined, _yscale = _xscale, _facing = undefined, _rot = undefined, _color = undefined, _alpha = undefined) {
			__.effects.for_each(function(_effect, _data) {
				_effect.draw(_data.x, _data.y, _data.xscale, _data.yscale, _data.facing, _data.rot, _data.color, _data.alpha);
			},
			{	x:		_x,
				y:		_y,
				xscale: _xscale,
				yscale: _yscale,
				facing: _facing,
				rot:	_rot,
				color:	_color,
				alpha:	_alpha,
			});
			return self;
		};
		static for_each_effect	= function(_callback, _data = undefined) {
			// callback = function(_effect, _data) {};
			__.effects.for_each(_callback, _data);	
			 return self;
		};
		static on_effect_start	= function(_name, _callback, _data = undefined) {
			var _instance  = __.effects.get(_name);
			if (_instance != undefined) {
				_instance.on_start(_callback, _data);
			}
			return self;
		};
		static on_effect_stop	= function(_name, _callback, _data = undefined) {
			var _instance  = __.effects.get(_name);
			if (_instance != undefined) {
				_instance.on_stop(_callback, _data);
			}
			return self;
		};
		
		// private
		with (__) {
			effects = new IB_Collection_Struct();
		};
		
		// events
		on_update (function() {
			__.effects.for_each(function(_instance) {
				_instance.update();
			});
		});
		on_cleanup(function() {
			__.effects.for_each(function(_instance) {
				_instance.cleanup();
			});
		});
	};
	
	function Effect(_config = {}) constructor {
		
		var _self  = self;
		var _owner = other;
		
		// public 
		static draw						= function(_x = get_x(), _y = get_y(), _xscale = 1, _yscale = _xscale, _facing = get_facing(), _rot = 0, _col = get_color(), _alpha = 1) {
			if (__.frame_current != undefined
			&&	is_visible()
			) {
				__.frame_current.draw(
					_x + __.x_offset, 
					_y + __.y_offset, 
				   (__.scale * __.scale_x) * _xscale, 
				   (__.scale * __.scale_y) * _yscale, 
					_facing,
					__.angle + _rot,
					_col, 
					__.alpha * _alpha,
				);
			}
			return self;
		};
		static start					= function(_frame_index = 0, _image_speed = __.image_speed, _on_stop_callback = undefined) {
			set_frame_index(_frame_index);
			set_image_speed(_image_speed);
			activate();
			show();
			__.on_stop_temp_callback = _on_stop_callback;
			__on_start();
			return self;
		};
		static stop						= function(_execute_callbacks = true) {
			hide();
			deactivate();
			print("STOPPED "+string(__.timer));
			if (_execute_callbacks) __on_stop();
			if (__.auto_destroy) __.owner.destroy_effect(get_name());
			return self;
		};
		static on_start					= function(_callback, _data = undefined) {
			array_push(__.on_start_callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return self;
		};
		static on_stop					= function(_callback, _data = undefined) {
			array_push(__.on_stop_callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return self;
		}; 
										
		static is_active				= function() {
			return __.active;	
		};
		static is_visible				= function() {
			return __.visible;	
		};
										
		static get_name					= function() {
			return __.name;	
		};
		static get_sprite_index			= function() {
			return __.sprite_index;	
		};
		static get_image_speed			= function() {
			return __.image_speed;	
		};
		static get_frame_index			= function() {
			return floor(__.frame_index);
		};
		static get_frame_count			= function() {
			return __.frame_count;	
		};
		static get_x					= function() {
			return __.x;	
		};
		static get_y					= function() {
			return __.y;	
		};
		static get_scale				= function() {
			return __.scale;
		};
		static get_scale_x				= function(_scaled = true) {
			if (_scaled) {
				return __.scale_x * __.scale;
			}
			return __.scale_x;
		};
		static get_scale_y				= function(_scaled = true) {
			if (_scaled) {
				return __.scale_y * __.scale;
			}
			return __.scale_y;
		};
		static get_angle				= function() {
			return __.angle;	
		};
		static get_facing				= function() {
			return __.facing;	
		};
		static get_color				= function() {
			return __.color;	
		};
		static get_alpha				= function() {
			return __.alpha;	
		};
		static get_sprite_loop_on_end	= function() {
			return __.loop_on_end;	
		};
		
		static set_name					= function(_name) {
			__.name = _name;
			return self;
		};
		static set_sprite_index			= function(_sprite_index) {
			__.sprite_index = _sprite_index;
			__cleanup_frames();
			__split_sprite();
			return self;
		};
		static set_image_speed			= function(_image_speed) {
			__.image_speed = _image_speed;
			return self;
		};
		static set_frame_index			= function(_frame_index) {
			__.frame_index	 = _frame_index;
			__.frame_current = __.frames[floor(_frame_index)];
			return self;
		};
		static set_x					= function(_x) {
			__.x = _x;
			return self;
		};
		static set_y					= function(_y) {
			__.y = _y;
			return self;
		};
		static set_scale				= function(_scale) {
			__.scale = _scale;
			return self;
		};
		static set_scale_x				= function(_scale_x) {
			__.scale_x = _scale_x;
			return self;
		};
		static set_scale_y				= function(_scale_y) {
			__.scale_y = _scale_y;
			return self;
		};
		static set_angle				= function(_angle) {
			__.angle = _angle;
			return self;
		};
		static set_facing				= function(_facing) {
			__.facing = _facing;
			return self;
		};
		static set_color				= function(_color) {
			__.color = _color;
			return self;
		};
		static set_alpha				= function(_alpha) {
			__.alpha = _alpha;
			return self;
		};
		static set_sprite_loop_on_end	= function(_loop) {
			__.loop_on_end = _loop;
			return self;
		};
		static set_alpha_config			= function(_alpha_config) {
			__.alpha_config = _alpha_config;
			__cleanup_frames();
			__split_sprite();
			return self;
		};
		static set_color_config			= function(_color_config) {
			__.color_config = _color_config;
			__cleanup_frames();
			__split_sprite();
			return self;
		};
		static set_frame_config			= function(_frame_config) {
			__.frame_config = _frame_config;
			__cleanup_frames();
			__split_sprite();
			return self;
		};
	
		// private
		__ = {};
		with (__) {
			static __split_sprite	= function() {
				var _frame_count = sprite_get_number(__.sprite_index);
				for (var _frame_i = 0; _frame_i < _frame_count; _frame_i++) {
					
					////////////////////////
					
					// set duration 
					if (_frame_i < array_length(__.frame_configuration)) {
						 var _duration = __.frame_configuration[_frame_i];		
					}
					else var _duration = 1; 
					
					// set color 
					if (_frame_i < array_length(__.color_configuration)) {
						 var _color = __.color_configuration[_frame_i];	
					}
					else var _color = __.color;
					
					// set alpha
					if (_frame_i < array_length(__.alpha_configuration)) {
						 var _alpha = __.alpha_configuration[_frame_i];	
					}
					else var _alpha = __.alpha;
					
					////////////////////////
					
					// create frames
					repeat (_duration) {
						array_push(__.frames, new EffectFrame({
							sprite_index: __.sprite_index,
							frame_index:  _frame_i,
							color:		  _color,
							alpha:		  _alpha,
						}));
						__.frame_count++;
					};
				};
				__.frame_current = __.frames[0];
			};
			static __on_start		= function() {
				iceberg.array.for_each(__.on_start_callbacks, function(_data) {
					_data.callback(_data.data);
				});
			};
			static __on_stop		= function() {
				iceberg.array.for_each(__.on_stop_callbacks, function(_data) {
					_data.callback(_data.data);
				});
				if (__.on_stop_temp_callback != undefined) {
					__.on_stop_temp_callback();	
				}
			};
			static __update_timer	= function() {
				__.timer++;
			};
			static __update_index	= function() {
				__.frame_index += __.image_speed;
				if (__.frame_index == __.frame_count) {
					__.frame_index %= __.frame_count;	
					if (!__.loop_on_end) {
						stop();
					}
				}
				if (!__.cleaned_up) {
					__.frame_current = __.frames[floor(__.frame_index)];
				}
			};
			static __cleanup_frames	= function() {
				iceberg.array.for_each(__.frames, function(_frame) {
					_frame.cleanup();
				});
				__.frames	   = [];
				__.frame_count = 0;
			};
			
			owner				  = _config[$ "owner"		] ?? _owner;
			initialized			  = _config[$ "initialized"	] ?? false;
			active				  = _config[$ "active"		] ?? true;
			name				  = _config[$ "name"		] ?? instanceof(_self);
			visible				  = _config[$ "visible"		] ?? true;
			sprite_index		  = _config[$ "sprite_index"] ?? undefined;
			image_speed			  = _config[$ "image_speed"	] ?? 1.0;
			x					  = _config[$ "x"			] ?? 0;
			y					  = _config[$ "y"			] ?? 0;
			scale				  = _config[$ "scale"		] ?? 1;
			scale_x				  = _config[$ "scale_x"		] ?? scale;
			scale_y				  = _config[$ "scale_y"		] ?? scale;
			x_offset			  = _config[$ "x_offset"	] ?? 0;
			y_offset			  = _config[$ "y_offset"	] ?? 0;
			angle				  = _config[$ "angle"		] ?? 0;
			facing				  = _config[$ "facing"		] ?? 1;
			color				  = _config[$ "color"		] ?? c_white;	// will only be used if color_configuration not used
			alpha				  = _config[$ "alpha"		] ?? 1;			// will only be used if alpha_configuration not used
			auto_destroy		  = _config[$ "auto_destroy"] ?? false;
			loop_on_end			  = _config[$ "loop_on_end"	] ?? false;
			pause_on_end		  = _config[$ "pause_on_end"] ?? false; //*new
			frame_configuration	  = _config[$ "frame_config"] ?? [2,	   4,	    2,		 1	    ];
			color_configuration	  = _config[$ "color_config"] ?? [c_white, c_white, c_white, c_white];
			alpha_configuration	  = _config[$ "alpha_config"] ?? [1.0,	   1.0,	    1.0,	 1.0    ];
			frame_count			  =  0;
			frame_current		  =  undefined;
			frame_index			  =  0;
			frames				  =  [];
			on_start_callbacks	  =  [];
			on_stop_callbacks	  =  [];
			on_stop_temp_callback =  undefined;
			cleaned_up			  =  false;							 
			timer				  =  0;
		};
		
		// events
		static initialize = function() {
			if (!__.initialized) {
				__.initialized = true;
				__split_sprite();
			}
		};
		static activate	  = function() {
			__.active = true;
			return self;
		};
		static deactivate = function() {
			__.active = false;
			return self;
		};
		static update	  = function() {
			if (__.initialized && __.active) {
				__update_timer();
				__update_index();
			}
		};
		static cleanup	  = function() {
			if (__.initialized && ! __.cleaned_up) {
				__cleanup_frames();	
				__.cleaned_up = true;
			}
		};
		static show		  = function() {
			__.visible = true;
			return self;
		};
		static hide		  = function() {
			__.visible = false;
			return self;
		};
	};
	
	function EffectFrame(_config = {}) constructor {
		
		// public
		static draw				= function(_x, _y, _xscale = 1, _yscale = _xscale, _facing = get_facing(), _rot = 0, _col = get_color(), _alpha = 1) {
			
			// need to adjust rotation if mirrored
			var _xscale_sum = (__.scale_x * __.scale) * _xscale * _facing;
			if (_xscale_sum < 0) _rot += 180;
			
			show_debug_message("xscale: " + string(_xscale_sum) + ", angle: " + string(__.angle + _rot));
			
			draw_sprite_ext(
				__.sprite_index, 
				__.frame_index, 
				_x, 
				_y, 
				_xscale_sum, 
			   (__.scale_y * __.scale) * _yscale,
				__.angle + _rot,
				_col, 
				__.alpha * _alpha,
			);
			return self;
		};
		static get_sprite_index = function() {
			return __.sprite_index;	
		};
		static get_frame_index	= function() {
			return __.frame_index;	
		};
		static get_scale		= function() {
			return __.scale;	
		};
		static get_scale_x		= function(_scaled = true) {
			if (_scaled) {
				return __.scale_x * __.scale;	
			}
			return __.scale_x;	
		};
		static get_scale_y		= function(_scaled = true) {
			if (_scaled) {
				return __.scale_y * __.scale;	
			}
			return __.scale_y;	
		};
		static get_angle		= function() {
			return __.angle;	
		};
		static get_facing		= function() {
			return __.facing;	
		};
		static get_alpha		= function() {
			return __.alpha;	
		};
		static get_color		= function() {
			return __.color;	
		};
		
		static set_sprite_index	= function(_sprite_index) {
			__.sprite_index = _sprite_index;
			return self;
		};
		static set_frame_index	= function(_frame_index) {
			__.frame_index = _frame_index;
			return self;
		};
		static set_scale		= function(_scale) {
			__.scale = _scale;
			return self;
		};
		static set_scale_x		= function(_scale_x) {
			__.scale_x = _scale_x;
			return self;
		};
		static set_scale_y		= function(_scale_y) {
			__.scale_y = _scale_y;
			return self;
		};
		static set_angle		= function(_angle) {
			__.angle = _angle;
			return self;
		};
		static set_facing		= function(_facing) {
			__.facing = _facing;
			return self;
		};
		static set_alpha		= function(_alpha) {
			__.alpha = _alpha;
			return self;
		};
		static set_color		= function(_color) {
			__.color = _color;
			return self;
		};
		
		// private
		__ = {};
		with (__) {
			sprite_index = _config[$ "sprite_index"] ?? undefined;
			frame_index  = _config[$ "frame_index" ] ?? 0;
			scale		 = _config[$ "scale"	   ] ?? 1;
			scale_x		 = _config[$ "scale_x"	   ] ?? scale;
			scale_y		 = _config[$ "scale_y"	   ] ?? scale;
			angle		 = _config[$ "angle"	   ] ?? 0;
			facing		 = _config[$ "facing"	   ] ?? 1;
			alpha		 = _config[$ "alpha"	   ] ?? 1.0;
			color		 = _config[$ "color"	   ] ?? c_white;
		};
		
		// events
		static cleanup = function() {
			// compatibility...
		};
	};