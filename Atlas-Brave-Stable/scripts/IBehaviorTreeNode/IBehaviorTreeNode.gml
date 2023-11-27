
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______    //
	// /\__  _\/\  == \ /\  ___\ /\  ___\   //
	// \/_/\ \/\ \  __< \ \  __\ \ \  __\   //
	//    \ \_\ \ \_\ \_\\ \_____\\ \_____\ //
	//     \/_/  \/_/ /_/ \/_____/ \/_____/ //
	//                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IBehaviorTreeNode(_nodes = []) constructor {
		
		// public
		static construct = function() {
			var _nodes = [];
			for (var _i = 0, _len = array_length(__.nodes); _i < _len; _i++) {
				var _node = __.nodes[_i];	
				
				switch (instanceof(_node)) {
					case "IFallbackNode":
						var _sub_nodes = _node.construct();
						var _new_node  =  new BehaviorTreeNodeFallback(_sub_nodes);
						array_push(_nodes, _new_node);
						break;
						
					case "ISequenceNode":
						var _sub_nodes = _node.construct();
						var _new_node  =  new BehaviorTreeNodeSequence(_sub_nodes);
						array_push(_nodes, _new_node);
						break;
						
					default:
						array_push(_nodes, new _node());
						break;
				};
			};
			return _nodes;
		};
		
		// private
		__ = {};
		with (__) {
			nodes = _nodes;	
		};
	};
	function IBehaviorTree(_nodes = []) : IBehaviorTreeNode(_nodes) constructor {};
	function IFallbackNode(_nodes = []) : IBehaviorTreeNode(_nodes) constructor {};
	function ISequenceNode(_nodes = []) : IBehaviorTreeNode(_nodes) constructor {};
	
	