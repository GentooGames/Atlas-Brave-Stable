
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_Game.create //
	iceberg_create();
	event_inherited();
	
	var _self = self;
	
	#region input
		
		// private
		with (__) {
			port_created_event	  = method(_self, function(_data) {
				var _port_index = _data.payload;
				player_create(_port_index);
				__.IB.log("player_created on port: " + string(_port_index));
			});
			port_removed_event	  = method(_self, function(_data) {
				var _port_index = _data.payload;
				player_remove(_port_index, true); // destroy player
				__.IB.log("player_destroyed on port: " + string(_port_index));
			});
			port_created_listener = undefined;
			port_removed_listener = undefined;
		};
			
		// events
		on_initialize(function() {
			__.port_created_listener = iceberg.input.subscribe("port_created", __.port_created_event);
			__.port_removed_listener = iceberg.input.subscribe("port_removed", __.port_removed_event);
		});	
	
	#endregion
	#region player
	
		// public
		player_create			= function(_port_index, _config = {}, _initialize = true) {
		
			_config[$ "active"			]   =  false;
			_config[$ "input_port_index"] ??= _port_index;
		
			var _player = instance_create_depth(0, 0, 0, objc_player, _config);
			if (_initialize) _player.initialize();
			
			__.players.set(_port_index, _player);
			__.IB.log("player created on port index: " + string(_port_index), IB_LOG_FLAG.GAME);
		
			return _player;
		};
		player_remove			= function(_port_index, _destroy = true) {
		
			var _player = __.players.get_items(_port_index);
			__.players.remove(_port_index);
		
			if (_destroy) _player.destroy();
			__.IB.log("player removed from port index: " + string(_port_index), IB_LOG_FLAG.GAME);
		
			return _player;
		};
		player_get				= function(_port_index) {
			return __.players.get(_port_index);
		};
		player_get_active_count = function() {
			var _count = 0;
			for (var _i = 0, _len = player_get_count(); _i < _len; _i++) {
				var _player = player_get(_i);
				if (_player.is_active()) {
					_count++;	
				}
			};
			return _count;
		};
		player_get_count		= function() {
			return IB_CONFIG.player.max_count;
		};
		player_for_each			= function(_callback, _data = undefined) {
			__.players.for_each(_callback, _data);	
			return self;
		};
		player_is_active		= function(_port_index) {
			var _player  = player_get(_port_index);
			if (_player != undefined) {
				return _player.is_active();
			}
			return false;
		};
	
		// private
		with (__) {
			players	= new IB_Collection_Struct();
		};
			
		// events
		on_cleanup(function() {
			__.players.cleanup();	
		});
	
	#endregion
	#region iceberg
	
		// events
		on_initialize(function() {
			iceberg_initialize();
			iceberg_activate();
		});
	
	#endregion
	