
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __ __   ______   __   ______   __   __    //
	// /\ \ / //\ \ /\  ___\ /\ \ /\  __ \ /\ "-.\ \   //
	// \ \ \'/ \ \ \\ \___  \\ \ \\ \ \/\ \\ \ \-.  \  //
	//  \ \__|  \ \_\\/\_____\\ \_\\ \_____\\ \_\\"\_\ //
	//   \/_/    \/_/ \/_____/ \/_/ \/_____/ \/_/ \/_/ //
	//                                                 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function Vision(_config = {}) : IB_Base(_config) constructor {
		
		var _self = self;
		
		// public
		static scan					= function(_x, _y, _radius = __.radius) {
			
			// iterate through and do a collision on every object definition
			// and then store the combined results into one giant array.
			var _targets = [];
			for (var _i = 0, _len_i = __.target_data.get_size(); _i < _len_i; _i++) {
				var _target = __.target_data.get_by_index(_i);
				var _count	= _target.collision(_x, _y, _radius);
				var _list   = _target.get_list();
				for (var _j = 0; _j < _count; _j++) {
					array_push(_targets, _list[|_j]);
				};
			};
			
			// do custom sort if we scanned for multiple objects
			if (_len_i > 1) {
				array_sort(_targets, __.sort_function);
			}
			
			// assign to internal reference
			__.targets = _targets;
			
			return __.targets;
		};
		static vision_target_add	= function(_object_index, _precise = __.precise, _notme = __.notme, _ordered = __.ordered) {
			var _target = new VisionTarget({
				object:  _object_index,
				precise: _precise,
				notme:   _notme,
				ordered: _ordered,
			});
			__.target_data.set(_object_index, _target);
			return _target;
		};
		static vision_target_remove = function(_object_index) {
			var _target = __.target_data.get(_object_index);
			__.target_data.remove(_object_index);
			_target.cleanup();
			return self;
		};
		static get_radius			= function() {
			return __.radius;
		};
		static get_targets			= function() {
			return __.targets;	
		};
		static set_sort_function	= function(_sort_function) {
			__.sort_function = _sort_function;
			return self;
		};
		static set_precise_default	= function(_precise) {
			__.precise = _precise;
			return self;
		};
		static set_notme_default	= function(_notme) {
			__.notme = _notme;
			return self;
		};
		static set_ordered_default	= function(_ordered) {
			__.ordered = _ordered;
			return self;
		};
		
		// private
		with (__) {
			static __sort_default = function(_inst1, _inst2) {
				var _owner	= get_owner();
				var _delta1 = point_distance(_owner.x, _owner.y, _inst1.x, _inst1.y);
				var _delta2 = point_distance(_owner.x, _owner.y, _inst2.x, _inst2.y);
				return _delta1 - _delta2;
			};
				
			sort_function = _config[$ "sort_function"] ?? __sort_default;
			radius		  = _config[$ "radius"		 ] ?? 200;
			precise		  = _config[$ "precise"		 ] ?? true;
			notme		  = _config[$ "notme"		 ] ?? true;
			ordered		  = _config[$ "ordered"		 ] ?? true;
			objects		  = _config[$ "objects"		 ] ?? []; // incoming object definitions only used on initialize()
			target_data	  =  new IB_Collection_Struct();
			targets		  =  [];
		};
		
		// events
		on_initialize(function() {
			iceberg.array.for_each(__.objects, function(_object_index) {
				vision_target_add(_object_index);
			});
		});
		on_cleanup	 (function() {
			__.target_data.for_each(function(_target) {
				_target.cleanup();
			});
		});
	};
	function VisionTarget(_config = {}) : IB_Base(_config) constructor {
	
		var _self = self;
		
		// public
		static collision   = function(_x, _y, _radius) {
			ds_list_clear(__.list);
			return collision_circle_list(_x, _y, _radius, __.object, __.precise, __.notme, __.list, __.ordered);	
		};
		static get_object  = function() {
			return __.object;
		};
		static get_precise = function() {
			return __.precise;
		};
		static get_notme   = function() {
			return __.notme;
		};
		static get_list    = function() {
			return __.list;
		};
		static get_ordered = function() {
			return __.ordered;	
		};
		static set_precise = function(_precise) {
			__.precise = _precise;
			return self;
		};
		static set_notme   = function(_notme) {
			__.notme = _notme;
			return self;
		};
		static set_ordered = function(_ordered) {
			__.ordered = _ordered;
			return self;
		};
		
		// private
		with (__) {
			object	= _config[$ "object" ] ?? undefined;
			precise = _config[$ "precise"] ?? true;
			notme	= _config[$ "notme"  ] ?? true;
			ordered = _config[$ "ordered"] ?? true;
			list	=  ds_list_create();
		};
		
		// events
		on_cleanup(function() {
			ds_list_destroy(__.list);;
		});
	};
	