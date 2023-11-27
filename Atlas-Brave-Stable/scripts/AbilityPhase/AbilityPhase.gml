
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __  __   ______   ______   ______    //
	// /\  == \/\ \_\ \ /\  __ \ /\  ___\ /\  ___\   //
	// \ \  _-/\ \  __ \\ \  __ \\ \___  \\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_\ \_\\/\_____\\ \_____\ //
	//   \/_/    \/_/\/_/ \/_/\/_/ \/_____/ \/_____/ //
	//                                               //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function AbilityPhase(_ability, _character, _config = {}) : IB_Base(_config) constructor {
		
		var _self = self;
		
		// public
		static start			  = function(_on_complete = undefined) {
			__.on_complete_temp  = _on_complete;
			__.charge_amount =  0;
			__.timer = 0;
			blackboard_clear();
			__on_start();
		};
		static complete			  = function(_success = undefined) {
			if (_success == true ) __on_success();
			if (_success == false) __on_fail();
			__on_complete();
		};
		static cancel			  = function() {
			__on_cancel();
		};
		static animation_end	  = function() {
			__on_animation_end();	
		};
								    
		static on_start			  = function(_callback, _data) {
			array_push(__.on_start_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_complete		  = function(_callback, _data) {
			array_push(__.on_complete_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_success		  = function(_callback, _data) {
			array_push(__.on_success_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_fail			  = function(_callback, _data) {
			array_push(__.on_fail_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_cancel		  = function(_callback, _data) {
			array_push(__.on_cancel_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_running		  = function(_callback, _data) {
			array_push(__.on_running_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_animation_end   = function(_callback, _data) {
			array_push(__.on_animation_end_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
								    
		static get_index		  = function() {
			return __.phase_id;
		};
		static get_duration		  = function() {
			return __.duration;	
		};
		static get_uses_speed	  = function() {
			return __.uses_speed;	
		};
		static get_input_window	  = function() {
			return __.input_window;
		};
		static get_input_limit	  = function() {
			return __.input_limit;	
		};
		static get_sprite_prefix  = function() {
			return __.sprite_prefix;	
		};
		static get_sprite_key	  = function() {
			return __.sprite_key;	
		};
								    
		static charge_is_charged  = function() {
			return __.charged;
		};
		static charge_get_amount  = function() {
			return __.charge_amount;
		};
		static charge_get_max	  = function() {
			return __.charge_max;
		};
		static charge_get_percent = function() {
			var _limit  = charge_get_max();
			if (_limit == 0) return 0;	
			return charge_get_amount() / _limit;	
		};
			
		static buffer_get		  = function() {
			return __.buffered;	
		};
		static buffer_set		  = function(_buffer) {
			__.buffered = _buffer;	
		};
		static buffer_reset		  = function() {
			__.buffered = false;	
		};
			
		static blackboard_write	  = function(_name, _value) {
			__.blackboard[$ _name] = _value;
		};
		static blackboard_read	  = function(_name) {
			return __.blackboard[$ _name];
		};
		static blackboard_erase	  = function(_name) {
			variable_struct_remove(__.blackboard, _name);
		};
		static blackboard_clear	  = function() {
			__.blackboard = {};
		};
		
		// private
		with (__) {
			static __check_goto_next_phase	= function() {
				if (__.goto_next_phase != undefined
				&&	__.goto_next_phase(__.character, __.ability, self)
				) {
					return true;
				}
				return false;
			};
			static __update_charge			= function() {
				if (__.charge_rate > 0 && __.charge_max > 0) {
					__.charge_amount += __.charge_rate;
					__.charge_amount  = min(__.charge_amount, __.charge_max);
					__.charged		  = __.charge_amount >= __.charge_min;
				}
			};
			static __on_callback			= function(_callback_array) {
				for (var _i = 0, _len = array_length(_callback_array); _i < _len; _i++) {
					var _callback = _callback_array[_i];
					_callback.callback(__.character, __.ability, self, _callback.data);
				};
			};
			static __on_start				= function() {
				if (__.on_start_callback != undefined) {
					__.on_start_callback(__.character, __.ability, self);	
				}
				__on_callback(__.on_start_callbacks);
			};
			static __on_complete			= function() {
				if (__.on_complete_callback != undefined) {
					__.on_complete_callback(__.character, __.ability, self);	
				}				  
				__on_callback(__.on_complete_callbacks);
				if (__.on_complete_temp != undefined) {
					__.on_complete_temp();
				}				  
			};				
			static __on_success				= function() {
				if (__.on_success_callback != undefined) {
					__.on_success_callback(__.character, __.ability, self);	
				}
				__on_callback(__.on_success_callbacks);
			};
			static __on_fail				= function() {
				if (__.on_fail_callback != undefined) {
					__.on_fail_callback(__.character, __.ability, self);	
				}
				__on_callback(__.on_fail_callbacks);
			};
			static __on_cancel				= function() {
				if (__.on_cancel_callback != undefined) {
					__.on_cancel_callback(__.character, __.ability, self);	
				}
				__on_callback(__.on_cancel_callbacks);
			};
			static __on_running				= function() {
				if (__.on_running_callback != undefined) {
					__.on_running_callback(__.character, __.ability, self);	
				}
				__on_callback(__.on_running_callbacks);
			};
			static __on_animation_end		= function() {
				if (__.on_animation_end_callback != undefined) {
					__.on_animation_end_callback(__.character, __.ability, self);	
				}
				__on_callback(__.on_animation_end_callbacks);
			};
			static __construct_sprite_names = function() {
				
				var _ability_name = asset_get_name(__.ability.get_name());
				var _char_name	  =	asset_get_name(__.character.get_uid());
				var _char_length  = string_length(_char_name);
				var _ability_type = __.ability.get_type();
				var _phase_count  =	__.ability.get_phase_count();
				var _phase_string = "_" + string(__.phase_id);
				
				if (_phase_count == 1) _phase_string = "";
				
				__.sprite_prefix = (_ability_type == ABILITY.BASIC)
					? ("spr_" + _ability_name + _phase_string)
					: ("spr_" + _char_name + "_" + _ability_name + _phase_string);
				
				__.sprite_key	 = string_delete(__.sprite_prefix, 1, _char_length + 5);
			};
			
			ability					  = _ability;
			character				  = _character;
			phase_id				  = _config[$ "phase_id"		] ?? 0;
			duration				  = _config[$ "duration"		] ?? 0;
			uses_speed				  = _config[$ "uses_speed"		] ?? false;
			repetitions				  = _config[$ "repetitions"		] ?? 1;
			input_limit				  = _config[$ "input_limit"		] ?? undefined;
			input_window			  = _config[$ "input_window"	] ?? [0,3];
			charge_min				  = _config[$ "charge_min"		] ?? 0;
			charge_max				  = _config[$ "charge_max"		] ?? 0;
			charge_rate				  = _config[$ "charge_rate"		] ?? 1;
			goto_next_phase			  = _config[$ "goto_next_phase"	] ?? undefined; // method returns true if we should goto next phase
			on_start_callback		  = _config[$ "on_start"		] ?? undefined;
			on_complete_callback	  = _config[$ "on_complete"		] ?? undefined;
			on_success_callback		  = _config[$ "on_success"		] ?? undefined;
			on_fail_callback		  = _config[$ "on_fail"			] ?? undefined;
			on_cancel_callback		  = _config[$ "on_cancel"		] ?? undefined;
			on_running_callback		  = _config[$ "on_running"		] ?? undefined;
			on_animation_end_callback = _config[$ "on_animation_end"] ?? undefined;
			
			charge_amount			   = 0;
			charged					   = false;
			on_start_callbacks		   = [];
			on_complete_callbacks	   = [];
			on_success_callbacks	   = [];
			on_fail_callbacks		   = [];
			on_cancel_callbacks		   = [];
			on_running_callbacks	   = [];
			on_animation_end_callbacks = [];
			on_complete_temp		   = undefined;
			blackboard				   = {};
			sprite_prefix			   = "";
			sprite_key				   = "";
			buffered				   = false;
			
			timer = 0;
		};
			
		// events
		on_initialize(function() {
			__construct_sprite_names();
		});
		on_update	 (function() {
			__update_charge();
			__on_running();
			__check_goto_next_phase();
		});
	};
	