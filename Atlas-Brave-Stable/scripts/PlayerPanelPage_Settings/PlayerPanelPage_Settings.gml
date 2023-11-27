
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______  ______  __   __   __   ______   ______    //
	// /\  ___\ /\  ___\/\__  _\/\__  _\/\ \ /\ "-.\ \ /\  ___\ /\  ___\   //
	// \ \___  \\ \  __\\/_/\ \/\/_/\ \/\ \ \\ \ \-.  \\ \ \__ \\ \___  \  //
	//  \/\_____\\ \_____\ \ \_\   \ \_\ \ \_\\ \_\\"\_\\ \_____\\/\_____\ //
	//   \/_____/ \/_____/  \/_/    \/_/  \/_/ \/_/ \/_/ \/_____/ \/_____/ //
	//                                                                     //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_Settings(_config = {}) : PlayerPanelPage(_config) constructor {
		
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
				text:	 "input",
				callback: method(_self, function() {
					__.panel.page_change("settings_input");
				}),
			});
			options.item_new(IB_UI_MenuListEntry_Text, {
				color:	  c_white,
				text:	 "profile",
				callback: method(_self, function() {
					__.panel.page_change("settings_profile");
				}),
			});
			options.item_new(IB_UI_MenuListEntry_Text, {
				color:	  c_gray,
				text:	 "back",
				callback: method(_self, function() {
					__.panel.page_change("character_select");
				}),
			});
			
			// state
			state.fsm.add_child("__", "settings", {
				enter: function() {
					__.state.fsm.inherit();
					__.options.cursor_set_index(0);
					__.options.cursor_snap_position();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					// player input
					var _player = __get_player();
					
					// exit settings menu
					if (_player.input_options_pressed()
					||  _player.input_back_pressed()
					) {
						__.panel.audio_play(sfx_navigate);
						__.panel.page_change("character_select");
					}
					
					// navigate cursor
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
			__.state.fsm.change("settings");
		});
		on_activate  (function() {
			__.state.fsm.change("settings");
		});
		on_cleanup	 (function() {
			__.options.cleanup();
		});
	};
	
	