
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______  __  __   ______  //
	// /\  ___\ /\  ___\/\__  _\/\ \/\ \ /\  == \ //
	// \ \___  \\ \  __\\/_/\ \/\ \ \_\ \\ \  _-/ //
	//  \/\_____\\ \_____\ \ \_\ \ \_____\\ \_\   //
	//   \/_____/ \/_____/  \/_/  \/_____/ \/_/   //
	//                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_ProfileSetup(_config = {}) : PlayerPanelPage(_config) constructor {

		var _self = self;
		
		// private
		with (__) {
			options = new IB_UI_MenuList({
				x:		 0,
				y:		 0,
				width:  _self.size_get_width(),
				height: _self.size_get_height(),
			});
			options.item_new(IB_UI_MenuListEntry_Text, { // load profile
				text:	 "load profile",
				callback: method(_self, function() {
					__.panel.page_change("profile_load");
				}),
			});
			options.item_new(IB_UI_MenuListEntry_Text, { // new profile
				text:	 "new profile",
				callback: method(_self, function() {
					__.panel.page_change("profile_create");
				}),
			});
			options.item_new(IB_UI_MenuListEntry_Text, { // guest
				text:	 "guest",
				callback: method(_self, function() {}),
			});
			
			// state
			state.fsm.add_child("__", "setup", {
				enter: function() {
					__.state.fsm.inherit();
					__.options.cursor_set_index(0);
					__.options.cursor_snap_position();
				},
				step:  function() {
					__.state.fsm.inherit();
					
					// player input
					var _player = __get_player();
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
			__.state.fsm.change("setup");
		});
		on_activate	 (function() {
			__.state.fsm.change("setup");
		});
		on_cleanup	 (function() {
			__.options.cleanup();
		});
	};
	
	