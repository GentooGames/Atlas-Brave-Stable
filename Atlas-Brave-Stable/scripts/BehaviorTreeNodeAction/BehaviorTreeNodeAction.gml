
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______  __   ______   __   __    //
	// /\  __ \ /\  ___\ /\__  _\/\ \ /\  __ \ /\ "-.\ \   //
	// \ \  __ \\ \ \____\/_/\ \/\ \ \\ \ \/\ \\ \ \-.  \  //
	//  \ \_\ \_\\ \_____\  \ \_\ \ \_\\ \_____\\ \_\\"\_\ //
	//   \/_/\/_/ \/_____/   \/_/  \/_/ \/_____/ \/_/ \/_/ //
	//                                                     //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function BehaviorTreeNodeAction() : BehaviorTreeNode() constructor {
		
		// public
		static evaluate  = function(_owner) {
			__.tree.__set_action(self);	
			return __.status;
		};
		static on_enter  = function(_owner) {}; // override
		static on_update = function(_owner) {}; // override
		static on_leave  = function(_owner) {}; // override
		
		// private
		with (__) {
			status = BT_STATUS.RUNNING;	
		};
	};
	
	