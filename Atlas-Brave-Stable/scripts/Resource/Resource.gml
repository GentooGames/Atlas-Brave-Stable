
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   ______   __  __   ______   ______   ______    //
	// /\  == \ /\  ___\ /\  ___\ /\  __ \ /\ \/\ \ /\  == \ /\  ___\ /\  ___\   //
	// \ \  __< \ \  __\ \ \___  \\ \ \/\ \\ \ \_\ \\ \  __< \ \ \____\ \  __\   //
	//  \ \_\ \_\\ \_____\\/\_____\\ \_____\\ \_____\\ \_\ \_\\ \_____\\ \_____\ //
	//   \/_/ /_/ \/_____/ \/_____/ \/_____/ \/_____/ \/_/ /_/ \/_____/ \/_____/ //
	//                                                                           //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function Resource(_config = {}) : IB_Base(_config) constructor {
		
		var _self = self;
		
		static deplete		= function(_amount = get_count()) {
			if (_amount > 0) {
				__.count.subtract(_amount);
				__on_deplete(_amount);
				if (is_empty()) __on_empty(_amount);	
			}
			return self;
		};
		static restore		= function(_amount = get_space()) {
			if (_amount > 0) {
				__.count.add(_amount);
				__on_restore(_amount);
			}
			return self;
		};
		static get_count	= function() {
			return __.count.get();	
		};
		static get_capacity = function() {
			return __.capacity.get();	
		};
		static get_space	= function() {
			return get_capacity() - get_count();	
		};
		static is_empty		= function() {
			return __.count.get() <= 0;	
		};
	
		// regen
		static regen_lock_set		  = function(_lock_name, _lock_duration = -1) {
			__.regen_lock.set_lock(_lock_name, _lock_duration);
			return self;
		};
		static regen_lock_remove	  = function(_lock_name) {
			__.regen_lock.remove_lock(_lock_name);
			return self;
		};
		static regen_lock_is_locked   = function() {
			return __.regen_lock.is_locked();
		};
		static regen_lock_is_unlocked = function() {
			return __.regen_lock.is_unlocked();
		};
		static regen_start_timer	  = function() {
			__.regen_timer.start();
			return self;
		};
		static regen_stop_timer		  = function() {
			__.regen_timer.stop();
			return self;
		};
		
		// drain
		static drain_lock_set		  = function(_lock_name, _lock_duration = -1) {
			__.drain_lock.set_lock(_lock_name, _lock_duration);
			return self;
		};
		static drain_lock_remove	  = function(_lock_name) {
			__.drain_lock.remove_lock(_lock_name);
			return self;
		};
		static drain_lock_is_locked   = function() {
			return __.drain_lock.is_locked();
		};
		static drain_lock_is_unlocked = function() {
			return __.drain_lock.is_unlocked();
		};
		static drain_start_timer	  = function() {
			__.drain_timer.start();
			return self;
		};
		static drain_stop_timer		  = function() {
			__.drain_timer.stop();
			return self;
		};
			
		// callbacks
		static on_deplete = function(_callback, _data = undefined) {
			array_push(__.on_deplete_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_restore = function(_callback, _data = undefined) {
			array_push(__.on_restore_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_empty   = function(_callback, _data = undefined) {
			array_push(__.on_empty_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_regen	  = function(_callback, _data = undefined) {
			array_push(__.on_regen_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_drain	  = function(_callback, _data = undefined) {
			array_push(__.on_drain_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		
		// private
		with (__) {
			static __on_callback = function(_callback_array, _amount) {
				for (var _i = 0, _len = array_length(_callback_array); _i < _len; _i++) {
					var _callback = _callback_array[_i];	
					_callback.callback(self, _callback.data, _amount);
				};
			};
			static __on_deplete  = function(_amount) {
				__on_callback(__.on_deplete_callbacks, _amount);
				if (__.on_deplete_callback != undefined) {
					__.on_deplete_callback(self);	
				}
			};
			static __on_restore  = function(_amount) {
				__on_callback(__.on_restore_callbacks, _amount);
				if (__.on_restore_callback != undefined) {
					__.on_restore_callback(self);	
				}
			};
			static __on_empty	 = function(_amount) {
				__on_callback(__.on_empty_callbacks, _amount);
				if (__.on_empty_callback != undefined) {
					__.on_empty_callback(self);	
				}
			};
			static __on_regen	 = function(_amount) {
				__on_callback(__.on_regen_callbacks, _amount);
				if (__.on_regen_callback != undefined) {
					__.on_regen_callback(self);	
				}
			};
			static __on_drain	 = function(_amount) {
				__on_callback(__.on_drain_callbacks, _amount);
				if (__.on_drain_callback != undefined) {
					__.on_drain_callback(self);	
				}
			};
			
			capacity = new IB_Stat({
				value:	  _config[$ "capacity"] ?? 100,
				limit_min: 0,
			});
			count	 = new IB_Stat({
				value:     _config[$ "count"] ?? 100,
				limit_min: 0,
			});
			
			// regen
			regen_start  = _config[$ "regen_start"] ?? false;
			regen_loops  = _config[$ "regen_loops"] ?? false;
			regen_rate	 =  new IB_Stat({
				value:	   _config[$ "regen_rate"] ?? 0,
				limit_min: 0,
			});
			regen_amount =  new IB_Stat({
				value:  _config[$ "regen_amount"] ?? 0,
			});
			regen_timer  =  new IB_TimeSource({
				period:		  regen_rate.get(),
				callback:	  method(_self, function() {
					__.regen();
					if (!__.regen_loops) {
						 regen_stop_timer();	
					}
				}),
				repetitions: -1,
			});
			regen_lock	 =  new IB_LockStack();
			regen_check  =  method(_self, function() {
				return (regen_lock_is_unlocked()
					&&  get_space() > 0
				);
			});
			regen		 =  method(_self, function(_amount = __.regen_amount.get()) {
				if (__.regen_check()) {
					_amount ??= get_space();
					restore(_amount);
					__on_regen(_amount);
				}
			});
						
			// drain
			drain_start  = _config[$ "drain_start"] ?? false;
			drain_loops  = _config[$ "drain_loops"] ?? false;
			drain_rate	 =  new IB_Stat({
				value:	   _config[$ "drain_rate"] ?? 0,
				limit_min: 0,
			});
			drain_amount =  new IB_Stat({
				value:  _config[$ "drain_amount"] ?? 0,
			});
			drain_timer  =  new IB_TimeSource({
				period:		  drain_rate.get(),
				callback:	  method(_self, function() {
					__.drain();
					if (!__.drain_loops) {
						 drain_stop_timer();	
					}
				}),
				repetitions: -1,
			});
			drain_lock	 =  new IB_LockStack();
			drain_check  =  method(_self, function() {
				return (drain_lock_is_unlocked()
					&&  get_count() > 0
				);
			});
			drain		 =  method(_self, function(_amount = __.drain_amount.get()) {
				if (__.drain_check()) {
					_amount ??= get_count();
					deplete(_amount);
					__on_drain(_amount);
				}
			});
				
			// callbacks
			on_deplete_callback = _config[$ "on_deplete_callback"] ?? undefined;
			on_restore_callback = _config[$ "on_restore_callback"] ?? undefined;
			on_empty_callback   = _config[$ "on_empty_callback"	 ] ?? undefined;
			on_regen_callback   = _config[$ "on_regen_callback"	 ] ?? undefined;
			on_drain_callback   = _config[$ "on_drain_callback"	 ] ?? undefined;
			
			on_deplete_callbacks = [];
			on_restore_callbacks = [];
			on_empty_callbacks	 = [];
			on_regen_callbacks	 = [];
			on_drain_callbacks	 = [];
		};
			
		// events
		on_initialize(function() {
			__.capacity.initialize();
			__.count.initialize();
			__.regen_rate.initialize();
			__.regen_amount.initialize();
			__.regen_timer.initialize();
			__.regen_lock.initialize();
			__.drain_rate.initialize();
			__.drain_amount.initialize();
			__.drain_timer.initialize();
			__.drain_lock.initialize();
			if (__.regen_start && __.regen_rate.get() > 0) regen_start_timer();
			if (__.drain_start && __.drain_rate.get() > 0) drain_start_timer();
		});
		on_update    (function() {
			__.regen_lock.update();
			__.drain_lock.update();
		});
		on_cleanup   (function() {
			__.capacity.cleanup();
			__.count.cleanup();
			__.regen_rate.cleanup();
			__.regen_amount.cleanup();
			__.regen_timer.cleanup();
			__.regen_lock.cleanup();
			__.drain_rate.cleanup();
			__.drain_amount.cleanup();
			__.drain_timer.cleanup();
			__.drain_lock.cleanup();
		});
	};
	
	