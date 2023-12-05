
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __       ______   __  __   ______   ______    //
	// /\  == \/\ \     /\  __ \ /\ \_\ \ /\  ___\ /\  == \   //
	// \ \  _-/\ \ \____\ \  __ \\ \____ \\ \  __\ \ \  __<   //
	//  \ \_\   \ \_____\\ \_\ \_\\/\_____\\ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_/\/_/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_Player.create //
	event_inherited();
	var _self = self;
	
	#region log
	
		// public
		log = function(_string, _log_flags = IB_LOG_FLAG.NONE) {
			__.IB.log(_string, IB_LOG_FLAG.PLAYER & _log_flags);	
		};
	
	#endregion
	#region input
	
		// public
		input_add_device	  = function(_input_device) {
			iceberg.input.port_add_device(__.input_port_index, _input_device);
			__.radio.instance.broadcast("input_device_added", {
				port: __.input_port_index,
				device: _input_device,
			});
			log("input device added: " + instanceof(_input_device));
			return self;
		};
		input_set_devices	  = function(_input_devices) {
			iceberg.input.port_set_devices(__.input_port_index, _input_devices);
			__.radio.instance.broadcast("input_device_set", {
				port:  __.input_port_index,
				devices: _input_devices,
			});
			log("input devices set.");
			return self;
		};
		input_remove_device   = function(_input_device) {
			if (iceberg.input.port_has_device(__.input_port_index, _input_device)) {
				iceberg.input.port_remove_device(__.input_port_index, _input_device);	
				__.radio.instance.broadcast("input_device_removed", {
					port: __.input_port_index,
					device: _input_device,
				});
				log("input device removed: " + instanceof(_input_device));
			}
			return self;
		};
	
		input_get_port_index  = function() {
			return __.input_port_index;
		};
		input_get_profile	  = function() {
			return iceberg.input.port_get_profile(__.input_port_index);
		};
		input_get_devices	  = function() {
			return iceberg.input.port_get_devices(__.input_port_index);
		};
		input_has_device	  = function(_input_device = undefined) {
			return iceberg.input.port_has_device(__.input_port_index, _input_device);
		};
		input_has_device_type = function(_device_type) {
			return iceberg.input.port_has_device_type(__.input_port_index, _device_type);
		};
	
		// private
		with (__) {
			input_port_index		  = _self[$ "input_port_index"] ?? 0;
			port_activated_event	  =  method(_self, function(_data) {
				var _port_index = _data.payload;
				if (_port_index == __.input_port_index) {
					activate();	
				}
			});
			port_deactivated_event	  =  method(_self, function(_data) {
				var _port_index = _data.payload;
				if (_port_index == __.input_port_index) {
					deactivate();	
				}
			});
			device_removed_event	  =  method(_self, function(_data) {
				var _device_data = _data.payload;
				var _device		 = _device_data.device;
				if (input_has_device(_device)) {
					input_remove_device(_device);
				}
			});
			port_activated_listener	  =  undefined;
			port_deactivated_listener =  undefined;
			device_removed_listener   =  undefined;
		};
	
		// events
		on_initialize(function() {
			__.port_activated_listener	 = iceberg.input.subscribe("port_activated",   __.port_activated_event);
			__.port_deactivated_listener = iceberg.input.subscribe("port_deactivated", __.port_deactivated_event);
			__.device_removed_listener	 = iceberg.input.subscribe("device_removed",   __.device_removed_event);
		});
		on_cleanup   (function() {
			iceberg.input.unsubscribe(__.port_activated_listener);
			iceberg.input.unsubscribe(__.port_deactivated_listener);
			iceberg.input.unsubscribe(__.device_removed_listener);
		});
	
	#endregion
	#region radio
	
		// public
		subscribe	= function(_event_name, _callback, _weak_ref = true) {
			return __.radio.instance.subscribe(_event_name, _callback, _weak_ref);	
		};
		unsubscribe = function(_listener, _force = true) {
			__.radio.instance.unsubcribe(_listener, _force);
			return self;
		};
		
		// private
		__[$ "radio"] ??= {};
		with (__.radio) {
			instance = new IB_Radio();	
			instance.register(
				"input_device_added",
				"input_device_set",
				"input_device_removed",
			);
		};
			
		// events
		on_initialize(function() {
			__.radio.instance.initialize();
		});
		on_cleanup   (function() {
			__.radio.instance.cleanup();
		});
	
	#endregion
	
	////////////////////////////////
	
	log("IB_Object_Player created");
	