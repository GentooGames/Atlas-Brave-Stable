
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ // 
	//  ______  __       ______   __  __   ______   ______    //
	// /\  == \/\ \     /\  __ \ /\ \_\ \ /\  ___\ /\  == \   //
	// \ \  _-/\ \ \____\ \  __ \\ \____ \\ \  __\ \ \  __<   //
	//  \ \_\   \ \_____\\ \_\ \_\\/\_____\\ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_/\/_/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ // 
	// objc_player.create //
	event_inherited();
	var _self = self;
	
	#region meta
	
		// public
		profile_create = function(_profile_name) {
			
			var _profile	= profile_get();
			var _port_index = __.input_port_index;
			
			_profile.create(_profile_name, _port_index);
			team_reset();
			
			__.IB.log("profile created: " + _profile_name, IB_LOG_FLAG.PLAYER);
			return self;
		};
		profile_load   = function(_profile_name) {
			
			var _profile = profile_get();
			
			_profile.load_from_disk(_profile_name);
			team_reset();
			
			__.IB.log("profile loaded: " + _profile_name, IB_LOG_FLAG.PLAYER);
			return self;
		};
		profile_get    = function() {
			return __.meta.profile;	
		};
			
		team_get	   = function() {
			return __.meta.team;
		};
		team_next	   = function() {
			var _team = team_get() + 1;
			if (_team > TEAM.LAST) {
				_team = TEAM.FIRST;	
			}
			team_set(_team);
			return self;
		};
		team_previous  = function() {
			var _team = team_get() - 1;
			if (_team < TEAM.FIRST) {
				_team = TEAM.LAST;	
			}
			team_set(_team);
			return self;
		};
		team_reset	   = function() {
			team_set(TEAM.FIRST);
			return self;
		};
		team_set	   = function(_team) {
			__.meta.team = _team;
			return self;
		};
		
		// private
		__[$ "meta"] ??= {};
		with (__.meta) {
			team	= _self[$ "team"] ?? TEAM.FRIENDLY;
			profile = new PlayerProfile({
				input_port: _self.__.input_port_index,
			});	
			stats	= new PlayerStats();	
		};
		
		// events
		on_initialize(function() {
			__.meta.profile.initialize();
		});
		on_cleanup	 (function() {
			__.meta.stats.cleanup();
			__.meta.profile.cleanup();
		});
		
	#endregion
	#region input
		
		// public
		input_left_pressed				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "left");
		};
		input_left_down					 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "left");
		};
		input_left_released				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "left");
		};
		input_right_pressed				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "right");
		};
		input_right_down				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "right");
		};
		input_right_released			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "right");
		};
		input_up_pressed				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "up");
		};
		input_up_down					 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "up");
		};
		input_up_released				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "up");
		};
		input_down_pressed				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "down");
		};
		input_down_down					 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "down");
		};
		input_down_released				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "down");
		};
		input_select_pressed			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "select");
		};
		input_select_down				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "select");
		};
		input_select_released			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "select");
		};
		input_back_pressed				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "back");
		};
		input_back_down					 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "back");
		};
		input_back_released				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "back");
		};
		input_start_pressed				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "start");
		};
		input_start_down				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "start");
		};
		input_start_released			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "start");
		};
		input_options_pressed			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "options");
		};
		input_options_down				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "options");
		};
		input_options_released			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "options");
		};
		input_pause_pressed				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "pause");
		};
		input_pause_down				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "pause");
		};
		input_pause_released			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "pause");
		};
		input_next_pressed				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "next");
		};
		input_next_down					 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "next");
		};
		input_next_released				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "next");
		};
		input_previous_pressed			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "previous");
		};
		input_previous_down				 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "previous");
		};
		input_previous_released			 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "previous");
		};
			
		input_ability_basic_pressed		 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "ability_basic");
		};
		input_ability_basic_down		 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "ability_basic");
		};
		input_ability_basic_released	 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "ability_basic");
		};
		input_ability_defense_pressed	 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "ability_defense");
		};
		input_ability_defense_down		 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "ability_defense");
		};
		input_ability_defense_released	 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "ability_defense");
		};
		input_ability_primary_pressed	 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "ability_primary");
		};
		input_ability_primary_down		 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(__.input_port_index, "ability_primary");
		};
		input_ability_primary_released	 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "ability_primary");
		};
		input_ability_secondary_pressed	 = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(__.input_port_index, "ability_secondary");
		};
		input_ability_secondary_down	 = function(_takes_input = true) {
			return _takes_input && icebe rg.input.check_down(__.input_port_index, "ability_secondary");
		};								 
		input_ability_secondary_released = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(__.input_port_index, "ability_secondary");
		};
	
		// private
		__[$ "input"] ??= {};
		with (__.input) {
			on_device_removed_event	   = method(_self, function(_data) {
				if (input_has_device() == false) {
					deactivate();
				}
			});
			on_device_removed_listener = undefined;
		};
		
		// events
		on_initialize(function() {
			__.input.on_device_removed_listener = iceberg.input.subscribe("device_removed", __.input.on_device_removed_event);
		});
		on_cleanup	 (function() {
			iceberg.input.unsubscribe(__.input.on_device_removed_listener);
		});
	
	#endregion
	#region panel
	
		// public
		panel_get		 = function() {
			return __.panel.instance;
		};
		panel_activate	 = function() {
			__.panel.instance.activate();
			return self;
		};
		panel_deactivate = function() {
			__.panel.instance.deactivate();
			return self;
		};
		panel_show		 = function(_page_name = undefined) {
			if (_page_name != undefined) {
				__.panel.instance.page_change(_page_name);	
			}
			__.panel.instance.show();
			return self;
		};
		panel_hide		 = function() {
			__.panel.instance.hide();
			return self;
		};
		panel_is_active	 = function() {
			return __.panel.instance.is_active();
		};
		panel_is_visible = function() {
			return __.panel.instance.is_visible();	
		};
		
		// private
		__[$ "panel"] ??= {};
		with (__.panel) {
			calculate_width  = method(_self, function() {
				var _panel_count	= objc_game.player_get_count();
				var _width_total	= SURF_W;
				var _padding_total	= __.panel.padding_x * 2;
				var _spacing_total	= __.panel.space_x * (_panel_count - 1);
				var _width_adjusted = _width_total - (_padding_total + _spacing_total);
				var _width_per		= _width_adjusted / _panel_count;
				return _width_per;
			});
			calculate_height = method(_self, function() {
				return SURF_H * 0.4;
			});
			calculate_x		 = method(_self, function() {
				var _panel_width = __.panel.calculate_width();
				var _panel_index = __.input_port_index;
				return __.panel.padding_x + (_panel_width + __.panel.space_x) * _panel_index;
			});
			calculate_y		 = method(_self, function() {
				return SURF_H * 0.2;
			});
			padding_x		 = 50;
			space_x			 = 20;
			instance		 = new PlayerPanel({
				active:  false,
				visible: false,
				owner:  _self,
				index:  _self.__.input_port_index,
				width:   calculate_width(),
				height:  calculate_height(),
				x:		 calculate_x(),
				y:		 calculate_y(),
				color:  _self.profile_get().get_color(),
			});
		};
		
		// events
		on_initialize(function() {
			__.panel.instance.initialize();
			__.IB.log("initialized", IB_LOG_FLAG.PLAYER);
		});
		on_activate  (function() {
			__.panel.instance.activate();
			__.panel.instance.show();
			__.IB.log("activated", IB_LOG_FLAG.PLAYER);
		});
		on_deactivate(function() {
			__.panel.instance.hide();
			__.panel.instance.deactivate();
			__.IB.log("deactivated", IB_LOG_FLAG.PLAYER);
		});
		on_update	 (function() {
			__.panel.instance.update();
		});
		on_render_gui(function() {
			__.panel.instance.render_gui();
		});
		on_room_start(function() {
			switch (room) {
				case rm_main_menu: 
					__.panel.instance.hide();
					__.panel.instance.deactivate();
					break;
					
				case rm_character_select:
					__.panel.instance.page_change("active");
					__.panel.instance.activate();
					__.panel.instance.show();
					break;
			};
		});
		on_room_end	 (function() {
			switch (room) {
				case rm_character_select:
					__.panel.instance.hide();
					__.panel.instance.deactivate();
					break;
			};
		});
		on_cleanup	 (function() {
			__.panel.instance.cleanup();
			__.IB.log("cleaned up", IB_LOG_FLAG.PLAYER);
		});
	
	#endregion
	#region character
		
		// public
		character_get			  = function() {
			return __.character.instance;
		};	
		character_create		  = function(_uid, _x = 0, _y = 0, _config = {}) {
		
			// enforced params
			_config[$ "player"]   = self;
			_config[$ "team"  ] ??= team_get();
		
			var _char = __.character.factory.create(_uid, _x, _y, _config);
			__.character.instance = _char;
			__.character.instance.initialize();
			__.IB.log("character created of uid: " + string(_uid), IB_LOG_FLAG.PLAYER);
			
			return _char;
		};
		character_get_selected	  = function() {
			return __.character.selected_type;
		};
		character_set_selected	  = function(_character_uid) {
			__.character.selected_type = _character_uid;
			__.IB.log("character selected set to: " + string(_character_uid), IB_LOG_FLAG.PLAYER);
			return self;
		};
		character_gain_possession = function(_instance) {
			__.character.factory.store(_instance.get_uid(), _instance);
			_instance.player_set(self);
			__.IB.log("character gain possession: " + string(_instance.id), IB_LOG_FLAG.PLAYER);
			return self;
		};
		character_lose_possession = function(_instance) {
			__.character.factory.remove(_instance.get_uid(), _instance);
			_instance.player_set(undefined);
			__.IB.log("character lose possession: " + string(_instance.id), IB_LOG_FLAG.PLAYER);
			return self;
		};
		
		// private
		__[$ "character"] ??= {};
		with (__.character) {
			death		  = method(_self, function(_instance) {
				__.character.factory.destroy(_instance.get_uid(), _instance);
				__.character.instance = undefined;
				__.IB.log("character death: " + string(_instance.id), IB_LOG_FLAG.PLAYER);
				return self
			});
			instance	  = undefined;
			selected_type = undefined;
			factory		  = new HeroFactory();
		};
		
		// events
		on_initialize(function() {
			__.character.factory.initialize();
		});
			
	#endregion
	#region inventory
	
		// public
		inventory_item_get	  = function(_inventory_index) {
			return __.inventory.instance.item_get(_inventory_index);	
		};
		inventory_item_add	  = function(_item_uid) {
			return __.inventory.instance.item_add(_item_uid);
		};
		inventory_item_exists = function(_item_uid) {
			return __.inventory.instance.item_exists(_item_uid);
		};
		inventory_item_remove = function(_inventory_index) {
			return __.inventory.instance.item_remove(_inventory_index);
		};
		
		// private
		__[$ "inventory"] ??= {};
		with (__.inventory) {
			instance = new Inventory({
				owner:   _self,
				capacity: 20,
			});
		};
		
		// events
		on_initialize(function() {
			__.inventory.instance.initialize();
		});
		on_cleanup	 (function() {
			__.inventory.instance.cleanup();
		});
			
	#endregion
	
	