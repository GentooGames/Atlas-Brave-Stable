
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  _____    ______   __   __ __   ______   ______   ______    //
	// /\  __-. /\  ___\ /\ \ / //\ \ /\  ___\ /\  ___\ /\  ___\   //
	// \ \ \/\ \\ \  __\ \ \ \'/ \ \ \\ \ \____\ \  __\ \ \___  \  //
	//  \ \____- \ \_____\\ \__|  \ \_\\ \_____\\ \_____\\/\_____\ //
	//   \/____/  \/_____/ \/_/    \/_/ \/_____/ \/_____/ \/_____/ //
	//                                                             //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_SettingsInputDevices(_config = {}) : PlayerPanelPage(_config) constructor {
		
		var _self = self;
		
		// private
		with (__) {
			static __on_new_keyboard	   = method(_self, function() {});
			static __on_new_mouse		   = method(_self, function() {});
			static __on_new_keyboard_mouse = method(_self, function() {});
			static __on_new_gamepad		   = method(_self, function() {
				__update_devices_list();
			});
			static __update_device_current = function() {
				var _player  = __get_player();
				var _devices = _player.input_get_devices();
				if (array_length(_devices) > 0) {
					__.input_device_current = _devices[0];
				}
			};
			static __update_devices_list   = function() {
				
				__.input_devices_total = [];
				__.devices.item_clear_all();
				
				// fetch all registered devices
				var _devices = iceberg.input.device_get_total_devices();
				
				// store into array
				for (var _i = 0, _len = array_length(_devices); _i < _len; _i++) {
					array_push(__.input_devices_total, _devices[_i]);
				};
				
				// create new ui elements
				for (var _i = 0, _len = array_length(__.input_devices_total); _i < _len; _i++) {
					var _device = __.input_devices_total[_i];
					__.devices.item_new(IB_UI_MenuListEntry_Text, {
						text: _device.get_description(),
					});
				};
			};
			
			input_device_current = undefined;
			input_devices_total  = [];
			input_devices_taken  = [];
			
			devices = new IB_UI_MenuList({
				x:		 0,
				y:		 0,
				width:  _self.size_get_width(),
				height: _self.size_get_height(),
			});
			
			// state
			state.fsm.add_child("__", "devices", {
				enter: function() {
					__.state.fsm.inherit();
					__update_device_current();
					__update_devices_list();
					__.devices.cursor_set_index(0);
					__.devices.cursor_snap_position();
				},
				step:  function() {
					__.state.fsm.inherit();
					__.devices.update();
					
					// player input
					var _player = __get_player();
					if (_player.input_down_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.devices.cursor_move_down();
					}
					if (_player.input_up_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.devices.cursor_move_up();
					}
					if (_player.input_back_pressed()) {
						__.panel.audio_play(sfx_navigate);
						__.panel.page_change("settings_input");
					}
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					
					// current device //////////////
					draw_set_halign(fa_center);
					draw_set_valign(fa_center);
					
					var _current = __.input_device_current;
					var _text	 = _current != undefined
						? _current.get_description()
						: "";
					
					draw_text_transformed_color(
						size_get_width () * 0.50,
						size_get_height() * 0.25,
						"current\n" + _text,
						1, 
						1,
						0,
						c_white,
						c_white,
						c_white,
						c_white,
						1
					);
					
					draw_set_halign(fa_left);
					draw_set_valign(fa_top );
					
					// optional devices ////////////
					__.devices.render();
					
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();
				},
			});
				
			// hooks
			sub_new_keyboard	   = iceberg.input.subscribe("keyboard_device_created",		  __on_new_keyboard);
			sub_new_mouse		   = iceberg.input.subscribe("mouse_device_created",		  __on_new_mouse   );
			sub_new_keyboard_mouse = iceberg.input.subscribe("keyboard_mouse_device_created", __on_new_keyboard);
			sub_new_gamepad		   = iceberg.input.subscribe("gamepad_device_created",		  __on_new_gamepad );
		};
		
		// events
		on_initialize(function() {
			__.devices.initialize();
			__.state.fsm.change("devices");
		});
		on_activate  (function() {
			__.state.fsm.change("devices");
		});
		on_cleanup	 (function() {
			__.devices.cleanup();
			iceberg.input.unsubscribe(__.sub_new_keyboard	   );
			iceberg.input.unsubscribe(__.sub_new_mouse		   );
			iceberg.input.unsubscribe(__.sub_new_keyboard_mouse);
			iceberg.input.unsubscribe(__.sub_new_gamepad	   );
		});
	};
	
	// setup listeners/subscribers to react to freshly
	// plugged and unplugged gamepad devices.
	