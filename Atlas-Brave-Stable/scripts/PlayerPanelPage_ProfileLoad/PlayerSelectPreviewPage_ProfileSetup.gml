
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \ /\  ___\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \\ \  __\\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_\   \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/ \/_/    \/_/ \/_____/ \/_____/ //
	//                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerSelectPreviewPage_ProfileSetup(_config = {}) : PlayerSelectPreviewPage(_config) constructor {

		var _self = self;
		
		// private <<<<<<<<<<<<<<<<<
		with (__) {
			static __get_player = function() {
				return __.preview.get_player();
			};
			
			profile_begin  = {
				cursor:  {
					index:    0,
					height:   string_height("A"),
					y:		  undefined,
					y_target: undefined,
					y_speed:  0.25,
					lerp_y:   method(_self, function() {
						__.profile_begin.cursor.y  = lerp(
							__.profile_begin.cursor.y, 
							__.profile_begin.cursor.y_target, 
							__.profile_begin.cursor.y_speed,
						);
					}),
					snap_y:   method(_self, function() {
						__.profile_begin.cursor.y = __.profile_begin.cursor.y_target;
					}),
				},
				options: {
					inserts: [
						{ // new profile
							text:	 "new profile",
							callback: method(_self, function() {
								__.state.fsm.change("profile_create");
							}),
						},
						{ // load profile
							text:	 "load profile",	
							callback: method(_self, function() {
								__.state.fsm.change("profile_load");
							}),
						},
						{ // guest
							text:	 "guest",	
							callback: method(_self, function() {
							
							}),
						},
					],
					scale: 1,
					space: 25,
					get_y: method(_self, function(_index) {
						var _y_center = get_height() * 0.5;
						var _space	  = __.profile_begin.options.space;
						var _scale	  = __.profile_begin.options.scale
						return _y_center + (_space * _scale * (_index - 1));
					}),
				},
			};
			profile_create = {
				alphabet_index: 0,
				letter_width:   string_width("A"),
				name_new:		"",
				name_prompt:	"enter name",
				name_scale:		2,
				check_exists:   method(_self, function() {
					return false;
				}),
				create:			method(_self, function() {
					// create profile
					var _player  = __get_player();
					var _profile =  _player.profile_get();
						_profile.create(__.profile_create.name_new);
						
					// change preview page
					__.preview.page_change("character_select");
				}),
			};
			profile_load   = {
				cursor:	  {
					index:    0,
					height:   string_height("A"),
					y:		  undefined,
					y_target: undefined,
					y_speed:  0.25,
					lerp_y:   method(_self, function() {
						__.profile_load.cursor.y  = lerp(
							__.profile_load.cursor.y, 
							__.profile_load.cursor.y_target, 
							__.profile_load.cursor.y_speed,
						);
					}),
					snap_y:   method(_self, function() {
						__.profile_load.cursor.y = __.profile_load.cursor.y_target;
					}),
				},
				profiles: {
					inserts: array_create(0),
					scale:   1,
					space:   25,
					load:	 method(_self, function() {
					
						// clear profiles loaded first
						__.profile_load.profiles.inserts = array_create(0);
					
						// load profile names into array
						var _path	   = GAME_DATA.save.profiles.path.prefix + "/*" +
										 GAME_DATA.save.profiles.path.filetype;
						var _file_name = file_find_first(_path, 0);

						while (_file_name != "") {
						    array_push(__.profile_load.profiles.inserts, _file_name);
						    _file_name = file_find_next();
						};
						file_find_close();
					}),
					get_y:	 method(_self, function(_index) {
						var _y_center = get_height() * 0.5;
						var _space	  = __.profile_load.profiles.space;
						var _scale	  = __.profile_load.profiles.scale
						return _y_center + (_space * _scale * (_index - 1));
					}),
					select:  method(_self, function() {
						
						// load profile
						var _profile_index = __.profile_load.cursor.index;
						var _profile_name  = __.profile_load.profiles.inserts[_profile_index];
						var _player		   = __get_player();
						var _profile	   = _player.profile_get();
						
						// trim file-type off end
						_profile_name = string_delete(
							_profile_name, 
							 string_length(_profile_name) - 4,
							 5
						);
						_profile.load(_profile_name);
							
						// change preview page
						__.preview.page_change("character_select");
					}),
				},
			};
			
			// state :::::::::::::::
			state.fsm.add_child("__", "profile_begin",  {
				enter: function() {
					__.state.fsm.inherit();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					var _player = __get_player();
					var _array  = __.profile_begin.options.inserts;
					
					// move cursor down menu
					if (_player.input_down_pressed()) {
						__.profile_begin.cursor.index = __MATH_UTIL.wrap(
							__.profile_begin.cursor.index + 1,
							0,
							array_length(_array) - 1
						);
					}
					
					// move cursor up menu
					if (_player.input_up_pressed()) {
						__.profile_begin.cursor.index = __MATH_UTIL.wrap(
							__.profile_begin.cursor.index - 1,
							0,
							array_length(_array) - 1
						);
					}
						
					// select cursor
					if (_player.input_select_pressed()) {
						var _index	= __.profile_begin.cursor.index;
						var _option = __.profile_begin.options.inserts[_index];
							_option.callback();
					}
						
					// update cursor target position
					__.profile_begin.cursor.y_target = __.profile_begin.options.get_y(__.profile_begin.cursor.index);
					
					// update cursor position
					if ( __.profile_begin.cursor.y != undefined) {
						 __.profile_begin.cursor.lerp_y();
					}
					else __.profile_begin.cursor.snap_y();
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					__render_player_index(,": " + __.state.name);
					
					#region text options :::::::::::::::
					
					draw_set_halign(fa_center);
					draw_set_valign(fa_center);
					
					for (var _i = 0, _len = array_length(__.profile_begin.options.inserts); _i < _len; _i++) {
						var _option = __.profile_begin.options.inserts[_i];
						draw_text_transformed(
							   get_width() * 0.5, 
							__.profile_begin.options.get_y(_i),
							  _option.text, 
							__.profile_begin.options.scale, 
							__.profile_begin.options.scale, 
							   0,
						);	
					};
					
					draw_set_halign(fa_left);
					draw_set_valign(fa_top);
					
					#endregion
					#region cursor :::::::::::::::::::::
					
					var _cursor_height = __.profile_begin.cursor.height;
					
					if (__.profile_begin.cursor.y != undefined) {
						draw_rectangle(
							 0, 
						  __.profile_begin.cursor.y - (_cursor_height * 0.5), 
							 get_width(), 
						  __.profile_begin.cursor.y + (_cursor_height * 0.5), 
							 true
						);
					}
					
					#endregion
					
					__render_surface_end();
					__render_frame();
				},
				leave: function() {
					__.state.fsm.inherit();
					__.profile_begin.cursor.snap_y();
				},
			});
			state.fsm.add_child("__", "profile_create", {
				enter: function() {
					__.state.fsm.inherit();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					var _player = __get_player();
					
					// move alphabet index right
					if (_player.input_right_pressed()) {
						__.profile_create.alphabet_index = __MATH_UTIL.wrap(
							__.profile_create.alphabet_index + 1,
							0,
							26 + 10 - 1
						);
					}
					
					// move alphabet index left
					if (_player.input_left_pressed()) {
						__.profile_create.alphabet_index = __MATH_UTIL.wrap(
							__.profile_create.alphabet_index - 1,
							0,
							26 + 10 - 1
						);
					}
					
					// add new letter
					if (_player.input_select_pressed()) {
						__.profile_create.name_new += __TEXT_UTIL.get_alphanumeric(__.profile_create.alphabet_index);
					}
					
					// enter pressed
					if (_player.input_options_pressed()) {
						// profile already exists
						if (__.profile_create.check_exists()) {
							// ...
						}
						// profile does not exist
						else {
							__.profile_create.create();
						}
					}
					
					// back pressed
					if (_player.input_back_pressed()) {
						// return to previous page
						if (string_length(__.profile_create.name_new) == 0) {
							__.state.fsm.change("profile_begin");	
						}
						// delete character
						else {
							__.profile_create.name_new = __TEXT_UTIL.delete_last(__.profile_create.name_new);
						}
					}
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					__render_player_index(,": " + __.state.name);
					
					var _width  = get_width ();
					var _height = get_height();
					
					// profile name construction
					draw_set_halign(fa_center);
					draw_set_valign(fa_center);
					
					// prompt name :::::::::::::
					if (string_length(__.profile_create.name_new) == 0) {
						var _color = c_dkgray;
						draw_text_transformed_color(
							_width  * 0.50, 
							_height * 0.25, 
						  __.profile_create.name_prompt, 
						  __.profile_create.name_scale,
						  __.profile_create.name_scale,
						     0,
							_color, 
							_color, 
							_color, 
							_color, 
							 1
						);
					}
					
					// new name ::::::::::::::::
					else {
						draw_text_transformed(
							_width  * 0.50, 
							_height * 0.25, 
						  __.profile_create.name_new,
						  __.profile_create.name_scale, 
						  __.profile_create.name_scale, 
						     0,
						);	
					}
					
					draw_set_halign(fa_left);
					draw_set_valign(fa_top );
					
					// alphabet ::::::::::::::::
					var _center_x = get_width () * 0.5;
					var _center_y = get_height() * 0.5;
					var _scale	  = 3;
					var _space	  = __.profile_create.letter_width * _scale;
					
					for (var _i = 0; _i < 26 + 10; _i++) {
						var _letter  = __TEXT_UTIL.get_alphanumeric(_i);
						var _current = _i == __.profile_create.alphabet_index;
						var _color   = _current ? c_white : c_dkgray;
						draw_text_transformed_color(
							_center_x + ((_i - __.profile_create.alphabet_index) * _space), 
							_center_y, 
							_letter,
							_scale, 
							_scale,
							 0,
							_color,
							_color,
							_color,
							_color,
							 1,
						);
						if (_current) {
							draw_text_transformed(
								_center_x + ((_i - __.profile_create.alphabet_index) * _space), 
								_center_y + 10, 
								"_",
								_scale, 
								_scale,
								 0,
							);
						}
					};
					
					__render_surface_end();
					__render_frame();
				},
			});
			state.fsm.add_child("__", "profile_load",   {
				enter: function() {
					__.state.fsm.inherit();
					__.profile_load.profiles.load();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					var _player = __get_player();
					var _array  = __.profile_load.profiles.inserts;
					
					// move cursor down menu
					if (_player.input_down_pressed()) {
						__.profile_load.cursor.index = __MATH_UTIL.wrap(
							__.profile_load.cursor.index + 1,
							0,
							array_length(_array) - 1
						);
					}
					
					// move cursor up menu
					if (_player.input_up_pressed()) {
						__.profile_load.cursor.index = __MATH_UTIL.wrap(
							__.profile_load.cursor.index - 1,
							0,
							array_length(_array) - 1
						);
					}
						
					// select cursor
					if (_player.input_select_pressed()) {
						__.profile_load.profiles.select();
					}
					
					// return to previous page
					if (_player.input_back_pressed()) {
						__.state.fsm.change("profile_begin");	
					}
						
					// update cursor target position
					__.profile_load.cursor.y_target = __.profile_load.profiles.get_y(__.profile_load.cursor.index);
					
					// update cursor position
					if ( __.profile_load.cursor.y != undefined) {
						 __.profile_load.cursor.lerp_y();
					}
					else __.profile_load.cursor.snap_y();
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					__render_player_index(,": " + __.state.name);
					
					draw_set_halign(fa_center);
					draw_set_valign(fa_center);
					
					var _n_profiles  = array_length(__.profile_load.profiles.inserts);
					if (_n_profiles == 0) {
						draw_text(get_width() * 0.5, get_height() * 0.5, "no profiles");	
					}
					else {
						#region text options :::::::::::::::
					
						for (var _i = 0, _len = _n_profiles; _i < _len; _i++) {
							var _profile_name = __.profile_load.profiles.inserts[_i];
							var _string_index = string_length(_profile_name) - 4;
							var _name_trimmed = string_delete(_profile_name, _string_index, 5); 
							draw_text_transformed(
								get_width() * 0.5,
							 __.profile_load.profiles.get_y(_i),
							   _name_trimmed,
							 __.profile_load.profiles.scale,
							 __.profile_load.profiles.scale,
								0,
							);
						};
					
						#endregion
						#region cursor :::::::::::::::::::::
					
						var _cursor_height = __.profile_load.cursor.height;
					
						if (__.profile_load.cursor.y != undefined) {
							draw_rectangle(
									0, 
								__.profile_load.cursor.y - (_cursor_height * 0.5), 
									get_width(), 
								__.profile_load.cursor.y + (_cursor_height * 0.5), 
									true
							);
						}
					
						#endregion	
					}
					
					draw_set_halign(fa_left);
					draw_set_valign(fa_top );
					
					__render_surface_end();
					__render_frame();
				},
			});
			
			// events ::::::::::::::
			_self.on_initialize(method(_self, function() {
				__.state.fsm.change("profile_begin");
			}));
		};
	};
	