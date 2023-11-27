	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   __       __       ______   ______   ______   __  __    //
	// /\  ___\/\  __ \ /\ \     /\ \     /\  == \ /\  __ \ /\  ___\ /\ \/ /    //
	// \ \  __\\ \  __ \\ \ \____\ \ \____\ \  __< \ \  __ \\ \ \____\ \  _"-.  //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_____\\ \_____\\ \_\ \_\\ \_____\\ \_\ \_\ //
	//   \/_/    \/_/\/_/ \/_____/ \/_____/ \/_____/ \/_/\/_/ \/_____/ \/_/\/_/ //
	//                                                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function BehaviorTreeNodeFallback(_nodes = []) : BehaviorTreeNode(_nodes) constructor {
	
		// public
		static evaluate = function(_owner) {
			for (var _i = 0, _len = array_length(__.nodes); _i < _len; _i++) {
				switch (__.nodes[_i].evaluate(_owner)) {
					case BT_STATUS.RUNNING:
						__.status = BT_STATUS.RUNNING;
						return __.status;
					case BT_STATUS.SUCCESS:
						__.status = BT_STATUS.SUCCESS;
						return __.status;
				};
			};
			__.status = BT_STATUS.FAILED;
			return __.status;
		};
	};
	