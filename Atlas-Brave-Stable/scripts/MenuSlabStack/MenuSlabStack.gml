
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   __   __   __  __    //
	// /\ "-./  \ /\  ___\ /\ "-.\ \ /\ \/\ \   //
	// \ \ \-./\ \\ \  __\ \ \ \-.  \\ \ \_\ \  //
	//  \ \_\ \ \_\\ \_____\\ \_\\"\_\\ \_____\ //
	//   \/_/  \/_/ \/_____/ \/_/ \/_/ \/_____/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function MenuSlabStack(_config = {}) : IB_Entity(_config) constructor {
		
		var _self = self;
		
		// = PUBLIC ================
		static new_slab		   = function(_text, _callback, _config = {}) {
			
			var _index = __.slabs.get_size();
			
			_config[$ "index"	]	= _index;
			_config[$ "text"	]	= _text;
			_config[$ "callback"]	= _callback;
			_config[$ "x"		] ??= position_get_x();
			
			var _slab = new MenuSlab(_config).initialize();
			__.slabs.set(_index, _slab);
			
			return _slab;
		};
		static on_index_change = function(_callback, _data = undefined) {
			array_push(__.on_index_change_callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return self;
		};
		static on_select	   = function(_callback, _data = undefined) {
			array_push(__.on_select_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static select_current  = function() {
			var _slab = __.slabs.get(__.index);
			_slab.select();
			__on_select();
		};
		static set_index	   = function(_index) {
			if (__index_changed()) {
				__on_index_change();
			}
			__.index_previous = __.index;
			__.index		  = _index;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			static __index_changed	 = function() {
				return __.index != __.index_previous;
			};
			static __move_index_down = function() {
				var _index = iceberg.math.wrap(
					__.index + 1,
					0,
					__.slabs.get_size() - 1,
				);
				set_index(_index);
			};
			static __move_index_up   = function() {
				var _index = iceberg.math.wrap(
					__.index - 1,
					0,
					__.slabs.get_size() - 1,
				);
				set_index(_index);
			};
			static __on_index_change = function() {
				iceberg.array.for_each(__.on_index_change_callbacks, function(_callback) {
					_callback.callback(_callback.data);
				});
			};
			static __on_select		 = function() {
				iceberg.array.for_each(__.on_select_callbacks, function(_callback) {
					_callback.callback(_callback.data);
				});
			};
			
			indentation_per			  = _config[$ "indentation_per"   ] ?? 0;
			select_indentation		  = _config[$ "select_indentation"] ?? 20;
			select_color			  = _config[$ "select_color"	  ] ?? c_white;
			unselect_color			  = _config[$ "unselect_color"	  ] ?? c_white;
			y_space					  = _config[$ "y_space"			  ] ?? 10;
			index					  = -1;
			index_previous			  =  index;
			on_index_change_callbacks = [];
			on_select_callbacks		  = [];
			slabs					  = new IB_Collection_Struct();
		};
		
		// = EVENTS ================
		on_initialize(function() {
			set_index(0);
		});
		on_activate  (function() {
			set_index(0);
		});
		on_update	 (function() {
			__.slabs.for_each(function(_slab) {
				_slab.update();
			});
			
			// player button interactions
			for (var _i = 0, _len = objc_game.player_get_count(); _i < _len; _i++) {
				var _player = objc_game.player_get(_i);	
					
				if (_player.input_down_pressed	()) __move_index_down();
				if (_player.input_up_pressed	()) __move_index_up();
				if (_player.input_select_pressed()
				||  _player.input_start_pressed ()
				) {
					select_current();
				}
			};
		});
		on_render_gui(function() {
			draw_set_valign(fa_center);
			var _y	   = position_get_y();
			var _count = __.slabs.get_size();
			
			for (var _i = 0; _i < _count; _i++) {
				var _slab		 = __.slabs.get_by_index(_i);
				var _indentation = __.indentation_per * _i;
				var _color		 = __.unselect_color;
				if (_i == __.index) _indentation += __.select_indentation;
				if (_i == __.index) _color		  = __.select_color;
				
				var _x = position_get_x();
				_slab.set_x_lerp(_x + _indentation);
				_slab.position_set_y(_y);
				_slab.color_set(_color);
				_slab.render_gui();
									
				_y += _slab.size_get_height() + __.y_space;
			};	
			draw_set_valign(fa_top);
		});
	};
	