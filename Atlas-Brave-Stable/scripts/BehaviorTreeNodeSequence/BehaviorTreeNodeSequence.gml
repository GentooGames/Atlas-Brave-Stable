
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   __  __   ______   __   __   ______   ______    //
	// /\  ___\ /\  ___\ /\  __ \ /\ \/\ \ /\  ___\ /\ "-.\ \ /\  ___\ /\  ___\   //
	// \ \___  \\ \  __\ \ \ \/\_\\ \ \_\ \\ \  __\ \ \ \-.  \\ \ \____\ \  __\   //
	//  \/\_____\\ \_____\\ \___\_\\ \_____\\ \_____\\ \_\\"\_\\ \_____\\ \_____\ //
	//   \/_____/ \/_____/ \/___/_/ \/_____/ \/_____/ \/_/ \/_/ \/_____/ \/_____/ //
	//                                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function BehaviorTreeNodeSequence(_nodes = []) : BehaviorTreeNode(_nodes) constructor {
		
		// public
		static evaluate = function(_owner) {
			for (var _i = 0, _len = array_length(__.nodes); _i < _len; _i++) {
				switch (__.nodes[_i].evaluate(_owner)) {
					case BT_STATUS.RUNNING:
						__.status = BT_STATUS.RUNNING;
						return __.status;
					case BT_STATUS.FAILED:
						__.status = BT_STATUS.FAILED;
						return __.status;
				};
			};
			__.status = BT_STATUS.SUCCESS;
			return __.status;
		};
	};
	
	