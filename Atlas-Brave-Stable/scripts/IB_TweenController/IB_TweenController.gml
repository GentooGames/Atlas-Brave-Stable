
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __     __   ______   ______   __   __    //
	// /\__  _\/\ \  _ \ \ /\  ___\ /\  ___\ /\ "-.\ \   //
	// \/_/\ \/\ \ \/ ".\ \\ \  __\ \ \  __\ \ \ \-.  \  //
	//    \ \_\ \ \__/".~\_\\ \_____\\ \_____\\ \_\\"\_\ //
	//     \/_/  \/_/   \/_/ \/_____/ \/_____/ \/_/ \/_/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //	
	function IB_TweenController(_config = {}) : IB_Base(_config) constructor {

		#region docs
		/*
			// instantiate tween
			tween = new IB_TweenController().initialize();
	
			// defined first custom curve
			tween.create("my_tween_1", {
				value_begin:	0,
				value_end:		5,
				curve_index:	IB_TweenController_Curves,
				curve_channel: "linear",
				duration:		SECOND * 1,
			});
		
			// assigned curve callbacks
			tween.on_start("my_tween_1", function(_tween) {
				show_debug_message("tween start: " + _tween.get_name());	
			});
		
			// make sure to call update on tween
			on_update(function() {
				tween.update();
			});
		*/
		#endregion

		// public
		static create_tween			= function(_name, _config = {}, _auto_destroy = true) {
			
			_config[$ "name"		]   = _name;
			_config[$ "running"		] ??= __.start_running;
			_config[$ "value_begin" ] ??= 0;
			_config[$ "value_end"   ] ??= 1;
			_config[$ "auto_destroy"] ??= _auto_destroy;
			
			var _instance = new IB_TweenCurve(_config);
				_instance.initialize();
			
			__.curves.set(_name, _instance);
			
			return _instance;
		};
		static destroy_tween		= function(_curve_name) {
			var _curve = __.curves.get(_curve_name);
			if (_curve != undefined) {
			
				// remove curve from stack
				__.curves.remove(_curve_name);
			
				// cleanup curve class instance
				_curve.cleanup();
			}
			return self;
		};
		static start_tween			= function(_curve_name, _t = 0, _on_stop_callback = undefined) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.start(_t, _on_stop_callback);
			}
			return self;
		};
		static stop_tween			= function(_curve_name, _execute_callbacks = true) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.stop(_execute_callbacks);
			}
			return self;
		};
		static pause_tween			= function(_curve_name) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.pause();
			}
			return self;
		};
		static get_tween_value		= function(_curve_name) {	
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				return _curve.get_value_curve();
			}
			return 0;
		};
		static get_tween_value_step = function(_curve_name) { //*new
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				return _curve.get_value_step();
			}
			return 0;
		};
		static is_tween_running		= function(_curve_name) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				return _curve.is_running();	
			}
			return false;
		};
		static on_tween_start		= function(_curve_name, _callback) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.on_start(_callback);	
			}
			return self;
		};
		static on_tween_stop		= function(_curve_name, _callback) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.on_stop(_callback);	
			}
			return self;
		};
		
		// private
		with (__) {
			start_running	   = _config[$ "start_running"] ?? false;
			curves			   = new IB_Collection_Struct();
			on_start_callbacks = [];
			on_stop_callbacks  = [];
		};
		
		// events
		on_update (function() {
			__.curves.for_each(function(_curve) {
				_curve.update();
			});
		});
		on_cleanup(function() {
			__.curves.for_each(function(_curve) {
				_curve.cleanup();
			});
		});
	};
	function IB_TweenCurve(_config = {}) constructor {
			
		var _self  = self;
		var _owner = other;
			
		// public
		static start				= function(_t = 0, _on_stop_callback = undefined) {
			__.t					 = _t;
			__.on_stop_temp_callback = _on_stop_callback;
			__.delay_timer			 = __.delay_time;
			__.running				 = true;
			__on_start();	
			return self;
		};
		static stop					= function(_execute_callbacks = true) {
			switch (__.on_stop_behavior) {
				case "bounce": __on_stop_bounce(_execute_callbacks); break;
				case "stop":   __on_stop_stop(_execute_callbacks);   break;
			};
			return self;
		};
		static pause				= function() {
			__.running = false;
			return self;
		};
		static is_running			= function() {
			return __.running;	
		};
		static on_start				= function(_callback) {
			array_push(__.on_start_callbacks, _callback);
			return self;
		};
		static on_stop				= function(_callback) {
			array_push(__.on_stop_callbacks, _callback);
			return self;
		};
			
		static get_name				= function() {
			return __.name;	
		};
		static get_delay_time		= function() {
			return __.delay_time;
		};
		static get_delay_time_left	= function() {
			return __.delay_timer;
		};
		static get_value_curve		= function() {
			var _sign = sign(__.speed);
			if (__.ease_function != undefined) {
				var _value = __.ease_function(__.t, __.value_begin, __.value_end, __.duration);
				return _value * _sign;
			}
			else {
				var _channel = animcurve_get_channel(__.curve_index, __.curve_channel);
				var _value	 = animcurve_channel_evaluate(_channel, __.t)
				var _mapped  = iceberg.math.remap(0, 1, __.value_begin, __.value_end, _value);
				return _mapped * _value;
			}
		};
		static get_value_step		= function() {
			return __.value_step;
		}
		static get_value_begin		= function() {
			return __.value_begin;
		};
		static get_value_end		= function() {
			return __.value_end;	
		};
			
		static set_value_begin		= function(_value_begin) {
			__.value_begin = _value_begin;
			return self;
		};
		static set_value_end		= function(_value_end) {
			__.value_end = _value_end;
			return self;
		};
		static set_curve_index		= function(_curve_index) {
			__.curve_index = _curve_index;
			return self;
		};
		static set_curve_channel	= function(_channel_index) {
			__.curve_channel = _channel_index;
			return self;
		};
		static set_ease_function	= function(_ease_function) {
			__.ease_function = _ease_function;
			return self;
		};
		static set_duration			= function(_duration) {
			__.duration = _duration;
			__.speed	= 1 / __.duration;
			return self;
		};
		static set_delay_time		= function(_delay) {
			__.delay_time = _delay;
			return self;
		};
		static set_on_stop_behavior = function(_on_stop_behavior) {
			__.on_stop_behavior = _on_stop_behavior;
			return self;
		};
		
		// private
		__ = {};
		with (__) {
			static __update_t		   = function() {
				if (__.delay_timer <= 0) {
					__.t = clamp(__.t + __.speed, 0, 1);
					if (__.t >= 1 && sign(__.speed) ==  1) stop(true); 
					if (__.t <= 0 && sign(__.speed) == -1) stop(true);
				}
			}; 
			static __update_var		   = function() {
				if (__.var_name != undefined) {
					
					// get curve value
					var _value = get_value_step(); //*new
					
					// check for curve scalar
					if (__.var_value != undefined) {
						_value *= __.var_value;
					}
					
					// method invocation
					if (__.var_is_method) {
						__.var_owner[$ __.var_name](_value, __.direction); //*new - obj character move_adjust_by_value - line 852
					}
					// standard assignment
					else {
						__.var_owner[$ __.var_name] = _value;
					}
				}
			};
			static __update_delay	   = function() {
				if (__.delay_timer > 0) {
					__.delay_timer--;	
				}
			};
			static __update_value_step = function() { //*new
				var _value = get_value_curve();
				__.value_step = _value - __.value_prev;
				__.value_prev = _value;
			}
			static __on_start		   = function() {
				iceberg.array.for_each(__.on_start_callbacks, function(_callback) {
					_callback(self);
				});
			};
			static __on_stop		   = function() {
				iceberg.array.for_each(__.on_stop_callbacks, function(_callback) {
					_callback(self);
				});
				if (__.on_stop_temp_callback != undefined) {
					__.on_stop_temp_callback(self);	
				}
			};
			static __on_stop_stop	   = function(_execute_callbacks) {
				__.running = false;
				__.t	   = 0;
				if (_execute_callbacks) __on_stop();	
				if (__.auto_destroy) __.owner.destroy_tween(get_name());	
			};
			static __on_stop_bounce    = function(_execute_callbacks) {
				__.speed *= -1;
			};
			
			owner			 = _config[$ "owner"		   ] ?? _owner;
			initialized		 = _config[$ "initialized"	   ] ?? false;
			active			 = _config[$ "active"		   ] ?? true;
			name			 = _config[$ "name"			   ] ?? instanceof(_self);
							 	   
			value_begin		 = _config[$ "value_begin"	   ] ?? 0;
			value_end		 = _config[$ "value_end"	   ] ?? 1;
			curve_index		 = _config[$ "curve_index"     ] ?? IB_TweenController_Curves;
			curve_channel	 = _config[$ "curve_channel"   ] ?? "linear";
			ease_function	 = _config[$ "ease_function"   ] ?? undefined;
			duration		 = _config[$ "duration"		   ] ?? room_speed;
			delay_time		 = _config[$ "delay_time"	   ] ?? 0;
			running			 = _config[$ "running"		   ] ?? true;
			auto_destroy	 = _config[$ "auto_destroy"	   ] ?? true;
			var_owner		 = _config[$ "var_owner"	   ] ?? undefined;
			var_name		 = _config[$ "var_name"		   ] ?? undefined;
			var_value		 = _config[$ "var_value"	   ] ?? undefined;
			on_stop_behavior = _config[$ "on_stop_behavior"] ?? "stop";
			direction		 = _config[$ "direction"	   ] ?? undefined; //*new
			
			on_start_callbacks	  = [];
			on_stop_callbacks	  = [];
			on_stop_temp_callback = undefined;
			speed				  = 1 / duration;
			t					  = 0;
			delay_timer			  = 0;
			var_is_method		  = false;
			
			value_prev			  = 0; //*new
			value_step			  = 0; //*new
			
			// check if var binding is method
			if (var_name != undefined) {
				var_is_method = is_method(var_owner[$ var_name]);
			}
		};
		
		// events
		static initialize = function() {
			__.initialized = true;
			return self;
		};	
		static activate   = function() {
			__.active = true;
			return self;
		};
		static deactivate = function() {
			__.active = false;
			return self;
		};
		static update	  = function() {
			if (__.active 
			&&	__.initialized 
			&&	__.running
			) {
				__update_delay();
				__update_t();
				__update_var();
				__update_value_step();
			}
		};
		static cleanup	  = function() {
			// compatibility ...
		};
	};
	