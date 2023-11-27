
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   __   ______  __  __   ______  //
	// /\ \ /\ "-.\ \ /\  == \/\ \/\ \ /\__  _\ //
	// \ \ \\ \ \-.  \\ \  _-/\ \ \_\ \\/_/\ \/ //
	//  \ \_\\ \_\\"\_\\ \_\   \ \_____\  \ \_\ //
	//   \/_/ \/_/ \/_/ \/_/    \/_____/   \/_/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_SettingsInput(_config = {}) : PlayerPanelPage(_config) constructor {
		
		var _self = self;
		
		// private
		with (__) {
			settings = new IB_UI_MenuList({
				x:		 0,
				y:		 0,
				width:  _self.size_get_width(),
				height: _self.size_get_height(),
			});
			settings.item_new(IB_UI_MenuListEntry_Button, {
				label:			   "devices: ",
				button_text:	   "edit",
				button_width_ratio: 0.6,
				callback:			method(_self, function() {
					__.panel.page_change("settings_input_devices");
				}),
			});
			settings.item_new(IB_UI_MenuListEntry_SliderNumeric, {
				variable_context:  undefined,
				variable_name_get: "deadzone_get",
				variable_name_set: "deadzone_set",
				label:			   "deadzones: ",
				callback_adjust:   undefined,
			});
			settings.item_new(IB_UI_MenuListEntry_Text, {
				color:	  c_white,
				text:	 "back",
				callback: method(_self, function() {
					__.panel.page_change("settings");
				}),
			});
			
			// state
			state.fsm.add_child("__", "input", {
				enter: function() {
					__.state.fsm.inherit();	
					__.settings.cursor_set_index(0);
					__.settings.cursor_snap_position();
				},
				step:  function() {
					__.state.fsm.inherit();	
				
					// player input
					var _player = __get_player();
					if (_player.input_select_pressed()) {
						__.panel.audio_play(sfx_confirm);
						__.settings.cursor_select();
					}
					if (_player.input_back_pressed()) { 
						__.panel.audio_play(sfx_navigate);
						__.panel.page_change("settings");	
					}
					if (_player.input_up_pressed()) { 
						__.panel.audio_play(sfx_navigate);
						__.settings.cursor_move_up();	
					}
					if (_player.input_down_pressed()) { 
						__.panel.audio_play(sfx_navigate);
						__.settings.cursor_move_down();
					}
					if (_player.input_right_down	()) { // increment settings slider/options
						var _item = __.settings.cursor_get_item();
						switch (instanceof(_item)) {
							case "IB_UI_MenuListEntry_SliderNumeric":
								_item.increment();
								break;
							case "IB_UI_MenuListEntry_Options":
								_item.page_right();
								break;
						};
					}
					if (_player.input_left_down		()) { // decrement settings slider/options
						var _item = __.settings.cursor_get_item();
						switch (instanceof(_item)) {
							case "IB_UI_MenuListEntry_SliderNumeric":
								_item.decrement();
								break;
							case "IB_UI_MenuListEntry_Options":
								_item.page_left();
								break;
						};
					}
					
					__.settings.update();
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					__.settings.render();
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();	
				},
			});
		};
		
		// events
		on_initialize(function() {
			__.settings.initialize();
			__.state.fsm.change("input");
		});
		on_activate  (function() {
			// update variable binding context
			var _profile = __.panel.get_player().profile_get();
			iceberg.array.for_each(__.settings.item_get_all(), 
				function(_item, _profile) {
					if (instanceof(_item) == "IB_UI_MenuListEntry_SliderNumeric") {
					   _item.set_variable(_profile.__.input_profile);
					}
				}, 
				_profile,
			);
			__.state.fsm.change("input");
		});
		on_cleanup	 (function() {
			__.settings.cleanup();
		});
	};
	
	