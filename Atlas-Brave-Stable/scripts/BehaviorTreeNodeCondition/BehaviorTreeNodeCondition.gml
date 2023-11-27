
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __   _____    __   ______  __   ______   __   __    //
	// /\  ___\ /\  __ \ /\ "-.\ \ /\  __-. /\ \ /\__  _\/\ \ /\  __ \ /\ "-.\ \   //
	// \ \ \____\ \ \/\ \\ \ \-.  \\ \ \/\ \\ \ \\/_/\ \/\ \ \\ \ \/\ \\ \ \-.  \  //
	//  \ \_____\\ \_____\\ \_\\"\_\\ \____- \ \_\  \ \_\ \ \_\\ \_____\\ \_\\"\_\ //
	//   \/_____/ \/_____/ \/_/ \/_/ \/____/  \/_/   \/_/  \/_/ \/_____/ \/_/ \/_/ //
	//                                                                             //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function BehaviorTreeNodeCondition(_condition) : BehaviorTreeNode() constructor {
		
		// public
		static evaluate = function(_owner) {
			if (__.condition != undefined) {
				if (__.condition(_owner)) {
					__.status = BT_STATUS.SUCCESS;	
				}
				else {
					__.status = BT_STATUS.FAILED;	
				}
				return __.status;
			}
			__.status = BT_STATUS.SUCCESS;
			return __.status;
		};
		
		// private
		with (__) {
			condition = _condition;
		};
	};
	
	function BehaviorTreeNodeCondition_HasLineOfSight() : BehaviorTreeNodeCondition() constructor {
	
		// public
		static evaluate = function(_owner) {};
	};
	
	