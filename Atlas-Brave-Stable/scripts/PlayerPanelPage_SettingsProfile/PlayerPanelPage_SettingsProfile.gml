
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \ /\  ___\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \\ \  __\\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_\   \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/ \/_/    \/_/ \/_____/ \/_____/ //
	//                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_SettingsProfile(_config = {}) : PlayerPanelPage(_config) constructor {
		
		var _self = self;
		
		// private
		with (__) {
			options = new IB_UI_MenuList({
				x:		 0,
				y:		 0,
				width:  _self.size_get_width(),
				height: _self.size_get_height(),
			});
			options.item_new(IB_UI_MenuListEntry_Text, {
				color:	  c_white,
				text:	 "edit name",
				callback: method(_self, function() {
					__.panel.page_change("settings_profile_rename");
				}),
			});
			options.item_new(IB_UI_MenuListEntry_Text, {
				color:	  c_white,
				text:	 "delete profile",
				callback: method(_self, function() {
					var _player  = __get_player();
					var _profile =  _player.profile_get();
						_profile.delete_from_disk();
					__.panel.page_change("profile_setup");
				}),
			});
			options.item_new(IB_UI_MenuListEntry_Text, {
				color:	  c_white,
				text:	 "back",
				callback: method(_self, function() {
					__.panel.page_change("settings");
				}),
			});
			
			// state
			state.fsm.add_child("__", "profile", {
				enter: function() {
					__.state.fsm.inherit();
					__.options.cursor_set_index(0);
					__.options.cursor_snap_position();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					// player input
					var _player = __get_player();
					
					if (_player.input_back_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.panel.page_change("settings");
					}
					if (_player.input_down_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.options.cursor_move_down();
					}
					if (_player.input_up_pressed())	{
						__.panel.audio_play(sfx_navigate);
						__.options.cursor_move_up();
					}
					if (_player.input_select_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.options.cursor_select();
					}
					
					__.options.update();
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					__.options.render();
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();
					__.options.cursor_snap_position();
				},
			});
		};
		
		// events
		on_initialize(function() {
			__.options.initialize();
			__.state.fsm.change("profile");
		});
		on_activate  (function() {
			__.state.fsm.change("profile");
		});
		on_cleanup	 (function() {
			__.options.cleanup();
		});
	};
	
	