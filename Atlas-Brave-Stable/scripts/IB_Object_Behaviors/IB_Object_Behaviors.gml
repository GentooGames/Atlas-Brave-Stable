
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __  __   ______   __   __ __   ______   ______    //
	// /\  == \ /\  ___\ /\ \_\ \ /\  __ \ /\ \ / //\ \ /\  __ \ /\  == \   //
	// \ \  __< \ \  __\ \ \  __ \\ \  __ \\ \ \'/ \ \ \\ \ \/\ \\ \  __<   //
	//  \ \_____\\ \_____\\ \_\ \_\\ \_\ \_\\ \__|  \ \_\\ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_/\/_/ \/_/\/_/ \/_/    \/_/ \/_____/ \/_/ /_/ //
	//                                                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	
	function IB_Behavior_Core() {
	
		var _self   = self;
		var _other  = other;
		var _config = {
			owner: _self[$ "owner"] ?? _other,
			guid:  _self[$ "guid" ] ??  undefined, // __.IB.core.generate_guid()
			name:  _self[$ "name" ] ??  undefined, // __.IB.core.generate_name()
			uid:   _self[$ "uid"  ] ??  undefined, // __.IB.core.generate_uid()
		};
		
		// public
		get_owner = function() {
			return __.IB.core.owner;	
		};
		get_guid  = function() {
			return __.IB.core.guid;	
		};
		get_name  = function() {
			return __.IB.core.name;
		};
		get_uid   = function() {
			return __.IB.core.uid;
		};
			
		set_owner = function(_owner) {
			__.IB.core.owner = _owner;
			return self;
		};
		set_guid  = function(_guid) {
			__.IB.core.guid = _guid;
			return self;
		};
		set_name  = function(_name) {
			__.IB.core.name = _name;
			return self;
		};
		set_uid   = function(_uid) {
			__.IB.core.uid = _uid;
			return self;
		};
	
		// private
		self[$ "__"] ??= {};
		__.IB = {};
		with (__.IB) {
			log	 = method(_self, function(_string, _flags = IB_LOG_FLAG.NONE) {
				iceberg.log(
					"[" + object_get_name(object_index) + "] " + _string, 
					IB_LOG_FLAG.INSTANCES & IB_LOG_FLAG.OBJECTS & _flags
				);
			});
			core = {};
			with (core) {
				generate_guid = method(_self, function() {
					return __.IB.core.generate_name() + "_" + __.IB.core.generate_uid()
				});
				generate_name = method(_self, function() {
					return object_get_name(object_index);
				});
				generate_uid  = method(_self, function() {
					return string(ptr(self));
				});
				on_callback	  = method(_self, function(_callback_array) {
					for (var _i = 0, _len = array_length(_callback_array); _i < _len; _i++) {
						var _callback = _callback_array[_i];
						_callback.callback(_callback.data);
					};
				});
					
				root  = _self;
				owner = _config.owner;
				guid  = _config[$ "guid"] ?? generate_guid();
				name  = _config[$ "name"] ?? generate_name();
				uid	  = _config[$ "uid" ] ?? generate_uid();
			};
		};
	};
	function IB_Behavior_Lifecycle() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();

		////////////////////////////
	
		var _self	= self;
		var _config = {
			initialized: _self[$ "initialized"] ?? false,
			active:		 _self[$ "active"	  ] ?? true,	
		};
		
		// public
		initialize		= function() {
			if (!is_initialized()) {
				__.IB.log("initialize");
				__.IB.lifecycle.initialize.flag = true;
				__.IB.lifecycle.cleanup.flag	= false;
				__.IB.lifecycle.initialize.execute();
			}
			return self;
		};
		activate		= function(_active = true) {
			if (_active) {
				if (is_initialized() && !is_active()) {
					__.IB.log("activate");
					__.IB.lifecycle.activate.flag   = true;
					__.IB.lifecycle.deactivate.flag = false;
					__.IB.lifecycle.activate.execute();
				}
			}
			else deactivate();
			return self;
		};
		deactivate		= function() {
			if (is_initialized()) {
				__.IB.log("deactivate");
				__.IB.lifecycle.activate.flag	= false;
				__.IB.lifecycle.deactivate.flag = true;
				__.IB.lifecycle.deactivate.execute();
			}
			return self;
		};
		destroy			= function(_immediate = true, _cleanup = true) {
			if (is_initialized() && !is_destroyed()) {
				__.IB.lifecycle.destroy.flag = true;
				__.IB.lifecycle.destroy.execute();
				__.IB.log("destroy");
				if (_cleanup  ) cleanup();
				if (_immediate) instance_destroy();
			}
			return self;
		};
		cleanup			= function() {
			if (is_initialized() && !is_cleaned_up()) {
				__.IB.lifecycle.cleanup.flag = true;
				__.IB.lifecycle.cleanup.execute();
				__.IB.log("cleanup");
			}
			return self;
		};
		
		is_initialized	= function() {
			return __.IB.lifecycle.initialize.flag;	
		};
		is_active		= function() {
			return __.IB.lifecycle.activate.flag;	
		};
		is_destroyed	= function() {
			return __.IB.lifecycle.destroy.flag;	
		};
		is_cleaned_up	= function() {
			return __.IB.lifecycle.cleanup.flag;	
		};
			
		on_initialize	= function(_callback, _data = undefined) {
			array_push(__.IB.lifecycle.initialize.callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return initialize;
		};
		on_activate		= function(_callback, _data = undefined) {
			array_push(__.IB.lifecycle.activate.callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return activate;
		};
		on_deactivate	= function(_callback, _data = undefined) {
			array_push(__.IB.lifecycle.deactivate.callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return deactivate;
		};
		on_destroy		= function(_callback, _data = undefined) {
			array_push(__.IB.lifecycle.destroy.callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return destroy;
		};
		on_cleanup		= function(_callback, _data = undefined) {
			array_push(__.IB.lifecycle.cleanup.callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return cleanup;
		};
		
		// private
		with (__.IB) {
			lifecycle = {};
			with (lifecycle) {
				initialize = {
					flag:	  _config.initialized, 
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.lifecycle.initialize.callbacks);
					}),
				};
				activate   = {
					flag:	   _config.active,
					callbacks:	[],
					execute:	method(_self, function() {
						__.IB.core.on_callback(__.IB.lifecycle.activate.callbacks);
					}),
				};
				deactivate = {
					flag:	  !_config.active,
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.lifecycle.deactivate.callbacks);
					}),
				};
				destroy	   = {
					flag:		false,
					callbacks:  [],
					execute:    method(_self, function() {
						__.IB.core.on_callback(__.IB.lifecycle.destroy.callbacks);
					}),
				};
				cleanup	   = {
					flag:	   false,
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.lifecycle.cleanup.callbacks);
					}),
				};
			};
		};
	};
	function IB_Behavior_Update() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Lifecycle();

		////////////////////////////
	
		var _self	= self;
		var _config = {
			// this behavior has no configurable properties yet...
		};
		
		// public
		update_begin	= function(_active = is_active()) {
			if (_active && is_initialized()) {
				__.IB.update.update_begin.execute();
			}
			return self;
		};
		update			= function(_active = is_active()) {
			if (_active && is_initialized()) {
				__.IB.update.update.execute();
			}
			return self;
		};
		update_end		= function(_active = is_active()) {
			if (_active && is_initialized()) {
				__.IB.update.update_end.execute();
			}
			return self;
		};
			
		on_update_begin	= function(_callback, _data = undefined) {
			array_push(__.IB.update.update_begin.callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return update_begin;
		};
		on_update		= function(_callback, _data = undefined) {
			array_push(__.IB.update.update.callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return update;
		};
		on_update_end	= function(_callback, _data = undefined) {
			array_push(__.IB.update.update_end.callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return update_end;
		};
		
		// private
		with (__.IB) {
			update = {};
			with (update) {
				update_begin = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.update.update_begin.callbacks);
					}),
				};
				update		 = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.update.update.callbacks);
					}),
				};
				update_end	 = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.update.update_end.callbacks);
					}),
				};
			};
		};
	};
	function IB_Behavior_Render() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Lifecycle();

		////////////////////////////
	
		var _self	= self;
		var _config = {
			visible: _self.visible,	
		};
		
		// public
		show			= function(_visible = true) {
			if (_visible) {
				if (is_initialized() && !is_visible()) {
					__.IB.log("show");
										 visible = true;
					__.IB.render.visibility.flag = true;
					__.IB.render.visibility.show.execute();
				}
			}
			else hide();
			return self;
		};
		hide			= function() {
			if (is_initialized() && is_visible()) {
				__.IB.log("hide");
									 visible = false;
				__.IB.render.visibility.flag = false;
				__.IB.render.visibility.hide.execute();
			}
			return self;
		};
		render			= function(_visible = is_visible()) {
			if (_visible && is_initialized()) {
				__.IB.render.render.execute();
			}
			return self;
		};
		render_begin	= function(_visible = is_visible()) {
			if (_visible && is_initialized()) {
				__.IB.render.render_begin.execute();
			}
			return self;
		};
		render_end		= function(_visible = is_visible()) {
			if (_visible && is_initialized()) {
				__.IB.render.render_end.execute();
			}
			return self;
		};
		render_gui		= function(_visible = is_visible()) {
			if (_visible && is_initialized()) {
				__.IB.render.render_gui.execute();
			}
			return self;
		};
		
		is_visible		= function() {
			return __.IB.render.visibility.flag;
		};
		
		on_show			= function(_callback, _data = undefined) {
			array_push(__.IB.render.visibility.show.callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return show;
		};
		on_hide			= function(_callback, _data = undefined) {
			array_push(__.IB.render.visibility.hide.callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return hide;
		};
		on_render		= function(_callback, _data = undefined) {
			array_push(__.IB.render.render.callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return render;
		};
		on_render_begin	= function(_callback, _data = undefined) {
			array_push(__.IB.render.render_begin.callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return render_begin;
		};
		on_render_end	= function(_callback, _data = undefined) {
			array_push(__.IB.render.render_end.callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return render_end;
		};
		on_render_gui	= function(_callback, _data = undefined) {
			array_push(__.IB.render.render_gui.callbacks, {
				callback: _callback, 
				data: _data,
			});
			return render_gui;
		};
		
		// private
		with (__.IB) {
			render = {};
			with (render) {
				visibility	 = {
					flag: _config.visible,
					show:  {
						callbacks: [],
						execute:   method(_self, function() {
							__.IB.core.on_callback(__.IB.render.visibility.show.callbacks);
						}),
					},
					hide:  {
						callbacks: [],
						execute:   method(_self, function() {
							__.IB.core.on_callback(__.IB.render.visibility.hide.callbacks);
						}),
					},
				};
				render		 = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.render.render.callbacks);
					}),
				};
				render_begin = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.render.render_begin.callbacks);
					}),
				};
				render_end	 = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.render.render_end.callbacks);
					}),
				};
				render_gui	 = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.render.render_gui.callbacks);
					}),
				};
			};
		};
	};
	function IB_Behavior_Render_Ext() {
		
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Lifecycle();
		_IB_Behavior_Ensure_Render();
		_IB_Behavior_Ensure_Sprite();
		_IB_Behavior_Ensure_Position();
		_IB_Behavior_Ensure_Scale();
		_IB_Behavior_Ensure_Color();
		_IB_Behavior_Ensure_Alpha();

		////////////////////////////
	
		var _self	= self;
		var _config = {
			// if set to true, if the z value ever goes "underground"
			// then we will use draw_sprite_part() in order to achieve
			// a visual effect that makes it look like the entity is
			// partially underground.
			render_z_underground_partial: _self[$ "render_z_underground_partial"] ?? true,
		};
		
		// public
		render_bbox			   = function(_color, _outline = true) {
			draw_rectangle_color(
				position_get_left(),
				position_get_top(),
				position_get_right(),
				position_get_bottom(),
				_color,
				_color,
				_color,
				_color,
				_outline,
			);
			return self;
		};
		render_get_default	   = function() {
			return __.IB.render_ext.render_default;	
		};
		render_get_function	   = function() {
			return __.IB.render_ext.render_function;	
		};
		render_set_function	   = function(_function) {
			__.IB.render_ext.render_function = _function;
			return self;
		};
		render_set_pre_render  = function(_function) {
			__.IB.render_ext.render_pre_render = _function;
			return self;
		};
		render_set_post_render = function(_function) {
			__.IB.render_ext.render_post_render = _function;
			return self;
		};
			
		// private
		with (__.IB) {
			render_ext = {};
			with (render_ext) {
				render_sprite_ext			=  method(_self, function() {
					var _sprite_index  =  sprite_get_sprite_index();
					if (_sprite_index !=  undefined
					&&	_sprite_index != -1
					&&	 alpha_get() > 0
					) {
						draw_sprite_ext(
						   _sprite_index,
							sprite_get_image_index(),
							position_get_x(),
							position_get_y(),
							scale_get_x(true, true),
							scale_get_y(true),
							angle_get(),
							color_get(),
							alpha_get(),
						);
					};
				});
				render_default				=  method(_self, function() {
					if (__.IB.render_ext.render_z_undergound_partial) {
						var _z = position_get_z();
						if (_z > 0) {
							if (_z <= sprite_get_sprite_height()) {
								__.IB.render_ext.render_partial();
							}
						}
						else __.IB.render_ext.render_sprite_ext();
					}
					else __.IB.render_ext.render_sprite_ext();
				});
				render_partial				=  method(_self, function() {
				
					var _facing	= scale_get_facing();
					var _z		= position_get_z();
					var _height	= sprite_yoffset + (sprite_get_sprite_height() * 0.5) - _z;
					var _y		= (y - sprite_yoffset) + _z;
				
					draw_sprite_part_ext(
						 sprite_get_sprite_index(),
						 sprite_get_image_index(),
						 0,
						 0,
					     abs(sprite_width),
						_height,
						 x - (sprite_xoffset * _facing),
						_y,
						 image_xscale * _facing,
						 image_yscale,
						 image_blend,
						 image_alpha,
					);
				
				});
				render_z_undergound_partial = _config.render_z_underground_partial;
				render_function				=  render_default;
				render_pre_render			=  undefined;
				render_post_render			=  undefined;
			};
		};
		
		// events
		on_render(function() {
			if (__.IB.render_ext.render_pre_render  != undefined) {
				__.IB.render_ext.render_pre_render();
			}
			if (__.IB.render_ext.render_function    != undefined) {
				__.IB.render_ext.render_function();	
			}
			if (__.IB.render_ext.render_post_render != undefined) {
				__.IB.render_ext.render_post_render();
			}
		});
	};
	function IB_Behavior_Room() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Lifecycle();

		////////////////////////////
	
		var _self	= self;
		var _config = {
			// this behavior has no configurable properties yet...
		};
		
		// public
		room_start	  = function() {
			if (is_initialized()) {
				__.IB.rooms.room_start.execute();
			}
			return self;
		};
		room_end	  = function() {
			if (is_initialized()) {
				__.IB.rooms.room_end.execute();
			}
			return self;
		};
					    
		on_room_start = function(_callback, _data = undefined) {
			array_push(__.IB.rooms.room_start.callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return room_start;
		};
		on_room_end	  = function(_callback, _data = undefined) {
			array_push(__.IB.rooms.room_end.callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return room_end;
		};
		
		// private
		with (__.IB) {
			rooms = {};
			with (rooms) {
				room_start = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.rooms.room_start.callbacks);
					}),
				};
				room_end   = {
					callbacks: [],
					execute:   method(_self, function() {
						__.IB.core.on_callback(__.IB.rooms.room_end.callbacks);
					}),
				};
			};
		};
	};
	function IB_Behavior_Sprite() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		
		////////////////////////////
	
		var _self	= self;
		var _config = {
			width:  _self[$ "width" ] ?? (_self.bbox_right  - _self.bbox_left),
			height: _self[$ "height"] ?? (_self.bbox_bottom - _self.bbox_top ),
		};
		
		// public
		sprite_get_image_index	 = function() {
		 	return image_index;	
		};
		sprite_get_image_speed	 = function() {
		 	return image_speed;	
		};
		sprite_get_sprite_index  = function() {
		 	return sprite_index;	
		};
		sprite_get_sprite_width  = function(_scale = true) {
			if (_scale) {
				return abs(__.IB.sprite.width * image_xscale);	
			}
			return __.IB.sprite.width;
		};
		sprite_get_sprite_height = function(_scale = true) {
			if (_scale) {
				return abs(__.IB.sprite.height * image_yscale);	
			}
			return __.IB.sprite.height;
		};

		sprite_set_image_index	 = function(_image_index) {
		 	image_index	= _image_index;
		 	return self;
		};
		sprite_set_image_speed   = function(_image_speed) {
		 	image_speed	= _image_speed;
		 	return self;
		};
		sprite_set_sprite_index  = function(_sprite_index) {

		 	var _old_index =  sprite_index;
		 	sprite_index   = _sprite_index;

		 	if (_old_index == undefined || _old_index == -1) {
		 		__.IB.sprite.width  = bbox_right  - bbox_left;
		 		__.IB.sprite.height = bbox_bottom - bbox_top;
		 	}

		 	return self;
		};
		
		// private
		with (__.IB) {
			sprite = {};
			with (sprite) {
				width  = _config.width;
				height = _config.height;
			};
		};
	};
	function IB_Behavior_Scale() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Lifecycle();
		_IB_Behavior_Ensure_Update();

		////////////////////////////
	
		var _self	= self;
		var _config = {
			scale:				  _self[$ "scale"			   ] ??  1,
			scale_lerp_target:	 (_self[$ "scale_lerp_target"  ] ?? _self[$ "scale"]) ?? 1,
			scale_lerp_speed:	  _self[$ "scale_lerp_speed"   ] ??  0.25,
			scale_x_start:		 (_self[$ "scale_x_start"	   ] ?? _self[$ "scale_x"]) ?? _self.image_xscale,
			scale_x_lerp_target: (_self[$ "scale_x_lerp_target"] ?? _self[$ "scale_x"]) ?? _self.image_xscale,
			scale_x_lerp_speed:   _self[$ "scale_x_lerp_speed" ] ??  0.25,
			scale_y_start:		 (_self[$ "scale_y_start"	   ] ?? _self[$ "scale_y"]) ?? _self.image_yscale,
			scale_y_lerp_target: (_self[$ "scale_y_lerp_target"] ?? _self[$ "scale_y"]) ?? _self.image_yscale,
			scale_y_lerp_speed:   _self[$ "scale_y_lerp_speed" ] ??  0.25,
			facing:				  _self[$ "facing"			   ] ??  1,
		};
		
		// public
		scale_get				= function() {
			return __.IB.scale.factor.current.value;
		};
		scale_get_facing		= function() {
			return __.IB.scale.facing;
		};
		scale_get_lerp_target	= function() {
			return __.IB.scale.factor.target.value;
		};
		scale_get_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.IB.scale.factor.target.speed.start;		
			}
			return __.IB.scale.factor.target.speed.value;
		};
		scale_get_x				= function(_apply_scale_base = true, _apply_facing = false) {
			var _scale_x = __.IB.scale.factor_x.current.value;
			if (_apply_scale_base) _scale_x *= scale_get();	
			if (_apply_facing	 ) _scale_x *= scale_get_facing();
			return _scale_x;
		};
		scale_get_x_lerp_target	= function(_apply_scale_base = true, _apply_facing = false) {
			var _scale_x_target = __.IB.scale.factor_x.target.value;
			if (_apply_scale_base) _scale_x_target *= scale_get();	
			if (_apply_facing	 ) _scale_x_target *= scale_get_facing();
			return _scale_x_target;
		};
		scale_get_x_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.IB.scale.factor_x.target.speed.start;		
			}
			return __.IB.scale.factor_x.target.speed.value;
		};
		scale_get_y				= function(_apply_scale_base = true, _apply_facing = false) {
			var _scale_y = __.IB.scale.factor_y.current.value;
			if (_apply_scale_base) _scale_y *= scale_get();	
			if (_apply_facing	 ) _scale_y *= scale_get_facing();
			return _scale_y;
		};
		scale_get_y_lerp_target	= function(_apply_scale_base = true, _apply_facing = false) {
			var _scale_y_target = __.IB.scale.factor_y.target.value;
			if (_apply_scale_base) _scale_y_target *= scale_get();	
			if (_apply_facing	 ) _scale_y_target *= scale_get_facing();
			return _scale_y_target;
		};
		scale_get_y_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.IB.scale.factor_y.target.speed.start;		
			}
			return __.IB.scale.factor_y.target.speed.value;
		};
			
		scale_set				= function(_scale, _lerp = false, _lerp_speed = scale_get_lerp_speed(true)) {
			scale_set_lerp_target(_scale, _lerp_speed);
			if (!_lerp) scale_snap();
			return self;
		};
		scale_set_facing		= function(_facing) {
			__.IB.scale.facing = _facing;
			return self;
		};
		scale_set_lerp_target	= function(_scale_target, _target_speed = scale_get_lerp_speed(true)) {
			__.IB.scale.factor.target.value = _scale_target;
			scale_set_lerp_speed(_target_speed, false);
			return self;
		};
		scale_set_lerp_speed	= function(_scale_speed, _update_start = true) {
			__.IB.scale.factor.target.speed.value = _scale_speed;
			if (_update_start) {
				__.IB.scale.factor.target.speed.start = _scale_speed;
			}
			return self;
		};
		scale_set_x				= function(_scale_x, _lerp = false, _lerp_speed = scale_get_lerp_speed(true)) {
			scale_set_x_lerp_target(_scale_x, _lerp_speed);
			if (!_lerp) scale_snap_x();
			return self;
		};
		scale_set_x_lerp_target	= function(_scale_x_target, _x_target_speed = scale_get_lerp_speed(true)) {
			__.IB.scale.factor_x.target.value = _scale_x_target;
			scale_set_x_lerp_speed(_x_target_speed, false);
			return self;
		};
		scale_set_x_lerp_speed	= function(_scale_x_speed, _update_start = true) {
			__.IB.scale.factor_x.target.speed.value = _scale_x_speed;
			if (_update_start) {
				__.IB.scale.factor_x.target.speed.start = _scale_x_speed;
			}
			return self;
		};
		scale_set_y				= function(_scale_y, _lerp = false, _lerp_speed = scale_get_lerp_speed(true)) {
			scale_set_y_lerp_target(_scale_y, _lerp_speed);
			if (!_lerp) scale_snap_y();
			return self;
		};
		scale_set_y_lerp_target	= function(_scale_y_target, _y_target_speed = scale_get_lerp_speed(true)) {
			__.IB.scale.factor_y.target.value = _scale_y_target;
			scale_set_y_lerp_speed(_y_target_speed, false);
			return self;
		};
		scale_set_y_lerp_speed	= function(_scale_y_speed, _update_start = true) {
			__.IB.scale.factor_y.target.speed.value = _scale_y_speed;
			if (_update_start) {
				__.IB.scale.factor_y.target.speed.start = _scale_y_speed;
			}
			return self;
		};
			
		scale_flip_x			= function(_lerp_flip = false, _lerp_speed = scale_get_x_lerp_speed(true)) {
			__.IB.scale.factor_y.target.value	  *= -1;
			__.IB.scale.factor_y.target.speed.value = _lerp_speed;
			if (!_lerp_flip) scale_snap_x();
			return self;
		};
		scale_flip_y			= function(_lerp_flip = false, _lerp_speed = scale_get_y_lerp_speed(true)) {
			__.IB.scale.factor_y.target.value	  *= -1;
			__.IB.scale.factor_y.target.speed.value = _lerp_speed;
			if (!_lerp_flip) scale_snap_y();
			return self;
		};
		scale_squish			= function(_scale) {
			__.IB.scale.factor.current.value *= _scale;
			return self;
		};
		scale_squish_x			= function(_scale_x) {
			__.IB.scale.factor_x.current.value *= _scale_x;
			return self;
		};
		scale_squish_y			= function(_scale_y) {
			__.IB.scale.factor_y.current.value *= _scale_y;
			return self;
		};
		scale_snap				= function(_scale = scale_get_lerp_target()) {
			__.IB.scale.factor.current.value = _scale;
			__.IB.scale.factor.target.value  = _scale;
			return self;
		};
		scale_snap_x			= function(_scale_x = scale_get_x_lerp_target()) {
			__.IB.scale.factor_x.current.value = _scale_x;
			__.IB.scale.factor_x.target.value  = _scale_x;
			image_xscale					   = _scale_x;
			return self;
		};
		scale_snap_y			= function(_scale_y = scale_get_y_lerp_target()) {
			__.IB.scale.factor_y.current.value = _scale_y;
			__.IB.scale.factor_y.target.value  = _scale_y;
			image_yscale					   = _scale_y;
			return self;
		};
		
		// private
		with (__.IB) {
			scale = {};
			with (scale) {
				update	 =  method(_self, function() {
					if (__.IB.scale.factor.current.value 
					!=	__.IB.scale.factor.target.value
					) { 
						__.IB.scale.factor.current.value = lerp(
							__.IB.scale.factor.current.value, 
							__.IB.scale.factor.target.value, 
							__.IB.scale.factor.target.speed.value
						);
					}
					if (__.IB.scale.factor_x.current.value 
					!=	__.IB.scale.factor_x.target.value
					) { 
						__.IB.scale.factor_x.current.value = lerp(
							__.IB.scale.factor_x.current.value, 
							__.IB.scale.factor_x.target.value, 
							__.IB.scale.factor_x.target.speed.value
						);
					}
					if (__.IB.scale.factor_y.current.value 
					!=	__.IB.scale.factor_y.target.value
					) { 
						__.IB.scale.factor_y.current.value = lerp(
							__.IB.scale.factor_y.current.value, 
							__.IB.scale.factor_y.target.value, 
							__.IB.scale.factor_y.target.speed.value
						);
					}
					image_xscale = __.IB.scale.factor_x.current.value * __.IB.scale.factor.current.value;
					image_yscale = __.IB.scale.factor_y.current.value * __.IB.scale.factor.current.value;
				});
				facing	 = _config.facing;
				factor	 =  {
					current: {
						value: _config.scale,
					},
					target:  {
						value: _config.scale_lerp_target,
						speed: {
							value: _config.scale_lerp_speed,
							start: _config.scale_lerp_speed,
						},
					},
				};
				factor_x =  {
					current: {
						value: _config.scale_x_start,
					},
					target:  {
						value: _config.scale_x_lerp_target,
						speed: {
							value: _config.scale_x_lerp_speed,
							start: _config.scale_x_lerp_speed,
						},
					},
				};
				factor_y =  {
					current: {
						value: _config.scale_y_start,
					},
					target:  {
						value: _config.scale_y_lerp_target,
						speed: {
							value: _config.scale_y_lerp_speed,
							start: _config.scale_y_lerp_speed,
						},
					},
				};
			};
		};
		
		// events
		on_initialize(function() {
			image_xscale = scale_get_x();
			image_yscale = scale_get_y();
		});
		on_update	 (function() {
			__.IB.scale.update();
		});
	};
	function IB_Behavior_Position() {
		
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Lifecycle();
		_IB_Behavior_Ensure_Update();
		_IB_Behavior_Ensure_Sprite();

		////////////////////////////
	
		var _self	= self;
		var _config = { 
			x_start:	   (_self[$ "x_start"	   ] ?? _self[$ "x"]) ?? 0,
			x:			    _self[$ "x"			   ] ??  0,
			x_lerp_target: (_self[$ "x_lerp_target"] ?? _self[$ "x"]) ?? 0,
			x_lerp_speed:   _self[$ "x_lerp_speed" ] ??  0.25,
			y_start:	   (_self[$ "y_start"	   ] ?? _self[$ "y"]) ?? 0,
			y:			    _self[$ "y"			   ] ??  0,
			y_lerp_target: (_self[$ "y_lerp_target"] ?? _self[$ "y"]) ?? 0,
			y_lerp_speed:   _self[$ "y_lerp_speed" ] ??  0.25,
		};
		
		// public
		position_get_x				= function() {
			return __.IB.position.x.current.value;
		};
		position_get_x_start		= function() {
			return __.IB.position.x.start.value;
		};
		position_get_x_lerp_target	= function() {
			return __.IB.position.x.target.value;
		};
		position_get_x_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.IB.position.x.target.speed.start;		
			}
			return __.IB.position.x.target.speed.value;	
		};
		position_get_y				= function() {
			return __.IB.position.y.current.value;
		};
		position_get_y_start		= function() {
			return __.IB.position.y.start.value;
		};
		position_get_y_lerp_target	= function() {
			return __.IB.position.y.target.value;
		};
		position_get_y_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.IB.position.y.target.speed.start;		
			}
			return __.IB.position.y.target.speed.value;	
		};

		position_get_bottom			= function() {
			return position_get_y() + (sprite_get_sprite_height() * 0.5);
		};
		position_get_center_x		= function() {
			return position_get_left() + (sprite_get_sprite_width() * 0.5);
		};
		position_get_center_y		= function() {
			return position_get_top() + (sprite_get_sprite_height() * 0.5);
		};
		position_get_left			= function() {
			return position_get_x() - (sprite_get_sprite_width() * 0.5);
		};
		position_get_right			= function() {
			return position_get_x() + (sprite_get_sprite_width() * 0.5);
		};
		position_get_top			= function() {
			return position_get_y() - (sprite_get_sprite_height() * 0.5);
		};
		
		position_set_x				= function(_x, _lerp_movement = false, _lerp_speed = position_get_x_lerp_speed(true)) {
			position_set_x_lerp_target(_x, _lerp_speed);
			if (!_lerp_movement) position_snap_x();
			return self;
		};
		position_set_x_start		= function(_x_start) {
			__.IB.position.x.start.value = _x_start;
			return self;
		};
		position_set_x_lerp_target	= function(_x_target, _x_speed = position_get_x_lerp_speed(true)) {
			__.IB.position.x.target.value = _x_target;
			position_set_x_lerp_speed(_x_speed, false);
			return self;
		};
		position_set_x_lerp_speed	= function(_x_speed, _update_start = true) {
			__.IB.position.x.target.speed.value = _x_speed;
			if (_update_start) {
				__.IB.position.x.target.speed.start = _x_speed;
			}
			return self;
		};
		position_set_y				= function(_y, _lerp_movement = false, _lerp_speed = position_get_y_lerp_speed(true)) {
			position_set_y_lerp_target(_y, _lerp_speed);
			if (!_lerp_movement) position_snap_y();
			return self;
		};
		position_set_y_start		= function(_y_start) {
			__.IB.position.y.start.value = _y_start;
			return self;
		};
		position_set_y_lerp_target	= function(_y_target, _y_speed = position_get_y_lerp_speed(true)) {
			__.IB.position.y.target.value = _y_target;
			position_set_y_lerp_speed(_y_speed, false);
			return self;
		};	
		position_set_y_lerp_speed	= function(_y_speed, _update_start = true) {
			__.IB.position.y.target.speed.value = _y_speed;
			if (_update_start) {
				__.IB.position.y.target.speed.start = _y_speed;
			}
			return self;
		};
			
		position_adjust_x			= function(_amount, _lerp_movement = false, _lerp_speed = position_get_x_lerp_speed(true)) {
			position_set_x(position_get_x() + _amount, _lerp_movement, _lerp_speed);
			return self;
		};
		position_adjust_y			= function(_amount, _lerp_movement = false, _lerp_speed = position_get_y_lerp_speed(true)) {
			position_set_y(position_get_y(false) + _amount, _lerp_movement, _lerp_speed);
			return self;
		};
		position_snap_x				= function(_x_target = position_get_x_lerp_target()) {
			__.IB.position.x.current.value = _x_target;
			__.IB.position.x.target.value  = _x_target;
			__.IB.position.x.update_lerp();
			return self;
		};
		position_snap_y				= function(_y_target = position_get_y_lerp_target(false)) {
			__.IB.position.y.current.value = _y_target;
			__.IB.position.y.target.value  = _y_target;
			__.IB.position.y.update_lerp();
			return self;
		};
		
		// private
		with (__.IB) {
			position = {};
			with (position) {
				update_on_step_begin = false;
				update_on_step		 = true;
				update_on_step_end	 = false;
				x					 = {
					update_lerp: method(_self, function() {
						if (__.IB.position.x.current.value
						!=  __.IB.position.x.target.value
						) { 
							__.IB.position.x.current.value = lerp(
								__.IB.position.x.current.value, 
								__.IB.position.x.target.value, 
								__.IB.position.x.target.speed.value
							);
						}
						x = __.IB.position.x.current.value;
					}),
					start:		 {
						value: _config.x_start,
					},
					current:	 {
						value: _config.x
					},
					target:		 {
						value: _config.x_lerp_target,
						speed: {
							value: _config.x_lerp_speed,
							start: _config.x_lerp_speed,
						},
					},
				};
				y					 = {
					update_lerp: method(_self, function() {
						if (__.IB.position.y.current.value
						!=	__.IB.position.y.target.value
						) { 
							__.IB.position.y.current.value = lerp(
								__.IB.position.y.current.value, 
								__.IB.position.y.target.value, 
								__.IB.position.y.target.speed.value
							);
						}
						y = __.IB.position.y.current.value;
					}),
					start:		 {
						value: _config.y_start,
					},
					current:	 {
						value: _config.y,
					},
					target:		 {
						value: _config.y_lerp_target,
						speed: {
							value: _config.y_lerp_speed,
							start: _config.y_lerp_speed,
						},
					},
				};
			};
		};
		
		// events
		on_initialize  (function() {
			x = position_get_x();
			y = position_get_y();
		});
		on_update_begin(function() {
			if (__.IB.position.update_on_step_begin) {
				__.IB.position.x.update_lerp();
				__.IB.position.y.update_lerp();
			}
		});
		on_update	   (function() {
			if (__.IB.position.update_on_step) {
				__.IB.position.x.update_lerp();
				__.IB.position.y.update_lerp();
			}
		});
		on_update_end  (function() {
			if (__.IB.position.update_on_step_end) {
				__.IB.position.x.update_lerp();
				__.IB.position.y.update_lerp();
			}
		});
	};
	function IB_Behavior_Zaxis() {
		
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Update();
		_IB_Behavior_Ensure_Sprite();
		_IB_Behavior_Ensure_Position();

		////////////////////////////
	
		var _self	= self;
		var _config = { 
			z_start:	   (_self[$ "z_start"	   ] ?? _self[$ "z"]) ?? 0,
			z:			    _self[$ "z"			   ] ??  0,
			z_lerp_target: (_self[$ "z_lerp_target"] ?? _self[$ "z"]) ?? 0,
			z_lerp_speed:   _self[$ "z_lerp_speed" ] ??  0.25,
		};
		
		// public
		position_get_y				= function(_apply_z_position = true) { /// @override
			if (_apply_z_position) {
				return __.IB.position.y.current.value + position_get_z();	
			}
			return __.IB.position.y.current.value;
		};
		position_get_y_lerp_target	= function(_apply_z_position = true) { /// @override
			if (_apply_z_position) {
				return __.IB.position.y.target.value - position_get_z();	
			}
			return __.IB.position.y.target.value;
		};
		position_get_z				= function() {
			return __.IB.position.z.current.value;
		};
		position_get_z_start		= function() {
			return __.IB.position.z.start.value;
		};
		position_get_z_lerp_target	= function() {
			return __.IB.position.z.target.value;
		};
		position_get_z_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.IB.position.z.target.speed.start;		
			}
			return __.IB.position.z.target.speed.value;	
		};
		position_get_z_grounded		= function() {
			return __.IB.position.z.grounded;
		};
		position_get_z_burried		= function() {
			return __.IB.position.z.burried;
		};
		position_get_z_underground	= function() {
			return __.IB.position.z.underground;
		};
		position_get_z_levitating	= function() {
			return __.IB.position.z.levitating;
		};

		position_get_bottom			= function(_apply_z_position = true) { /// @override
			return position_get_y(_apply_z_position) + (sprite_get_sprite_height() * 0.5);
		};
		position_get_center_y		= function(_apply_z_position = true) { /// @override
			return position_get_top(_apply_z_position) + (sprite_get_sprite_height() * 0.5);
		};
		position_get_top			= function(_apply_z_position = true) { /// @override
			return position_get_y(_apply_z_position) - (sprite_get_sprite_height() * 0.5);
		};
		
		position_set_z				= function(_z, _lerp_movement = false, _lerp_speed = position_get_z_lerp_speed(true)) {
			position_set_z_lerp_target(_z, _lerp_speed);
			if (!_lerp_movement) position_snap_z();
			return self;
		};
		position_set_z_start		= function(_z_start) {
			__.IB.position.z.start.value = _z_start;
			return self;
		};
		position_set_z_lerp_target	= function(_z_target, _z_speed = position_get_z_lerp_speed(true)) {
			__.IB.position.z.target.value = _z_target;
			position_set_z_lerp_speed(_z_speed, false);
			return self;
		};	
		position_set_z_lerp_speed	= function(_z_speed, _update_start = true) {
			__.IB.position.z.target.speed.value = _z_speed;
			if (_update_start) {
				__.IB.position.z.target.speed.start = _z_speed;
			}
			return self;
		};
			
		position_adjust_z			= function(_amount, _lerp_movement = false, _lerp_speed = position_get_z_lerp_speed(true)) {
			position_set_z(position_get_z() + _amount, _lerp_movement, _lerp_speed);
			return self;
		};
		position_snap_z				= function(_z_target = position_get_z_lerp_target()) {
			__.IB.position.z.current.value = _z_target;
			__.IB.position.z.target.value  = _z_target;
			__.IB.position.z.update_lerp();
			return self;
		};
		
		// private
		with (__.IB.position) {
			z = {};
			with (z) {
				update_lerp			 = method(_self, function() {
					if (__.IB.position.z.current.value
					!=	__.IB.position.z.target.value
					) { 
						__.IB.position.z.current.value = lerp(
							__.IB.position.z.current.value, 
							__.IB.position.z.target.value, 
							__.IB.position.z.target.speed.value
						);
					}
				});
				update_ground_flags  = method(_self, function() {
					var _z = __.IB.position.z.current.value;
					if (_z == 0) {
						__.IB.position.z.grounded	 = true;
						__.IB.position.z.burried	 = false;
						__.IB.position.z.underground = false;
						__.IB.position.z.levitating  = false;
					}
					else if (_z < 0) {
						__.IB.position.z.grounded	 = false;
						__.IB.position.z.burried	 = false;
						__.IB.position.z.underground = false;
						__.IB.position.z.levitating  = true;
					}
					else if (_z > 0) {
						__.IB.position.z.grounded	 = true;
						__.IB.position.z.burried	 = true;
						__.IB.position.z.underground = false;
						__.IB.position.z.levitating  = false;
						
						if (_z > sprite_get_sprite_height()) {
							__.IB.position.z.underground = true;	
						}
					}
				});
				start				 = {
					value: _config.z_start,
				};
				current				 = {
					value: _config.z,
				};
				target				 = {
					value: _config.z_lerp_target,
					speed: {
						value: _config.z_lerp_speed,
						start: _config.z_lerp_speed,
					},
				};
				grounded			 = true;
				burried				 = false;
				underground			 = false;
				levitating			 = false;
			};
		};
		
		// events
		on_update_begin(function() {
			if (__.IB.position.update_on_step_begin) {
				__.IB.position.z.update_lerp();
				__.IB.position.z.update_ground_flags();
			}
		});
		on_update	   (function() {
			if (__.IB.position.update_on_step) {
				__.IB.position.z.update_lerp();
				__.IB.position.z.update_ground_flags();
			}
		});
		on_update_end  (function() {
			if (__.IB.position.update_on_step_end) {
				__.IB.position.z.update_lerp();
				__.IB.position.z.update_ground_flags();
			}
		});
	
	};
	function IB_Behavior_Angle() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Update();
		
		////////////////////////////
		
		var _self	= self;
		var _config = {
			angle: _self[$ "angle"] ?? _self.image_angle,
		};
		
		// public
		angle_get = function() {
			return image_angle;
		};
		angle_set = function(_angle) {
			__.IB.angle.value = _angle;
			image_angle		  = _angle;
			return self;
		};
		
		// private
		with (__.IB) {
			angle = {};
			with (angle) {
				update =  method(_self, function() {
					// angle lerping here ...
				});
				value  = _config.angle;
			};
		};
		
		// events
		on_update(function() {
			__.IB.angle.update();
		});
	};
	function IB_Behavior_Color() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		
		////////////////////////////
		
		var _self	= self;
		var _config = {
			color: _self[$ "color"] ?? _self.image_blend,
		};
		
		// public
		color_get = function() {
			return image_blend;
		};
		color_set = function(_color) {
			__.IB.color.value = _color;
			image_blend		  = _color;
			return self;
		};
		
		// private
		with (__.IB) {
			color = {};
			with (color) {
				value = _config.color;
			};
		};
	};
	function IB_Behavior_Alpha() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		_IB_Behavior_Ensure_Update();
		
		////////////////////////////
		
		var _self	= self;
		var _config = {
			alpha: _self[$ "alpha"] ?? _self.image_alpha,
		};
		
		// public
		alpha_get = function() {
			return image_alpha;
		};
		alpha_set = function(_alpha) {
			__.IB.alpha.value = _alpha;
			image_alpha		  = _alpha;
			return self;
		};
		
		// private
		with (__.IB) {
			alpha = {};
			with (alpha) {
				update =  method(_self, function() {
					// alpha lerping here ...
				});
				value  = _config.alpha;
			};
		};
	
		// events
		on_update(function() {
			__.IB.alpha.update();
		});
	};
	function IB_Behavior_Depth() {
	
		////////////////////////////

		_IB_Behavior_Ensure_Core();
		
		////////////////////////////
		
		var _self	= self;
		var _config = {
			depth: _self[$ "depth"] ?? _self.depth,
		};
		
		// public
		depth_get = function() {
			return depth;
		};
		depth_set = function(_depth) {
			__.IB.depth.value = _depth;
			depth			  = _depth;
			return self;
		};
		
		// private
		with (__.IB) {
			depth = {};
			with (depth) {
				value = _config.depth;
			};
		};
	};	
	
	////////////////////////////////////////////
	
	function _IB_Behavior_Validate(_behavior = undefined) {
		
		if (self[$ "__"] == undefined) return false;
		if (__[$ "IB"]	 == undefined) return false;
		
		if (_behavior != undefined) {
			return __.IB[$ _behavior] != undefined;
		}
		
		return true;
		
	};
	function _IB_Behavior_Ensure_Core() {
		if (!_IB_Behavior_Validate("core")) {
			  IB_Behavior_Core();	
		}
	};
	function _IB_Behavior_Ensure_Lifecycle() {
		if (!_IB_Behavior_Validate("lifecycle")) {
			  IB_Behavior_Lifecycle();	
		}
	};
	function _IB_Behavior_Ensure_Update() {
		if (!_IB_Behavior_Validate("update")) {
			  IB_Behavior_Update();	
		}
	};
	function _IB_Behavior_Ensure_Render() {
		if (!_IB_Behavior_Validate("render")) {
			  IB_Behavior_Render();	
		}
	};
	function _IB_Behavior_Ensure_Render_Ext() {
		if (!_IB_Behavior_Validate("render_ext")) {
			  IB_Behavior_Render_Ext();	
		}
	};
	function _IB_Behavior_Ensure_Room() {
		if (!_IB_Behavior_Validate("rooms")) {
			  IB_Behavior_Room();	
		}
	};
	function _IB_Behavior_Ensure_Sprite() {
		if (!_IB_Behavior_Validate("sprite")) {
			  IB_Behavior_Sprite();	
		}
	};
	function _IB_Behavior_Ensure_Scale() {
		if (!_IB_Behavior_Validate("scale")) {
			  IB_Behavior_Scale();	
		}
	};
	function _IB_Behavior_Ensure_Position() {
		if (!_IB_Behavior_Validate("position")) {
			  IB_Behavior_Position();	
		}
	};
	function _IB_Behavior_Ensure_Zaxis() {
		if (!_IB_Behavior_Validate("position")
		||	__.IB.position[$ "z"] == undefined
		) {
			IB_Behavior_Zaxis();	
		}
	};
	function _IB_Behavior_Ensure_Angle() {
		if (!_IB_Behavior_Validate("angle")) {
			  IB_Behavior_Angle();	
		}
	};
	function _IB_Behavior_Ensure_Color() {
		if (!_IB_Behavior_Validate("color")) {
			  IB_Behavior_Color();	
		}
	};
	function _IB_Behavior_Ensure_Alpha() {
		if (!_IB_Behavior_Validate("alpha")) {
			  IB_Behavior_Alpha();	
		}
	};
	function _IB_Behavior_Ensure_Depth() {
		if (!_IB_Behavior_Validate("depth")) {
			  IB_Behavior_Depth();	
		}
	};
	
	