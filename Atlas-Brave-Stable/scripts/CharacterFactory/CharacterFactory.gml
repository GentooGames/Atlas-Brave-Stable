
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______  ______   ______   __  __    //
	// /\  ___\/\  __ \ /\  ___\ /\__  _\/\  __ \ /\  == \ /\ \_\ \   //
	// \ \  __\\ \  __ \\ \ \____\/_/\ \/\ \ \/\ \\ \  __< \ \____ \  //
	//  \ \_\   \ \_\ \_\\ \_____\  \ \_\ \ \_____\\ \_\ \_\\/\_____\ //
	//   \/_/    \/_/\/_/ \/_____/   \/_/  \/_____/ \/_/ /_/ \/_____/ //
	//                                                            	  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function CharacterFactory(_config = {}) : IB_Base(_config) constructor {
		
		// public
		static create	= function(_uid, _x, _y, _config = {}) {
			return __create(_uid, _x, _y, _config);
		};
		static store	= function(_uid, _instance) {
			__store(_uid, _instance);
			return self;
		};
		static contains = function(_uid, _instance = undefined) {
			return __contains(_uid, _instance);
		};
		static remove	= function(_uid, _instance = undefined) {
			return __remove(_uid, _instance);
		};
		static destroy	= function(_uid, _instance = undefined) {
			return __destroy(_uid, _instance);
		};
		
		// private
		with (__) {
			static __create	  = function(_object_index, _uid, _x, _y, _config = {}) {
				
				// enforced params
				_config[$ "uid"] = _uid;
		
				var _char = instance_create_depth(_x, _y, 0, _object_index, _config);
				store(_uid, _char);
			
				return _char;
			};
			static __store	  = function(_uid, _instance) {
				__.instances.add(_uid, _instance);
			};
			static __contains = function(_uid, _instance = undefined) {
				return __.instances.contains(_uid, _instance);
			};
			static __remove	  = function(_uid, _instance = undefined) {
				__.instances.remove(_uid, _instance);
			};
			static __destroy  = function(_uid, _instance = undefined) {
				if (_instance == undefined) {
					var _characters = __.instances.get_items(_uid);
					_characters.for_each(function(_char) {
						_char.destroy();
					});
				}
				else {
					_instance.destroy();
				}
				remove(_uid, _instance);
			};
			
			instances = new IB_Collection_Set();
		};
	};
	function HeroFactory (_config = {}) : CharacterFactory(_config) constructor {
		
		// @override
		static create = function(_uid, _x, _y, _config = {}) {
			return __create(obj_hero, _uid, _x, _y, _config);	
		};
	};
	function EnemyFactory(_config = {}) : CharacterFactory(_config) constructor {
		
		// @override
		static create = function(_uid, _x, _y, _config = {}) {
			return __create(obj_enemy, _uid, _x, _y, _config);	
		};
	};
	function BossFactory (_config = {}) : CharacterFactory(_config) constructor {
		
		// @override
		static create = function(_uid, _x, _y, _config = {}) {
			return __create(obj_boss, _uid, _x, _y, _config);	
		};
	};
	
	