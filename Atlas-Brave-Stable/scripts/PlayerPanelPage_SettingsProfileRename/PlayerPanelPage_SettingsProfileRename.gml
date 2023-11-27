
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __   ______   __    __   ______    //
	// /\  == \ /\  ___\ /\ "-.\ \ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \  __< \ \  __\ \ \ \-.  \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_\ \_\\ \_____\\ \_\\"\_\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_/ /_/ \/_____/ \/_/ \/_/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_SettingsProfileRename(_config = {}) : PlayerPanelPage_AlphabetInput(_config) constructor {
		
		var _self = self;
		
		// private
		with (__) {
			static __profile_name_valid = function(_profile_name) {
				return (_profile_name != undefined
					&&	 string_length(_profile_name) > 0
				);	
			};
			
			options = new IB_UI_MenuList({
				x:				   0,
				y:				   60,
				width:			  _self.size_get_width(),
				height:			  _self.size_get_height(),
				cursor_wrap_index: false,
			});
			options.item_new(IB_UI_MenuListEntry_Text, { // empty
				text:	 "",
				callback: method(_self, function() {}),
			});
			options.item_new(IB_UI_MenuListEntry_Text, { // confirm
				text:	 "confirm",
				callback: method(_self, function() {
					if (__profile_name_valid(__.input)) {
						var _player  = __get_player();
						var _profile = _player.profile_get();
						_profile.rename(__.input);
						__.panel.page_change("settings_profile");	
					}
				}),
			});
			options.item_new(IB_UI_MenuListEntry_Text, { // back
				text:	 "back",
				callback: method(_self, function() {
					__.panel.page_change("settings_profile");
				}),
			});
			
			// state
			state.fsm.add_child("type", "rename", {
				enter: function() {
					__.state.fsm.inherit();
					__.options.cursor_set_visible(false);
					__.options.cursor_set_index(0);
					set_editing_letters(true);
				},
				step:  function() {
					__.state.fsm.inherit();
					
					var _player = __get_player();
					
					// editing letters
					if (is_editing_letters()) {
						if (_player.input_down_pressed () 
						||	_player.input_back_pressed ()
						||	_player.input_start_pressed()
						) {
							set_editing_letters(false);	
							__.options.cursor_set_visible(true);
							__.options.cursor_move_down();
							__.panel.audio_play(sfx_navigate);
						};
					}
					
					// not editing letters
					else {
						// start editing letters
						if (_player.input_up_pressed() && __.options.cursor_get_index() == 1) {
							set_editing_letters(true);	
							__.options.cursor_move_up();
							__.options.cursor_set_visible(false);
							__.panel.audio_play(sfx_navigate);
						}
							
						// interact with cursor
						if (_player.input_up_pressed())	{
							__.panel.audio_play(sfx_navigate);
							__.options.cursor_move_up();	
						}
						if (_player.input_down_pressed()) {
							__.panel.audio_play(sfx_navigate);
							__.options.cursor_move_down();	
						}
						if (_player.input_select_pressed()) {
							__.panel.audio_play(sfx_navigate);
							__.options.cursor_select();	
						}
						if (_player.input_back_pressed()) {
							__.panel.audio_play(sfx_navigate);
							__.options.cursor_move_down();
						}
					}
					
					////////////////////////
					
					__.options.update();
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					
					var _width  =  size_get_width ();
					var _height =  size_get_height();
					var _x		= _width  * 0.50;
					var _y		= _height * 0.30;
					
					// profile name construction
					draw_set_halign(fa_center);
					draw_set_valign(fa_center);
					
					// prompt input ::::::::::::
					if (get_input_length() == 0) {
						draw_input_prompt(_x, _y,, c_dkgray);
					}
					// new input::::::::::::::::
					else draw_input(_x, _y);
					
					draw_set_halign(fa_left);
					draw_set_valign(fa_top );
					
					// alphabet ::::::::::::::::
					var _x	   = size_get_width () * 0.50;
					var _y	   = size_get_height() * 0.40;
					var _scale = 3;
					var _color = is_editing_letters() ? c_white : c_gray;
					draw_alphabet(_x, _y, _scale, _color);
					
					// options :::::::::::::::::
					__.options.render();
					
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();
				},
			});
		};
		
		// events
		on_initialize(function() {
			__.options.initialize();
			__.state.fsm.change("rename");
		});
		on_activate  (function() {
			__.state.fsm.change("rename");
		});
		on_cleanup	 (function() {
			__.options.cleanup();
		});
	};
	