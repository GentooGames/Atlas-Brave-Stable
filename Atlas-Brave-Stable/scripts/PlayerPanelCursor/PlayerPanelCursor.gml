
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //	
	//  ______   __  __   ______   ______   ______   ______    //
	// /\  ___\ /\ \/\ \ /\  == \ /\  ___\ /\  __ \ /\  == \   //
	// \ \ \____\ \ \_\ \\ \  __< \ \___  \\ \ \/\ \\ \  __<   //
	//  \ \_____\\ \_____\\ \_\ \_\\/\_____\\ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_/ /_/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelCursor(_config = {}) : IB_Entity(_config) constructor {
		
		var _self = self;
		
		// public
		static player_get			 = function() {
			return __.player;	
		};
		static state_change			 = function(_state_name) {
			__.state.fsm.change(_state_name);
			return self;
		};
		static state_is				 = function(_state_name) {
			return __.state.fsm.state_is(_state_name);
		};
									 
		static index_select			 = function() {
			if (__.index_on_select != undefined) {
				return __.index_on_select();	
			}
			return undefined;
		};
		static index_deselect		 = function() {
			if (__.index_on_deselect != undefined) {
				return __.index_on_deselect();
			}
			return undefined;
		};
		static index_left			 = function() {
			index_set_i(__.index_i - 1);
			return self;
		};
		static index_right			 = function() {
			index_set_i(__.index_i + 1);
			return self;
		};
		static index_up				 = function() {
			index_set_j(__.index_j - 1);
			return self;
		};
		static index_down			 = function() {
			index_set_j(__.index_j + 1);
			return self;
		};
		static index_get_i			 = function() {
			return __.index_i;
		};
		static index_get_j			 = function() {
			return __.index_j;
		};
		static index_get_i_previous  = function() {
			return __.index_i_previous;	
		};
		static index_get_j_previous  = function() {
			return __.index_j_previous;	
		};
		static index_set_i			 = function(_index) {
			__.index_i_previous = __.index_i;
			__.index_i			= iceberg.math.wrap(_index, 0, __.index_i_max - 1);
			if (__.index_on_change != undefined) {
				return __.index_on_change();	
			}
			return undefined;
		};
		static index_set_j			 = function(_index) {
			__.index_j_previous = __.index_j;
			__.index_j			= iceberg.math.wrap(_index, 0, __.index_j_max - 1);
			if (__.index_on_change != undefined) {
				return __.index_on_change();	
			}
			return undefined;
		};
		static index_set_i_max		 = function(_index_max) {
			__.index_i_max = _index_max;
			   index_set_i(__.index_i);
			return self;
		};
		static index_set_j_max		 = function(_index_max) {
			__.index_j_max = _index_max;
			   index_set_j(__.index_j);
			return self;
		};
		static index_set_on_change	 = function(_callback) {
			__.index_on_change = _callback;
			return self;
		};
		static index_set_on_select	 = function(_callback) {
			__.index_on_select = _callback;
			return self;
		};
		static index_set_on_deselect = function(_callback) {
			__.index_on_deselect = _callback;
			return self;
		};
		
		// private
		with (__) {
			panel			  = _config[$ "panel"			 ] ?? owner;
			player			  = _config[$ "player"			 ] ?? panel.get_owner();
			index_i			  = _config[$ "index_i"			 ] ?? 0;
			index_j			  = _config[$ "index_j"			 ] ?? 0;
			index_i_max		  = _config[$ "index_i_max"		 ] ?? 0;
			index_j_max		  = _config[$ "index_j_max"		 ] ?? 0;
			index_on_change	  = _config[$ "index_on_change"	 ] ?? undefined;
			index_on_select   = _config[$ "index_on_select"	 ] ?? undefined;
			index_on_deselect = _config[$ "index_on_deselect"] ?? undefined;
			index_i_previous  =  index_i;
			index_j_previous  =  index_j;
			
			state = {};
			with (state) {
				fsm = new SnowState("character_select", false, {
					owner: _self,	
				});	
				fsm.add		 ("__", {
					enter: function() {},
					step:  function() {},
					draw:  function() {},
					leave: function() {},
				});
				fsm.add_child("__", "character_select", {
					enter: function() {
						__.state.fsm.inherit();
						scale_set(3);
					},
					step:  function() {
						__.state.fsm.inherit();
					},
					draw:  function() {
						__.state.fsm.inherit();	
						draw_sprite_ext(
							spr_character_select_cursor,
							0,
							position_get_x(), 
							position_get_y(), 
							scale_get_x(),
							scale_get_y(),
							0,
							color_get(), 
							1,
						);
					},
					leave: function() {
						__.state.fsm.inherit();
					},
				});
				fsm.add_child("__", "inventory",		{
					enter: function() {
						__.state.fsm.inherit();
					},
					step:  function() {
						__.state.fsm.inherit();
					},
					draw:  function() {
						__.state.fsm.inherit();
					},
					leave: function() {
						__.state.fsm.inherit();
					},
				});
			};
		};
		
		// events
		on_initialize(function() {
			__.state.fsm.change("character_select");
		});
		on_update	 (function() {
			__.state.fsm.step();
		});
		on_render_gui(function() {
			__.state.fsm.draw();
		});
				
	};
	
	