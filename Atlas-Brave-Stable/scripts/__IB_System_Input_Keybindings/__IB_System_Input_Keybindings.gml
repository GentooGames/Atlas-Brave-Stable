
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   ______   __  __   ______   __   __   __   _____    ______    //
	// /\ \/ /  /\  ___\ /\ \_\ \ /\  == \ /\ \ /\ "-.\ \ /\  __-. /\  ___\   //
	// \ \  _"-.\ \  __\ \ \____ \\ \  __< \ \ \\ \ \-.  \\ \ \/\ \\ \___  \  //
	//  \ \_\ \_\\ \_____\\/\_____\\ \_____\\ \_\\ \_\\"\_\\ \____- \/\_____\ //
	//   \/_/\/_/ \/_____/ \/_____/ \/_____/ \/_/ \/_/ \/_/ \/____/  \/_____/ //
	//																		  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Keybindings(_config = {}) : IB_Base(_config) constructor {
		
		// public
		static check_pressed				 = function(_verb, _device_index, _type = type) {
			if (is_active()) {
				var _keybinds_array = __get_keybinds_array(_verb, _type);
				if (_keybinds_array == undefined) return false;
				for (var _i = 0, _len = array_length(_keybinds_array); _i < _len; _i++) {
					var _keybind = _keybinds_array[_i];
					if (_keybind.check_pressed(_device_index)) {
						return true;	
					}
				};
			}
			return false;
		};
		static check_down					 = function(_verb, _device_index, _type = type) {
			if (is_active()) {
				var _keybinds_array = __get_keybinds_array(_verb, _type);
				if (_keybinds_array == undefined) return false;
				for (var _i = 0, _len = array_length(_keybinds_array); _i < _len; _i++) {
					var _keybind = _keybinds_array[_i];
					if (_keybind.check_down(_device_index)) {
						return true;	
					}
				};
			}
			return false;
		};
		static check_released				 = function(_verb, _device_index, _type = type) {
			if (is_active()) {
				var _keybinds_array = __get_keybinds_array(_verb, _type);
				if (_keybinds_array == undefined) return false;
				for (var _i = 0, _len = array_length(_keybinds_array); _i < _len; _i++) {
					var _keybind = _keybinds_array[_i];
					if (_keybind.check_released(_device_index)) {
						return true;	
					}
				};
			}
			return false;
		};

		static device_get					 = function() {
			return __.device;	
		};
		static device_set					 = function(_device) {
			__.device = _device;
			return self;
		};

		static keybindings_add				 = function(_keybindings_struct) {
			__add_keybindings(_keybindings_struct);
			return self;
		};
		static keybindings_clear			 = function() {
			keybind_clear_keyboard();
			keybind_clear_mouse();
			keybind_clear_keyboard_mouse();
			keybind_clear_gamepad();
			return self;
		};
		static keybindings_remove			 = function() {
			keybindings_clear();
			return self;
		};
		static keybindings_set				 = function(_keybindings_struct) {
			keybindings_clear();
			keybindings_add(_keybindings_struct);
			return self;
		};
		
		static keybind_set_keyboard			 = function(_verb, _keys_array, _operator = "=", _value = 1) {
			__set_keybind("keyboard", _verb, _keys_array, _operator, _value);
			return self;
		};
		static keybind_set_mouse			 = function(_verb, _keys_array, _operator = "=", _value = 1) {
			__set_keybind("mouse", _verb, _keys_array, _operator, _value);
			return self;
		};
		static keybind_set_keyboard_mouse	 = function(_verb, _keys_array, _operator = "=", _value = 1) {
			__set_keybind("keyboard_mouse", _verb, _keys_array, _operator, _value);
			return self;
		};
		static keybind_set_gamepad			 = function(_verb, _keys_array, _operator = "=", _value = 1) {
			__set_keybind("gamepad", _verb, _keys_array, _operator, _value);
			return self;
		};
		static keybind_add_keyboard			 = function(_verb, _keys_array, _operator = "=", _value = 1) {
			__add_keybind("keyboard", _verb, _keys_array, _operator, _value);
			return self;
		};
		static keybind_add_mouse			 = function(_verb, _keys_array, _operator = "=", _value = 1) {
			__add_keybind("mouse", _verb, _keys_array, _operator, _value);
			return self;
		};
		static keybind_add_keyboard_mouse	 = function(_verb, _keys_array, _operator = "=", _value = 1) {
			__add_keybind("keyboard_mouse", _verb, _keys_array, _operator, _value);
			return self;
		};
		static keybind_add_gamepad			 = function(_verb, _keys_array, _operator = "=", _value = 1) {
			__add_keybind("gamepad", _verb, _keys_array, _operator, _value);
			return self;
		};
		static keybind_remove_keyboard		 = function(_verb) {
			__remove_keybind("keyboard", _verb);
			return self;
		};
		static keybind_remove_mouse			 = function(_verb) {
			__remove_keybind("mouse", _verb);
			return self;
		};
		static keybind_remove_keyboard_mouse = function(_verb) {
			__remove_keybind("keyboard_mouse", _verb);
			return self;
		};
		static keybind_remove_gamepad		 = function(_verb) {
			__remove_keybind("gamepad", _verb);
			return self;
		};
		static keybind_clear_keyboard		 = function() {
			__.keyboard.clear();
			return self;
		};
		static keybind_clear_mouse			 = function() {
			__.mouse.clear();
			return self;
		};
		static keybind_clear_keyboard_mouse  = function() {
			__.keyboard_mouse.clear();
			return self;
		};
		static keybind_clear_gamepad		 = function() {
			__.gamepad.clear();
			return self;
		};
			
		// private
		with (__) {
			static __add_keybind		   = function(_type, _verb, _keys_array, _operator = "=", _value = 1) {
				
				var _keybindings	= __get_keybind_container(_type);
				var _keybinds_array	= _keybindings.get(_verb);
				if (_keybinds_array == undefined) {
					_keybinds_array = [];
					_keybindings.set(_verb, _keybinds_array);
				}
			
				var _keybind_class = __get_keybind_class(_type);
				var _keybind	   = new _keybind_class({
					verb:	  _verb,	
					keys:	  _keys_array,
					operator: _operator,
					value:	  _value,
				});
				
				array_push(_keybinds_array, _keybind);
				
				return _keybind;
			};
			static __add_keybindings	   = function(_keybindings_struct) {
			  __add_keybindings_type(_keybindings_struct, "keyboard",		keybind_add_keyboard	  );
			  __add_keybindings_type(_keybindings_struct, "mouse",			keybind_add_mouse		  );
			  __add_keybindings_type(_keybindings_struct, "keyboard_mouse", keybind_add_keyboard_mouse);
			  __add_keybindings_type(_keybindings_struct, "gamepad",		keybind_add_gamepad		  );
			};
			static __add_keybindings_type  = function(_keybindings_struct, _type, _add_keybind_function) {
				var _bindings  = _keybindings_struct[$ _type];
				if (_bindings !=  undefined) {
					var _verbs		 = variable_struct_get_names(_bindings);
					var _verbs_count = variable_struct_names_count(_bindings);
				
					for (var _i = 0; _i < _verbs_count; _i++) {
						var _verb	  = _verbs[_i];
						var _keybinds = _bindings[$ _verb];
					
						for (var _j = 0, _len_j = array_length(_keybinds); _j < _len_j; _j++) {
							var _data = _keybinds[_j];
							var _keys = _data[$ "keys"];
							if (_keys == undefined) continue;	
							////////////////////////////
							var _operator = _data[$ "operator"] ?? "=";
							var _value	  = _data[$ "value"   ] ?? 1;
							_add_keybind_function(_verb, _keys, _operator, _value);	
						};
					};
				}
			};
			static __get_keybind_class	   = function(_type) {
				switch (_type) {
					case "keyboard":	   return __IB_System_Input_Keybind_Keyboard;
					case "mouse":		   return __IB_System_Input_Keybind_Mouse;
					case "keyboard_mouse": return __IB_System_Input_Keybind_KeyboardMouse;
					case "gamepad":		   return __IB_System_Input_Keybind_Gamepad;
				};
				return undefined;
			};
			static __get_keybind_container = function(_type) {
				switch (_type) {
					case "keyboard":	   return __.keyboard;
					case "mouse":		   return __.mouse;
					case "keyboard_mouse": return __.keyboard_mouse;
					case "gamepad":		   return __.gamepad;
				};
				return undefined;
			};
			static __get_keybinds_array	   = function(_verb, _type) {
				var _container = __get_keybind_container(_type);
				return _container.get(_verb);
			};
			static __remove_keybind		   = function(_type, _verb) {
				var _keybindings	 = __get_keybind_container(_type);
				var _keybinds_array	 = _keybindings.get(_verb);
				if (_keybinds_array != undefined) {
					for (var _i = array_length(_keybinds_array); _i >= 0; _i--) {
						var _keybind_class_instance = _keybinds_array[_i];
						if (_keybind_class_instance.verb == _verb) {
							array_delete(_keybinds_array, _i, 1);
						}
					};
				}
			};
			static __set_keybind		   = function(_type, _verb, _keys_array, _operator = "=", _value = 1) {
				
				var _keybindings	= __get_keybind_container(_type);
				var _keybinds_array	= _keybindings.get(_verb);
			
				if (_keybinds_array == undefined) {
				  __add_keybind(_type, _verb, _keys_array, _operator, _value);
					exit;
				}
				for (var _i = 0, _len = array_length(_keybinds_array); _i < _len; _i++) {
					var _keybind_class_instance = _keybinds_array[_i];
					if (_keybind_class_instance.verb == _verb) {
						_keybind_class_instance.keys	 = _keys_array;
						_keybind_class_instance.operator = _operator;
						_keybind_class_instance.value	 = _value;
					}
				};
			};
			
			type		   = _config[$ "type"		] ?? "keyboard";
			device		   = _config[$ "device"	    ] ?? undefined;
			keybindings    = _config[$ "keybindings"] ?? {};
			gamepad		   =  new IB_Collection_Struct();
			keyboard	   =  new IB_Collection_Struct();
			keyboard_mouse =  new IB_Collection_Struct();
			mouse		   =  new IB_Collection_Struct();
		};
			
		// events
		on_initialize(function() {
			__add_keybindings(__.keybindings);
		});
	};

