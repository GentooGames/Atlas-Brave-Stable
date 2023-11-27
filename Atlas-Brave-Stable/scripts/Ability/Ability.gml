	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __       __   ______  __  __    //
	// /\  __ \ /\  == \ /\ \ /\ \     /\ \ /\__  _\/\ \_\ \   //
	// \ \  __ \\ \  __< \ \ \\ \ \____\ \ \\/_/\ \/\ \____ \  //
	//  \ \_\ \_\\ \_____\\ \_\\ \_____\\ \_\  \ \_\ \/\_____\ //
	//   \/_/\/_/ \/_____/ \/_/ \/_____/ \/_/   \/_/  \/_____/ //
	//                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function Ability(_character, _config = {}) : IB_Base(_config) constructor {
		
		var _self = self;
	
		static start						= function(_phase_index = 1, _on_complete_temp = undefined) {
			
			if (__.state == "running") exit;
			if (__.phases.contains(_phase_index) == false) exit;
				
			// passing parameters
			__.phase_index		= _phase_index;
			__.phase_current	= __.phases.get(_phase_index);
			__.on_complete_temp = _on_complete_temp;
			
			// consume stock
			stock_current_subtract(__.stock_consumed.get());
			
			// clear blackboard
			blackboard_clear();
			
			// start ability
			__.state = "running";
			__on_phase_change();
			__on_start();
			__.phase_current.start();
			__complete_trigger_start();
		};
		static complete						= function(_success = undefined, _cooldown_start = true, _execute_callbacks = true) {
			
			if (__.state != "running") exit;
			
			// stop current phase
			if (__.phase_current != undefined) {
				__.phase_current.complete(_success);
			}
			
			// start cooldown timer?
			if (_cooldown_start) cooldown_start();
			
			// execute callbacks
			if (_execute_callbacks) {
				if (_success == true ) __on_success();
				if (_success == false) __on_fail();
				__on_complete();
			}
				
			// complete trigger
			__complete_trigger_complete();
			
			__.state = "stopped";
		};
		static cancel						= function(_success = __.cancel_buffer_success, _cancel_to = __.cancel_buffer_to, _reset = __.cancel_buffer_auto_reset) {
			
			if (__.state != "running") exit;
			
			// cancel current phase
			if (__.phase_current != undefined) {
				__.phase_current.cancel();
			}
			
			// cancel ability
			complete(_success);	
			
			// callbacks
			__on_cancel();
			
			// reset?
			if (_reset) cancel_buffer_reset();
			
		};
		static miscast						= function() {
			var _cooldown_time = __.cooldown_time_miscast.get();
			if (_cooldown_time > 0) cooldown_start(_cooldown_time);
		};
		static next_phase					= function() {
			
			if (__.phase_current == undefined) exit;
				
			// reset current phase
			__.phase_current.buffer_reset();
				
			// get next index
			var _next_index = __.phase_index + 1;
			
			// go to next phase
			if (__.phases.contains(_next_index)) {
				__.phase_index	 = _next_index;
				__.phase_current = __.phases.get(_next_index);
				__on_phase_change();
				__.phase_current.start();
			}
			// stop phases instead
			else {
				complete();
				__.phase_index	 = -1;
				__.phase_current =  undefined;
			}
		};
		static animation_end				= function() {
			if (__.phase_current != undefined) {
				__.phase_current.animation_end();	
			}
			__on_animation_end();	
		};
											   
		static on_start						= function(_callback, _data) {
			array_push(__.on_start_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_complete					= function(_callback, _data) {
			array_push(__.on_complete_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_cancel					= function(_callback, _data) {
			array_push(__.on_cancel_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_success					= function(_callback, _data) {
			array_push(__.on_success_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_fail						= function(_callback, _data) {
			array_push(__.on_fail_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_running					= function(_callback, _data) {
			array_push(__.on_running_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_phase_change				= function(_callback, _data) {
			array_push(__.on_phase_change_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
		static on_animation_end				= function(_callback, _data) {
			array_push(__.on_animation_end_callbacks, {
				callback: _callback,
				data:	  _data,
			});
		};
											
		static get_type						= function() {
			return __.type;	
		};
		static get_name						= function() {
			return __.name;	
		};
		static get_phase					= function() {
			return __.phase_current;	
		};
		static get_phase_index				= function() {
			var _phase  = get_phase();
			if (_phase == undefined) return -1;
			return _phase.get_index();
		};
		static get_phase_count				= function() {
			return __.phase_count;	
		}
		static get_phase_advance			= function() {
			
			if (__.phase_advance == undefined) return 1;
			
			var _result = __.phase_advance(__.character, self);
			if (_result.advance) return _result.index;
			
			return 1;
		};
		static get_sprite_prefix			= function() {
			if (__.phase_current == undefined) return "";
			return __.phase_current.get_sprite_prefix();
		};
											   								     
		static is_ready						= function() {
			return ( 
				(!cooldown_is_active() || stock_current_get() > 0) && 
				( __.activation_check == undefined || __.activation_check(__.character, self, __.phase_current))
			);
		};
		static is_running					= function() {
			if (__.phase_current == undefined) return false;
			return __.phase_current.is_running();
		};
											
		static cooldown_start				= function(_cooldown_time = cooldown_get_time()) {
			__.cooldown_timer.set_period(_cooldown_time);
			__.cooldown_timer.start();
		};
		static cooldown_stop				= function() {
			__.cooldown_timer.stop();
		};
		static cooldown_reduce_time			= function(_amount) {
			
			if (cooldown_is_active() == false) exit;
			
			var _time_remaining = __.cooldown_timer.get_time_remaining();
			var _time_reduced	= _time_remaining - _amount;
			__.cooldown_timer.advance_to(_time_reduced);
			
		};
		static cooldown_refresh				= function() {
			
			stock_current_add(1);
			
			if (stock_current_get() == stock_max_get()) {
				cooldown_stop();	
			}
			else {
				cooldown_start();	
			}
		};
		static cooldown_get_time			= function() {
			return __.cooldown_time.get();
		};
		static cooldown_get_timer			= function() {
			return __.cooldown_timer;	
		};
		static cooldown_is_active			= function() {
			return __.cooldown_timer.is_running();
		};
		
		static phase_buffer					= function(_phase_index = __.phase_index) {
			// get phase instance
			var _phase		  = __.phase_current;
			if (_phase_index != __.phase_index) {
				_phase		  = __.phases.get(_phase_index);	
			}
			if (_phase == undefined) exit;
			_phase.buffer_set(true);
		};
		static phase_buffered				= function(_phase_index = __.phase_index) {
			// get phase instance
			var _phase		  = __.phase_current;
			if (_phase_index != __.phase_index) {
				_phase		  = __.phases.get(_phase_index);	
			}
			if (_phase == undefined) return false;
			return __.phase_current.buffer_get();
		};
		static phase_buffer_reset			= function(_phase_index = __.phase_index) {
			// get phase instance
			var _phase		  = __.phase_current;
			if (_phase_index != __.phase_index) {
				_phase		  = __.phases.get(_phase_index);	
			}
			if (_phase == undefined) exit;
			return __.phase_current.buffer_reset();
		};
		
		static cancel_buffer_get_target		= function() {
			return __.cancel_buffer_to;
		};
		static cancel_buffer_get_exit_frame = function() {
			return __.cancel_buffer_exit_frame;
		};
		static cancel_buffer_get_success	= function() {
			return __.cancel_buffer_success;
		};
		static cancel_buffer_get_auto_reset = function() {
			return __.cancel_buffer_auto_reset;	
		};
		static cancel_buffer_set			= function(_cancel_to = undefined, _exit_frame = undefined, _success = undefined) {
			cancel_buffer_set_target	(_cancel_to	);
			cancel_buffer_set_exit_frame(_exit_frame);
			cancel_buffer_set_success	(_success	);
		};
		static cancel_buffer_set_target		= function(_cancel_to) {
			__.cancel_buffer_to	= _cancel_to;
		};
		static cancel_buffer_set_exit_frame = function(_exit_frame) {
			__.cancel_buffer_exit_frame = _exit_frame;
		};
		static cancel_buffer_set_success	= function(_success) {
			__.cancel_buffer_success = _success;
		};
		static cancel_buffer_set_auto_reset = function(_auto_reset) {
			__.cancel_buffer_auto_reset = _auto_reset;
		};
		static cancel_buffer_reset			= function() {
			__.cancel_buffer_to			= undefined;
			__.cancel_buffer_exit_frame = undefined;
			__.cancel_buffer_success	= undefined;
		};
										  
		static charge_is_charged			= function() {
			return (__.phase_current != undefined
				&&	__.phase_current.charge_is_charged()
			);
		};
		static charge_get_amount			= function() {
			if (__.phase_current == undefined) return 0;
			return __.phase_current.charge_get_amount();
		};
										     
		static stock_current_add			= function(_amount = 1) {
			__.stock_current += _amount;
			if (__.stock_current > __.stock_max.get()) {
				__.stock_current = __.stock_max.get();	
			}
		};
		static stock_current_get			= function() {
			return __.stock_current;
		};
		static stock_current_subtract		= function(_amount = 1) {
			__.stock_current -= _amount;
			if (__.stock_current < 0) {
				__.stock_current = 0;	
			}
		};
		static stock_current_reset_to_max	= function() {
			__.stock_current = __.stock_max.get();
		};
		static stock_max_add				= function(_amount = 1) {
			__.stock_max.add(_amount);
		};
		static stock_max_get				= function() {
			return __.stock_max.get();
		};
		static stock_max_subtract			= function(_amount = 1) {
			__.stock_max.subtract(_amount);
		};
			
		static blackboard_write				= function(_name, _value) {
			__.blackboard[$ _name] = _value;
		};
		static blackboard_read				= function(_name) {
			return __.blackboard[$ _name];
		};
		static blackboard_erase				= function(_name) {
			variable_struct_remove(__.blackboard, _name);
		};
		static blackboard_clear				= function() {
			__.blackboard = {};
		};
		
		// private 
		with (__) {
			static __on_callback			   = function(_callback_array) {
				for (var _i = 0, _len = array_length(_callback_array); _i < _len; _i++) {
					var _callback = _callback_array[_i];
					_callback.callback(__.character, self, __.phase_current, _callback.data);
				};
			};
			static __on_start				   = function() {
				if (__.on_start_callback != undefined) {
					__.on_start_callback(__.character, self, __.phase_current);	
				}
				__on_callback(__.on_start_callbacks);
			};
			static __on_complete			   = function() {
				if (__.on_complete_callback != undefined) {
					__.on_complete_callback(__.character, self, __.phase_current);	
				}				  
				__on_callback(__.on_complete_callbacks);
				if (__.on_complete_temp != undefined) {
					__.on_complete_temp();	
				}
			};				
			static __on_success				   = function() {
				if (__.on_success_callback != undefined) {
					__.on_success_callback(__.character, self, __.phase_current);	
				}				  
				__on_callback(__.on_success_callbacks);
			};
			static __on_fail				   = function() {
				if (__.on_fail_callback != undefined) {
					__.on_fail_callback(__.character, self, __.phase_current);	
				}				  
				__on_callback(__.on_fail_callbacks);
			};
			static __on_cancel				   = function() {
				if (__.on_cancel_callback != undefined) {
					__.on_cancel_callback(__.character, self, __.phase_current);	
				}
				__on_callback(__.on_cancel_callbacks);
			};
			static __on_running				   = function() {
				if (__.on_running_callback != undefined) {
					__.on_running_callback(__.character, self, __.phase_current);	
				}
				__on_callback(__.on_running_callbacks);
			};
			static __on_phase_change		   = function() {
				if (__.on_phase_change_callback != undefined) {
					__.on_phase_change_callback(__.character, self, __.phase_current);	
				}
				__on_callback(__.on_phase_change_callbacks);
			};
			static __on_animation_end		   = function() {
				if (__.on_animation_end_callback != undefined) {
					__.on_animation_end_callback(__.character, self, __.phase_current);	
				}
				__on_callback(__.on_animation_end_callbacks);
			};
			static __phases_setup			   = function() {
				__.phase_count = array_length(__.phase_data);
				for (var _i = 1, _len = array_length(__.phase_data); _i <= _len; _i++) {
					var _phase_data  = __.phase_data[_i - 1];	
					var _phase_index = _i;
					
					_phase_data[$ "phase_id"] ??= _phase_index;
					
					var _phase = new AbilityPhase(self, __.character, _phase_data);
						_phase.initialize();
						
					__.phases.set(_phase_index, _phase);
				};
			};
			static __check_cancel_buffer	   = function() {
				if (__.cancel_buffer_to != undefined 
				&&	__.cancel_buffer_to != ""
				&&	__.cancel_buffer_exit_frame != undefined
				&&	__.character.sprite_get_frame_index() >= __.cancel_buffer_exit_frame
				) {
					cancel();
				}
			};
			static __complete_trigger_start    = function() {
				if (__.completion_trigger == undefined) exit;
				__.completion_trigger.start(__.character, self, __.phase_current);
			};
			static __complete_trigger_check	   = function() {
				if (__.completion_trigger == undefined) exit;
				__.completion_trigger.check(__.character, self, __.phase_current);
			};
			static __complete_trigger_complete = function() {
				if (__.completion_trigger == undefined) exit;
				__.completion_trigger.complete(__.character, self, __.phase_current);
			};
								    
			character				   = _character;
			name					   = _config[$ "name"					 ] ?? "";
			type					   = _config[$ "type"					 ] ?? undefined;
			phase_data				   = _config[$ "phases"					 ] ?? [];
			activation_check		   = _config[$ "activation_check"		 ] ?? undefined;
			completion_trigger		   = _config[$ "completion_trigger"		 ] ?? undefined;
			phase_advance			   = _config[$ "phase_advance"			 ] ?? undefined;
			on_start_callback		   = _config[$ "on_start"				 ] ?? undefined;
			on_complete_callback	   = _config[$ "on_complete"			 ] ?? undefined;
			on_success_callback		   = _config[$ "on_success"				 ] ?? undefined;
			on_fail_callback		   = _config[$ "on_fail"				 ] ?? undefined;
			on_cancel_callback		   = _config[$ "on_cancel"				 ] ?? undefined;
			on_running_callback		   = _config[$ "on_running"				 ] ?? undefined;
			on_phase_change_callback   = _config[$ "on_phase_change"		 ] ?? undefined;
			on_animation_end_callback  = _config[$ "on_animation_end"		 ] ?? undefined;
			cancel_buffer_to		   = _config[$ "cancel_buffer_to"		 ] ?? undefined;
			cancel_buffer_exit_frame   = _config[$ "cancel_buffer_exit_frame"] ?? undefined;
			cancel_buffer_success	   = _config[$ "cancel_buffer_success"	 ] ?? undefined;
			cancel_buffer_auto_reset   = _config[$ "cancel_buffer_auto_reset"] ?? true;
									   
			cooldown_time			   =  new IB_Stat({
				value:    _config[$ "cooldown_time"] ?? 0,
				limit_min: 0,
			});
			cooldown_timer			   =  new IB_TimeSource({
				period:		 cooldown_time.get(),
				callback:	 method(_self, function() {
					cooldown_refresh();
				}),
				repetitions: 1,
			});
			cooldown_time_miscast	   =  new IB_Stat({
				value:    _config[$ "cooldown_time_miscast"] ?? 60,
				limit_min: 0,
			});
			stock_max				   =  new IB_Stat({
				value:	  _config[$ "stock_max"] ?? 1,
				limit_min: 0,
			});
			stock_consumed			   =  new IB_Stat({
				value:	  _config[$ "stock_consumed"] ?? 1,
				limit_min: 0,
			});
			stock_current			   = _config[$ "stock_start"] ?? stock_max.get();
									   
			blackboard				   =  {};
			state					   = "ready";
			phases					   =  new IB_Collection_Struct();
			phase_current			   =  undefined;
			phase_index				   = -1;
			phase_count				   =  0;
								  
			on_start_callbacks		   = [];
			on_complete_callbacks	   = [];
			on_success_callbacks	   = [];
			on_fail_callbacks		   = [];
			on_cancel_callbacks		   = [];
			on_running_callbacks	   = [];
			on_phase_change_callbacks  = [];
			on_animation_end_callbacks = [];
			on_complete_temp		   = undefined;
		};
			
		// events
		on_initialize(function() {
			__phases_setup();
			__.stock_max.initialize();
			__.stock_consumed.initialize();
			__.cooldown_time.initialize();
			__.cooldown_timer.initialize();	
			__.cooldown_time_miscast.initialize();
		});
		on_update	 (function() {
			if (__.phase_current != undefined) {
				__.phase_current.update();	
				__on_running(); // callbacks
				__check_cancel_buffer();
				__complete_trigger_check();
			}
		});
		on_cleanup   (function() {
			__.phases.for_each(function(_phase) {
				_phase.cleanup();
			});
			__.stock_max.cleanup();
			__.stock_consumed.cleanup();
			__.cooldown_time.cleanup();
			__.cooldown_timer.cleanup();				
			__.cooldown_time_miscast.cleanup();				
		});
	};