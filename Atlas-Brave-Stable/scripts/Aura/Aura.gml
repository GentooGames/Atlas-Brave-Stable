
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______    //
	// /\  __ \ /\ \/\ \ /\  == \ /\  __ \   //
	// \ \  __ \\ \ \_\ \\ \  __< \ \  __ \  //
	//  \ \_\ \_\\ \_____\\ \_\ \_\\ \_\ \_\ //
	//   \/_/\/_/ \/_____/ \/_/ /_/ \/_/\/_/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
//	function Aura(_type, _config = {}) : IB_Base(_config) constructor {
//			
//		var _self = self;
//		
//		// public
//		static get_hitbox = function() {
//			return __.hitbox;	
//		};
//		static get_type   = function() {
//			return __.type;	
//		};
//		
//		// private
//		with (__) {
//			type   = _type;
//			data   = AURA_DATA[$ type];
//			hitbox = undefined;
//		};
//		
//		// events
//		on_initialize(function() {
//			var _char = get_owner();
//			__.hitbox = _char.hitbox_create(get_name(), __.data.hitbox);
//		});
//		on_cleanup	 (function() {
//			var _char = get_owner();
//			_char.hitbox_destroy(get_name());
//		});
//	};
//	
//	