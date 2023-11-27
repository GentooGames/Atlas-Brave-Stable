
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  __  __    //
	// /\  ___\ /\  == \/\ \/\ \   //
	// \ \ \____\ \  _-/\ \ \_\ \  //
	//  \ \_____\\ \_\   \ \_____\ //
	//   \/_____/ \/_/    \/_____/ //
	//                             //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function CPU(_config = {}) : IB_Base(_config) constructor {
		
		var _self = self;
		
		#region vision ........|
		
			// public
			static vision_scan			= function(_x, _y, _radius) {
				return __.vision.instance.scan(_x, _y, _radius);
			};
			static vision_target_add	= function(_object_index, _precise = true, _notme = true) {
				__.vision.instance.vision_target_add(_object_index, _precise, _notme);
				return self;
			};
			static vision_target_remove = function(_object_index) {
				__.vision.instance.vision_target_remove(_object_index);
				return self;
			};
			
			// private
			__[$ "vision"] ??= {};
			with (__.vision) {
				instance = new Vision({
					owner: _self,	
				});
			};
			
			// events
			on_initialize(function() {
				__.vision.instance.initialize();
			});
			on_cleanup	 (function() {
				__.vision.instance.cleanup();
			});
		
		#endregion
		#region navmesh .......|
		
			// public
			static navmesh_pathfind_to	 = function(_target_instance, _on_path_end = undefined, _on_segment_end = undefined) {
				return __.navmesh.handler.pathfind_to(_target_instance, _on_path_end, _on_segment_end);
			};
			static navmesh_pathfind_stop = function(_execute_callbacks = true) {
				__.navmesh.handler.pathfind_stop(_execute_callbacks);
				return self;
			};
			
			// private
			__[$ "navmesh"] ??= {};
			with (__.navmesh) {
				handler = new NavmeshHandler({
					owner:		   _self,
					move_instance: _self.get_owner(),
				});
			};
			
			// events
			on_initialize(function() {
				__.navmesh.handler.initialize();
			});
			on_update	 (function() {
				__.navmesh.handler.update();
			});
			on_render	 (function() {
				__.navmesh.handler.render();
			});
			on_cleanup	 (function() {
				__.navmesh.handler.cleanup();
			});
		
		#endregion
		#region behavior ......|
			
			// public
			static behavior_assign   = function(_bt_data_name) {
				var _nodes = BEHAVIOR_TREE[$ _bt_data_name];
				__.behavior.tree.assign(_nodes.construct());
				return self;
			};
			static behavior_evaluate = function() {
				__.behavior.tree.evaluate();
				return self;
			};
			
			// private
			__[$ "behavior"] ??= {};
			with (__.behavior) {
				tree = new BehaviorTree({
					owner: _self.get_owner(),
				});
			};
			
			// events
			on_initialize(function() {
				__.behavior.tree.initialize();
			});
			on_update	 (function() {
				__.behavior.tree.update();
			});
			on_cleanup	 (function() {
				__.behavior.tree.cleanup();
			});
		
		#endregion
	};
	
	