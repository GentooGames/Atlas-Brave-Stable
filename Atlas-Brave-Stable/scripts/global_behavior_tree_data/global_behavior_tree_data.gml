
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______    //
	// /\__  _\/\  == \ /\  ___\ /\  ___\   //
	// \/_/\ \/\ \  __< \ \  __\ \ \  __\   //
	//    \ \_\ \ \_\ \_\\ \_____\\ \_____\ //
	//     \/_/  \/_/ /_/ \/_____/ \/_____/ //
	//                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	global.behavior_tree_data = {
		seek_and_attack_nearest: new IBehaviorTree([	
			new ISequenceNode([
				BTAction_PathfindToNearest,
				BTAction_Attack,
			]),
		]),
	};
	#macro BEHAVIOR_TREE global.behavior_tree_data
	