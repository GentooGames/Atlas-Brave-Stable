
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   __    __   ______  __       ______   ______  ______    //
	// /\__  _\/\  ___\ /\ "-./  \ /\  == \/\ \     /\  __ \ /\__  _\/\  ___\   //
	// \/_/\ \/\ \  __\ \ \ \-./\ \\ \  _-/\ \ \____\ \  __ \\/_/\ \/\ \  __\   //
	//    \ \_\ \ \_____\\ \_\ \ \_\\ \_\   \ \_____\\ \_\ \_\  \ \_\ \ \_____\ //
	//     \/_/  \/_____/ \/_/  \/_/ \/_/    \/_____/ \/_/\/_/   \/_/  \/_____/ //
	//                                                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_Template(_config = {}) : PlayerPanelPage(_config) constructor {

		var _self = self;
		
		// private
		with (__) {
			state.fsm.add_child("__", "profile_setup", {
				enter: function() {
					__.state.fsm.inherit();
				},
				step:  function() {
					__.state.fsm.inherit();
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					// ...
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();
				},
			});
		};
			
		// events
		on_initialize(function() {
			__.state.fsm.change("profile_setup");
		});
		on_activate	 (function() {
			__.state.fsm.change("profile_setup");
		});
		on_cleanup	 (function() {});
	};
	
	