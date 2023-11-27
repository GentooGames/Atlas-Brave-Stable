
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __       ______   ______   _____    //
	// /\ \     /\  __ \ /\  __ \ /\  __-.  //
	// \ \ \____\ \ \/\ \\ \  __ \\ \ \/\ \ //
	//  \ \_____\\ \_____\\ \_\ \_\\ \____- //
	//   \/_____/ \/_____/ \/_/\/_/ \/____/ //
	//                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_ProfileLoad(_config = {}) : PlayerPanelPage(_config) constructor {
		
		var _self = self; 
		
		// private
		with (__) {
			static __profiles_load_all = function() {
				
				// clear all previously loaded
				__.profiles.item_clear_all();
					
				// load profile names into array
				var _file_type = PLAYER_PROFILE_FILE_TYPE;
				var _path	   = PLAYER_PROFILE_FILE_DIR + "/*" + _file_type;
								 
				////////////////////////////////
								 
				var _file_name = file_find_first(_path, 0);
				while (_file_name != "") {
					
					// trim file type
					var _file_type_length = string_length(_file_type);
					var _file_name_length = string_length(_file_name);
					var _profile_name	  = string_delete(_file_name, _file_name_length - (_file_type_length - 1), _file_name_length);
					
					__.profiles.item_new(IB_UI_MenuListEntry_Text, {
						text:		   _profile_name,
						callback:	    method(self, function(_profile_name) {
							__profile_select(_profile_name);
						}),
						callback_data: _profile_name,
					});
					_file_name = file_find_next();
				};
				file_find_close();
			};
			static __profile_select    = function(_profile_name) {
				
				var _player	= __get_player();
				_player.profile_load(_profile_name);
							
				// change panel page
				__.panel.page_change("character_select");
			};
				
			profiles = new IB_UI_MenuList({
				x:		 0,
				y:		 0,
				width:  _self.size_get_width(),
				height: _self.size_get_height(),
			});
			
			// state
			state.fsm.add_child("__", "load", {
				enter: function() {
					__.state.fsm.inherit();
					__profiles_load_all();
					__.profiles.cursor_set_index(0);
					__.profiles.cursor_snap_position();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					// player input
					var _player = __get_player();
					if (_player.input_back_pressed())	{
						__.panel.audio_play(sfx_navigate);
						__.panel.page_change("profile_setup");	
					}
					if (_player.input_down_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.profiles.cursor_move_down();
					}
					if (_player.input_up_pressed())	{
						__.panel.audio_play(sfx_navigate);
						__.profiles.cursor_move_up();
					}
					if (_player.input_select_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.profiles.cursor_select();
					}
						
					__.profiles.update();
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					
					if (__.profiles.item_get_count() > 0) {
						__.profiles.render();
					}
					else {
						draw_set_halign(fa_center);	
						draw_set_valign(fa_center);	
						
						draw_text(
							size_get_width () * 0.5,
							size_get_height() * 0.5,
							"no profiles",
						);
						
						draw_set_halign(fa_left);	
						draw_set_valign(fa_top);	
					}
					
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();		
					__.profiles.cursor_snap_position();
				},
			});	
		};
			
		// events
		on_initialize(function() {
			__.profiles.initialize();
			__.state.fsm.change("load");
		});
		on_activate  (function() {
			__.state.fsm.change("load");
		});
		on_cleanup	 (function() {
			__.profiles.cleanup();
		});
	};
	
	