
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __     __   ______   ______   __       _____    //
	// /\ \  _ \ \ /\  __ \ /\  == \ /\ \     /\  __-.  //
	// \ \ \/ ".\ \\ \ \/\ \\ \  __< \ \ \____\ \ \/\ \ //
	//  \ \__/".~\_\\ \_____\\ \_\ \_\\ \_____\\ \____- //
	//   \/_/   \/_/ \/_____/ \/_/ /_/ \/_____/ \/____/ //
	//                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_world.create //
	event_inherited();
	var _self = self;
	var _data = self[$ "data"] ?? self;
	
	// private
	with (__) {
		collect_grids	 = method(_self, function() {
			__.mp_grids = [];
			with (IB_Object_Navmesh) {
				array_push(other.__.mp_grids, self);
			};
		});
		initialize_grids = method(_self, function() {
			iceberg.array.for_each(__.mp_grids, function(_grid) {
				_grid.initialize();
			});
		});
		block_off_grids  = method(_self, function() {
			iceberg.array.for_each(__.mp_grids, function(_grid) {
				_grid.add_instances(obj_solid, true);
			});
		});
		mp_grids		 = [];
	};
	
	// events
	on_initialize(function() {});
	on_render	 (function() {});
	on_room_start(function() {
		__.collect_grids();
		__.initialize_grids();
		__.block_off_grids();
	});
	
	