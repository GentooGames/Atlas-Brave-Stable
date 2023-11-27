
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______    //
	// /\__  _\/\  == \ /\  ___\ /\  ___\   //
	// \/_/\ \/\ \  __< \ \  __\ \ \  __\   //
	//    \ \_\ \ \_\ \_\\ \_____\\ \_____\ //
	//     \/_/  \/_/ /_/ \/_____/ \/_____/ //
	//                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	enum BT_STATUS { SUCCESS, FAILED, RUNNING };
	
	function BehaviorTree(_config = {}) : IB_Base(_config) constructor {
		
		// public
		static assign			 = function(_nodes_array) {
			__.root   =  undefined;
			__.status =  undefined;
			__.action =  undefined;
			__.nodes  = _nodes_array;
			__attach_nodes();
			return self;
		};
		static evaluate			 = function() {
			if (__.root != undefined) {
				var _owner = get_owner();
				__.status = __.root.evaluate(_owner);	
				return __.status;
			}
			__.status = BT_STATUS.FAILED;
			return __.status;
		};
		static action_set_status = function(_status) {
			if (__.action != undefined) {
				__.action.set_status(_status);
			};
			return self;
		};
		static data_get			 = function(_key) {
			return __.blackboard[$ _key];
		};
		static data_set			 = function(_key, _value) {
			__.blackboard[$ _key] = _value;
			return self;
		};
		static data_remove		 = function(_key) {
			variable_struct_remove(__.blackboard, _key);	
		};
		static data_clear		 = function() {
			__.blackboard = {};
			return self;
		};
		
		// private
		with (__) {
			static __attach_nodes = function() {
				for (var _i = 0, _len = array_length(__.nodes); _i < _len; _i++) {
					var _node = __.nodes[_i];
					
					// first node should be root node
					if (__.root == undefined) {
						__.root = _node;	
					}
					
					// assign references
					_node.__.tree	= self;
					_node.__.parent = self;
					
					// depth-first node attachment
					_node.__attach_nodes();
				};
			};
			static __set_action	  = function(_action) {
				
				// only assign if new action coming in
				if (__.action != _action) {
					
					var _owner = get_owner();
					
					// execute previous action's on_leave()
					if (__.action != undefined) __.action.on_leave(_owner);
					
					// assing new action
					__.action = _action;
					
					// execute new action's on_enter()
					if (__.action != undefined) __.action.on_enter(_owner);
				}
			};
			
			nodes	   = _config[$ "nodes"] ?? [];
			root	   =  undefined;
			status	   =  undefined;
			action	   =  undefined;
			blackboard =  {};
		};
			
		// events
		on_initialize(function() {
			__attach_nodes();
		});
		on_update	 (function() {
			if (__.action != undefined) {
				
				// if action status changed, evaluate
				if (__.action.get_status() != __.status) {
					evaluate();
				}
				
				// update loop 
				var _owner = get_owner();
				__.action.on_update(_owner);	
			}
		});
	};
	