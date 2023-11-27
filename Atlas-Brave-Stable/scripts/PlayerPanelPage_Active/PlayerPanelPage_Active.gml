
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______  __   __   __ ______    //
	// /\  __ \ /\  ___\ /\__  _\/\ \ /\ \ / //\  ___\   //
	// \ \  __ \\ \ \____\/_/\ \/\ \ \\ \ \'/ \ \  __\   //
	//  \ \_\ \_\\ \_____\  \ \_\ \ \_\\ \__|  \ \_____\ //
	//   \/_/\/_/ \/_____/   \/_/  \/_/ \/_/    \/_____/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_Active(_config = {}) : PlayerPanelPage(_config) constructor {
		
		var _self = self;

		// private
		with (__) {
			state.fsm.add_child("__", "main", {
				enter: function() {
					__.state.fsm.inherit();		
				},
				step:  function() {
					__.state.fsm.inherit();	
					if (iceberg.input.port_has_device(__.panel.get_index())) {
						__.panel.page_change(__.panel.__.page_first);
					}
				},
				draw:  function() {
					__.state.fsm.inherit();
					__render_surface_start();
					__render_banner({
						text:		"plug in controller",
						text_scale: 1,
					});
					__render_surface_end();
				},
				leave: function() {
					__.state.fsm.inherit();		
				},
			});
		};
		
		// events
		on_initialize(function() {
			__.state.fsm.change("main");
		});
	};
	
	