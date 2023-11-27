	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______  __   ______   __   __   ______    //
	// /\  __ \ /\  ___\ /\__  _\/\ \ /\  __ \ /\ "-.\ \ /\  ___\   //
	// \ \  __ \\ \ \____\/_/\ \/\ \ \\ \ \/\ \\ \ \-.  \\ \___  \  //
	//  \ \_\ \_\\ \_____\  \ \_\ \ \_\\ \_____\\ \_\\"\_\\/\_____\ //
	//   \/_/\/_/ \/_____/   \/_/  \/_/ \/_____/ \/_/ \/_/ \/_____/ //
	//                                                              //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function BTAction_PathfindToNearest() : BehaviorTreeNodeAction() constructor {
		
		static on_enter  = function(_char) {
			
			// add character to vision awareness
			_char.cpu_vision_target_add(obj_hero);
			
			// do vision scan
			static _radius =  100;
			var _targets   = _char.cpu_vision_scan(
				_char.position_get_x(), 
				_char.position_get_y(false), 
				_radius,
			);
			
			// if targets in scan radius
			if (array_length(_targets) > 0) {
				
				// get first (closest) target
				var _target = _targets[0];
			
				// write target to BT blackboard
				__.tree.data_set("pathfind_target", _target);
			
				// trigger navmesh pathfind to target
				_char.cpu_navmesh_pathfind_to(_target,
					method(__.tree, function() {
						action_set_status(BT_STATUS.SUCCESS);	
					})
				);
			}
			// no targets in scan radius
			else {
				set_status(BT_STATUS.FAILED);
			}
		};
		static on_update = function(_char) {};
		static on_leave  = function(_char) {
			__.tree.data_remove("pathfind_target");
		};
	};
	function BTAction_Attack() : BehaviorTreeNodeAction() constructor {
		
		static on_enter = function(_char) {
			_char.ability_start("basic");	
			set_status(BT_STATUS.SUCCESS);
		};
		
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	