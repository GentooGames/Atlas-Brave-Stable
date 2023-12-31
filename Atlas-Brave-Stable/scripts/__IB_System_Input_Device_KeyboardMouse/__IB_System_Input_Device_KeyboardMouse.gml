
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   ______   __  __       __    __   ______   __  __   ______   ______    //
	// /\ \/ /  /\  ___\ /\ \_\ \     /\ "-./  \ /\  __ \ /\ \/\ \ /\  ___\ /\  ___\   //
	// \ \  _"-.\ \  __\ \ \____ \    \ \ \-./\ \\ \ \/\ \\ \ \_\ \\ \___  \\ \  __\   //
	//  \ \_\ \_\\ \_____\\/\_____\    \ \_\ \ \_\\ \_____\\ \_____\\/\_____\\ \_____\ //
	//   \/_/\/_/ \/_____/ \/_____/     \/_/  \/_/ \/_____/ \/_____/ \/_____/ \/_____/ //
	//                                                                                 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Device_KeyboardMouse(_config = {}) : __IB_System_Input_Device_Mouse(_config) constructor {

		var _self = self;
		
		// public
		static get_description = function() {
			return __.desc;
		};
		
		// private
		with (__) {
			type = "keyboard_mouse";
			desc = "Keyboard & Mouse";
		};
	};
	