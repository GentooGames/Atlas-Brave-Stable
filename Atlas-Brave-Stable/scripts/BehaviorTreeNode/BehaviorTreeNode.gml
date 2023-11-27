
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   ______   _____    ______    //
	// /\ "-.\ \ /\  __ \ /\  __-. /\  ___\   //
	// \ \ \-.  \\ \ \/\ \\ \ \/\ \\ \  __\   //
	//  \ \_\\"\_\\ \_____\\ \____- \ \_____\ //
	//   \/_/ \/_/ \/_____/ \/____/  \/_____/ //
	//                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function BehaviorTreeNode(_nodes = []) constructor {
		
		// public
		static evaluate   = function() {}; // override
		static get_status = function() {
			return __.status;	
		};
		static set_status = function(_status) {
			if (__.status != _status) {
				__.status  = _status;
			}
			return self;
		};
		
		// private
		__ = {};
		with (__) {
			static __attach_nodes = function() {
				for (var _i = 0, _len = array_length(__.nodes); _i < _len; _i++) {
					var _node = __.nodes[_i];
					
					// assign references
					_node.__.tree	= __.tree;
					_node.__.parent = self;
					
					// depth-first node attachment
					_node.__attach_nodes();
				};
			};
			
			tree   =  undefined;
			parent =  undefined;
			nodes  = _nodes;
			status =  undefined;
		};
		
		__attach_nodes();
	};
	