
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   ______   __  __   ______   ______   ______   ______   _____    //
	// /\ \/ /  /\  ___\ /\ \_\ \ /\  == \ /\  __ \ /\  __ \ /\  == \ /\  __-.  //
	// \ \  _"-.\ \  __\ \ \____ \\ \  __< \ \ \/\ \\ \  __ \\ \  __< \ \ \/\ \ //
	//  \ \_\ \_\\ \_____\\/\_____\\ \_____\\ \_____\\ \_\ \_\\ \_\ \_\\ \____- //
	//   \/_/\/_/ \/_____/ \/_____/ \/_____/ \/_____/ \/_/\/_/ \/_/ /_/ \/____/ //
	//                                                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Device_Keyboard(_config = {}) : __IB_System_Input_Device(_config) constructor {
	
		var _self = self;
	
		// public
		static get_description = function() {
			return __.desc;	
		};
	
		// private
		with (__) {
			type = "keyboard";	
			desc = "Keyboard";
		};
	};
	