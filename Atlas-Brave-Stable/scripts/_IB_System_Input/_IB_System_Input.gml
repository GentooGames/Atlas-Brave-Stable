
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   __   ______  __  __   ______  //
	// /\ \ /\ "-.\ \ /\  == \/\ \/\ \ /\__  _\ //
	// \ \ \\ \ \-.  \\ \  _-/\ \ \_\ \\/_/\ \/ //
	//  \ \_\\ \_\\"\_\\ \_\   \ \_____\  \ \_\ //
	//   \/_/ \/_/ \/_/ \/_/    \/_____/   \/_/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_System_Input(_config = {}) : IB_Base(_config) constructor {
		
		#region [info]
		/*	todo:
			- cursor should pull sense, accel, and fric from port's input profile data if assigned
		*/	
		#endregion
		
		static check_pressed			 = function(_port_index /* verb_1, ..., verb_n */) {
			for (var _i = 1; _i < argument_count; _i++) {
				var _verb = argument[_i];
				var _port = __.ports.get(_port_index);
				if (_port.check_pressed(_verb)) {
					return true;
				}	
			}
			return false;
		};
		static check_down				 = function(_port_index /* verb_1, ..., verb_n */) {
			for (var _i = 1; _i < argument_count; _i++) {
				var _verb = argument[_i];
				var _port = __.ports.get(_port_index);
				if (_port.check_down(_verb)) {
					return true;
				}	
			}
			return false;
		};
		static check_released			 = function(_port_index /* verb_1, ..., verb_n */) {
			for (var _i = 1; _i < argument_count; _i++) {
				var _verb = argument[_i];
				var _port = __.ports.get(_port_index);
				if (_port.check_released(_verb)) {
					return true;
				}	
			}
			return false;
		};
			
		static port_activate			 = function(_port_index, _input_devices = undefined) {
			var _port = __.ports.get(_port_index);
			_port.devices_set(_input_devices);
			_port.activate();
			__.radio.broadcast("port_activated", _port_index);
			__log("input port activated: " + string(_port_index), IB_LOG_FLAG.INPUT);
			return self;
		};
		static port_deactivate			 = function(_port_index) {
			var _port = __.ports.get(_port_index);
			_port.deactivate();
			__.radio.broadcast("port_deactivated", _port_index);
			__log("input port deactivated: " + string(_port_index), IB_LOG_FLAG.INPUT);
			return self;
		};
		static port_add_device			 = function(_port_index, _input_device) {
			var _port = __.ports.get(_port_index);
			_port.devices_add(_input_device);
			__log("input device " + instanceof(_input_device) + " added to port: " + string(_port_index), IB_LOG_FLAG.INPUT);
			return self;
		};
		static port_set_devices			 = function(_port_index, _devices_array) {
			var _port = __.ports.get(_port_index);
			_port.devices_set(_devices_array);
			__log("input devices set of size: " + string(array_length(_devices_array)), IB_LOG_FLAG.INPUT);
			return self;
		};
		static port_clear_devices		 = function(_port_index) {
			var _port = __.ports.get(_port_index);
			_port.devices_clear();
			__log("input devices cleard on port: " + string(_port_index), IB_LOG_FLAG.INPUT);
			return self;
		};
		static port_remove_device		 = function(_port_index, _input_device) {
			var _port = __.ports.get(_port_index);
			_port.devices_remove(_input_device);
			__log("input device " + instanceof(_input_device) + " removed from port: " + string(_port_index), IB_LOG_FLAG.INPUT);
			return self;
		};
		static port_set_profile			 = function(_port_index, _profile_name) {
			var _port	 = __.ports.get(_port_index);
			var _profile = __.profiles.get(_profile_name);
			_port.profile_set(_profile);
			__log("input profile " + _profile.get_name() + " set to port: " + string(_port_index), IB_LOG_FLAG.INPUT);
			return self;
		};
		static port_get					 = function(_port_index) {
			return __.ports.get(_port_index);
		};
		static port_get_count			 = function() {
			return __.port_count;	
		};
		static port_get_profile			 = function(_port_index) {
			var _port = __.ports.get(_port_index);
			return _port.profile_get();
		};
		static port_get_devices			 = function(_port_index) {
			var _port = __.ports.get(_port_index);
			return _port.devices_get();
		};
		static port_has_device_type		 = function(_port_index, _device_type) {
			var _port = __.ports.get(_port_index);
			return _port.devices_contains_type(_device_type);
		};
		static port_has_device			 = function(_port_index, _input_device = undefined) {
			var _port = __.ports.get(_port_index);
			return _port.devices_contains(_input_device);
		};
		static port_is_active			 = function(_port_index) {
			var _port = __.ports.get(_port_index);
			return _port.is_active();
		};
			
		static device_get				 = function(_device_type, _device_index) {
			return __.devices.total.get(_device_type + string(_device_index));
		};
		static device_get_keyboard		 = function(_device_index) {
			return __.devices.keyboard.get(_device_index);
		};
		static device_get_mouse			 = function(_device_index) {
			return __.devices.mouse.get(_device_index);
		};
		static device_get_keyboard_mouse = function(_device_index) {
			return __.devices.keyboard_mouse.get(_device_index);
		};
		static device_get_gamepad		 = function(_device_index) {
			return __.devices.gamepad.get(_device_index);
		};
		static device_get_total_devices	 = function() {
			var _items_struct = __.devices.total.get_items();
			return iceberg.struct.to_array(_items_struct);
		};
	
		static profile_get				 = function(_profile_name) {
			return __.profiles.get(_profile_name);
		};
		static profile_new				 = function(_profile_name, _port_index = undefined) {
			var _profile  = new __IB_System_Input_Profile({
				name:		_profile_name,
				port_index: _port_index,
			}).initialize();
			__.profiles.set(_profile_name, _profile);
		
			// auto assign to port?
			if (_port_index != undefined) {
				port_set_profile(_port_index, _profile_name);	
			}
			
			__log("input profile " + _profile_name + " created", IB_LOG_FLAG.INPUT);
			
			return _profile;
		};
		static profile_remove			 = function(_profile_name) {
			var _profile = __.profiles.get(_profile_name);
			__.profiles.remove(_profile_name);
			_profile.cleanup();
			__log("input profile " + _profile_name + " removed", IB_LOG_FLAG.INPUT);
			return self;
		};
	
		static mouse_did_move			 = function() {
			return (mouse_get_x() != mouse_get_x_previous()
				||	mouse_get_y() != mouse_get_y_previous()
			);
		};
		static mouse_get_x				 = function() {
			return __.mouse.position.current.x;
		};
		static mouse_get_y				 = function() {
			return __.mouse.position.current.y;
		};
		static mouse_get_x_previous		 = function() {
			return __.mouse.position.previous.x;
		};
		static mouse_get_y_previous		 = function() {
			return __.mouse.position.previous.y;
		};
	
		static subscribe				 = function(_event_name, _callback, _weak_ref = true) {
			return __.radio.subscribe(_event_name, _callback, _weak_ref);
		};
		static unsubcribe				 = function(_subscriber, _force = true) {
			__.radio.unsubscribe(_subscriber, _force);
			return self;
		};
	
		// private
		with (__) {
			static __async_system		   = function(_data) {
				var _gamepad_data = _data;
				switch (_gamepad_data[? "event_type"]) {
					case "gamepad discovered": {
						__log("gamepad_discovered w/pad_index= " + string(_gamepad_data[? "pad_index"]), IB_LOG_FLAG.INPUT);
						__new_gamepad(_gamepad_data[? "pad_index"]);
						break;	
					};
					case "gamepad lost": {
						__log("gamepad_lost w/pad_index= " + string(_gamepad_data[? "pad_index"]), IB_LOG_FLAG.INPUT);
						__remove_gamepad(_gamepad_data[? "pad_index"]);
						break;	
					};
				};	
			};
			static __new_keyboard		   = function(_device_index = __.devices.keyboard.get_size()) {
				var _device = new __IB_System_Input_Device_Keyboard({
					device_index: _device_index,
				}).initialize();
				__.devices.keyboard.set(_device_index, _device);
				__.devices.total.set("keyboard" + string(_device_index), _device);
				__.radio.broadcast("keyboard_device_created", {
					type:   "keyboard",
					index:  _device_index,
					device: _device,
				});
				__.radio.broadcast("device_created", {
					type:   "keyboard",
					index:  _device_index,
					device: _device,
				});
				__log("keyboard_device_created w/device_index= " + string(_device_index), IB_LOG_FLAG.INPUT);
				return _device;
			};
			static __new_mouse			   = function(_device_index = __.devices.mouse.get_size()) {
				var _device = new __IB_System_Input_Device_Mouse({
					device_index: _device_index,
				}).initialize();
				__.devices.mouse.set(_device_index, _device);
				__.devices.total.set("mouse" + string(_device_index), _device);
				__.radio.broadcast("mouse_device_created", {
					type:   "mouse",
					index:  _device_index,
					device: _device,
				});
				__.radio.broadcast("device_created", {
					type:   "mouse",
					index:  _device_index,
					device: _device,
				});
				__log("mouse_device_created w/device_index= " + string(_device_index), IB_LOG_FLAG.INPUT);
				return _device;
			};
			static __new_keyboard_mouse    = function(_device_index = __.devices.keyboard_mouse.get_size()) {
				var _device = new __IB_System_Input_Device_KeyboardMouse({
					device_index: _device_index,
				}).initialize();
				__.devices.keyboard_mouse.set(_device_index, _device);
				__.devices.total.set("keyboard_mouse" + string(_device_index), _device);
				__.radio.broadcast("keyboard_mouse_device_created", {
					type:   "keyboard_mouse",
					index:  _device_index,
					device: _device,
				});
				__.radio.broadcast("device_created", {
					type:   "keyboard_mouse",
					index:  _device_index,
					device: _device,
				});
				__log("keyboard_mouse_device_created w/device_index= " + string(_device_index), IB_LOG_FLAG.INPUT);
				return _device;
			};
			static __new_gamepad		   = function(_device_index = __.devices.gamepad.get_size()) {
				var _device = new __IB_System_Input_Device_Gamepad({
					device_index: _device_index,
					guid:		   gamepad_get_guid(_device_index),
					description:   gamepad_get_description(_device_index),
				}).initialize();
				__.devices.gamepad.set(_device_index, _device);
				__.devices.total.set("gamepad" + string(_device_index), _device);
				__.radio.broadcast("gamepad_device_created", {
					type:   "gamepad",
					index:  _device_index,
					device: _device,
				});
				__.radio.broadcast("device_created", {
					type:   "gamepad",
					index:  _device_index,
					device: _device,
				});
				__log("gamepad_device_created w/device_index= " + string(_device_index), IB_LOG_FLAG.INPUT);
				return _device;
			};
			static __new_port			   = function(_port_index   = __.ports.get_size(), _port_active = false) {
				var _port = new __IB_System_Input_Port({
					active:		_port_active,
					port_index: _port_index,
				}).initialize();
				__.ports.set(_port_index, _port);
				__.radio.broadcast("port_created", _port_index);
				return _port;
			};
			static __remove_keyboard	   = function(_device_index = __.devices.keyboard.get_size() - 1) {
				var _device = __.devices.keyboard.get(_device_index);
				__.devices.keyboard.remove(_device_index);
				__.devices.total.remove("keyboard" + string(_device_index));
				__.radio.broadcast("keyboard_device_removed", {
					type:	"keyboard",
					index:	_device_index,
					device: _device,
				});
				__.radio.broadcast("device_removed", {
					type:	"keyboard",
					index:	_device_index,
					device: _device,
				});
				return _device;
			};
			static __remove_mouse		   = function(_device_index = __.devices.mouse.get_size() - 1) {
				var _device = __.devices.mouse.get(_device_index);
				__.devices.mouse.remove(_device_index);
				__.devices.total.remove("mouse" + string(_device_index));
				__.radio.broadcast("mouse_device_removed", {
					type:	"mouse",
					index:	_device_index,
					device: _device,
				});
				__.radio.broadcast("device_removed", {
					type:	"mouse",
					index:	_device_index,
					device: _device,
				});
				return _device;
			};
			static __remove_keyboard_mouse = function(_device_index = __.devices.keyboard_mouse.get_size() - 1) {
				var _device = __.devices.keyboard_mouse.get(_device_index);
				__.devices.keyboard_mouse.remove(_device_index);
				__.devices.total.remove("keyboard_mouse" + string(_device_index));
				__.radio.broadcast("keyboard_mouse_device_removed", {
					type:	"keyboard_mouse",
					index:	_device_index,
					device: _device,
				});
				__.radio.broadcast("device_removed", {
					type:	"keyboard_mouse",
					index:	_device_index,
					device: _device,
				});
				return _device;
			};
			static __remove_gamepad		   = function(_device_index = __.devices.gamepad.get_size() - 1) {
				var _device = __.devices.gamepad.get(_device_index);
				__.devices.gamepad.remove(_device_index);
				__.devices.total.remove("gamepad" + string(_device_index));
				__.radio.broadcast("gamepad_device_removed", {
					type:	"gamepad",
					index:	_device_index,
					device: _device,
				});
				__.radio.broadcast("device_removed", {
					type:	"gamepad",
					index:	_device_index,
					device: _device,
				});
				return _device;
			};
			static __remove_port		   = function(_port_index   = __.ports.get_size() - 1) {
				var _port = __.ports.get(_port_index);
				__.ports.remove(_port_index);
				__.radio.broadcast("port_removed", _port_index);
				return _port;
			};
			static __update_mouse_position = function(_device_index = 0) {
				__.mouse.position.previous.x = __.mouse.position.current.x;
				__.mouse.position.previous.y = __.mouse.position.current.y;
				__.mouse.position.current.x  = device_mouse_x(_device_index);
				__.mouse.position.current.y  = device_mouse_y(_device_index);
			};
				
			#region // radio ///////////////
			
				radio = new IB_Radio();
				radio.register(
					"port_created",
					"port_removed",
					"port_activated",
					"port_deactivated",
					"keyboard_device_created",
					"mouse_device_created",
					"keyboard_mouse_device_created",
					"gamepad_device_created",
					"device_created",
					"keyboard_device_removed",
					"mouse_device_removed",
					"keyboard_mouse_device_removed",
					"gamepad_device_removed",
					"device_removed",
				);
			
			#endregion
			
			devices					 =  { 
				defaults:		[],
				total:			new IB_Collection_Struct(),
				keyboard:		new IB_Collection_Struct(),
				mouse:			new IB_Collection_Struct(),
				keyboard_mouse: new IB_Collection_Struct(),
				gamepad:		new IB_Collection_Struct(),
			};	
			mouse					 =  {
				position: {
					current:  {
						x: 0,
						y: 0,
					},
					previous: {
						x: 0,
						y: 0,
					},
				},
			};
			keybindings_default		 =  {
				keyboard:		{
					left:	[{
						keys: [ vk_left, ord("A") ],
					}],
					right:	[{
						keys: [ vk_right, ord("D") ],
					}],
					up:		[{
						keys: [ vk_up, ord("W") ],
					}],
					down:	[{
						keys: [ vk_down, ord("S") ],
					}],
					select:	[{
						keys: [ ord("X"), ord("J"), vk_enter ],
					}],
					back:	[{
						keys: [ ord("Z"), ord("K"), vk_backspace, vk_escape ],
					}],
				},
				mouse:			{
					select: [{
						keys: [ mb_left ],
					}],
					back:   [{
						keys: [ mb_right ],
					}],
				},
				keyboard_mouse: {
					left:	[{
						keys: [ vk_left, ord("A") ],
					}],
					right:	[{
						keys: [ vk_right, ord("D") ],
					}],
					up:		[{
						keys: [ vk_up, ord("W") ],
					}],
					down:	[{
						keys: [ vk_down, ord("S") ],
					}],
					select:	[{
						keys: [ ord("X"), ord("J"), vk_enter, mb_left ],
					}],
					back:	[{
						keys: [ ord("Z"), ord("K"), vk_backspace, vk_escape, mb_right ],
					}],
				},
				gamepad:		{
					left: [
						{ // button
							keys: [ gp_padl ],
						},
						{ // axis
							keys: [ gp_axislh ],
							operator: "<",
							value: 0,
						},
					],
					right: [
						{ // button
							keys: [ gp_padr ],
						},
						{ // axis
							keys: [ gp_axislh ],
							operator: ">",
							value: 0,
						},
					],
					up: [
						{ // button
							keys: [ gp_padu ],
						},
						{ // axis
							keys: [ gp_axislv ],
							operator: "<",
							value: 0,
						},
					],
					down: [
						{ // button
							keys: [ gp_padd ],
						},
						{ // axis
							keys: [ gp_axislv ],
							operator: ">",
							value: 0,
						},
					],
					select: [{
						keys: [ gp_face1 ],	
					}],
					back:   [{
						keys: [ gp_face2 ],	
					}],
				},
			};
			keybindings				 =  global.keybindings_default; // keybindings_default;
			ports					 =  new IB_Collection_Struct();
			profiles				 =  new IB_Collection_Struct();
			port_count				 =  IB_CONFIG.player.max_count;
			gamepad_deadzone_default = _config[$ "gamepad_deadzone_default"] ?? 0.1;
			cursor_sense_default	 = _config[$ "cursor_sense_default"	   ] ?? 10;
			cursor_accel_default	 = _config[$ "cursor_accel_default"	   ] ?? 0.2;
			cursor_fric_default		 = _config[$ "cursor_fric_default"	   ] ?? 0.3;
		};
			
		// events
		on_initialize(function() {
			
			__.radio.initialize();
				
			// init ports
			repeat (__.port_count) { __new_port(); };
			
			// init devices
			array_push(__.devices.defaults, __new_keyboard_mouse(0));
			
			// activate port with devices
			port_activate(0, __.devices.defaults);
		});
		on_update	 (function() {
			__.devices.total.for_each(function(_device) {
				_device.update();
			});
			__update_mouse_position();
		});
		on_cleanup   (function() {
			__.ports.cleanup();
			__.profiles.cleanup();
			__.devices.total.cleanup();
			__.devices.keyboard.cleanup();
			__.devices.mouse.cleanup();
			__.devices.keyboard_mouse.cleanup();
			__.devices.gamepad.cleanup();
			__.radio.cleanup();
		});
	};
	

	