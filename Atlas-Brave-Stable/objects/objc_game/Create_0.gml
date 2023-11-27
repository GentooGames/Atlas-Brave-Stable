
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_game.create //
	event_inherited();
	var _self = self;
	
	#region input
		
		// private
		__[$ "input"] ??= {};
		with (__.input) {
			auto_assign_gamepad_event	 = method(_self, function(_data) {
				var _device_data	= _data.payload;
				var _device_index	= _device_data.index;
				var _gamepad_device =  iceberg.input.device_get_gamepad(_device_index);
				for (var _i = 0, _len = iceberg.input.port_get_count(); _i < _len; _i++) {
					var  _player = player_get(_i);
					if (!_player.input_has_device_type("gamepad")) {
						 _player.input_add_device(_gamepad_device);
						  break;
					}
				};
			});
			auto_assign_gamepad_listener = undefined;
		};
		
		// events
		on_initialize(function() {
			__.input.auto_assign_gamepad_listener = iceberg.input.subscribe("gamepad_device_created", __.input.auto_assign_gamepad_event);
		});
		
	#endregion
	#region font
		
		// public
		font_reset = function() {
			draw_set_font(fnt_1980XX_24);	
			return self;
		};
		
		// events
		on_initialize(function() {
			font_reset();
		});
		
	#endregion
	#region state
		
		// private
		__[$ "state"] ??= {};
		with (__.state) {
			fsm = new SnowState("idle", false, {
				owner: _self,
			});
				
			fsm.add		 ("__",						  game_state_base());
			fsm.add_child("__", "begin",			  game_state_begin());
			fsm.add_child("__", "idle",				  game_state_idle());
			fsm.add_child("__", "create_controllers", game_state_create_controllers());
			fsm.add_child("__", "load_sprite_data",	  game_state_load_sprite_data());
			fsm.add_child("__", "init_global_data",	  game_state_init_global_data());
			fsm.add_child("__", "init_controllers",	  game_state_init_controllers());
			fsm.add_child("__", "ready",			  game_state_ready());
			fsm.add_child("__", "running",			  game_state_running());	
		};
		
		// events
		on_initialize  (function() {
			__.state.fsm.change("begin");
		});
		on_update_begin(function() {
			__.state.fsm.begin_step();
		});
		on_update	   (function() {
			__.state.fsm.step();
		});
		on_render_gui  (function() {
			__.state.fsm.render_gui();
		});
		
	#endregion
	
	initialize();
	