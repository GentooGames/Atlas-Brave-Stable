
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______   ______   ______   __   __    //
	// /\  == \/\  == \ /\  __ \ /\  ___\ /\  ___\ /\  ___\ /\ "-.\ \   //
	// \ \  _-/\ \  __< \ \ \/\ \\ \ \____\ \ \__ \\ \  __\ \ \ \-.  \  //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_____\\ \_____\\ \_____\\ \_\\"\_\ //
	//   \/_/    \/_/ /_/ \/_____/ \/_____/ \/_____/ \/_____/ \/_/ \/_/ //
	//                                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_progen.create //
	event_inherited();
	
	// = PRIVATE ===============
	with (__) {
		tile_layer_grass_top = new RoomTileLayer({
			tile_sprite_index: spr_tile_grass_top,
			surface_width:	   1280,
			surface_height:	   960,
		});
	};
	
	// = EVENTS ================
	on_initialize(function() {
		__.tile_layer_grass_top.initialize();
	});
	on_render	 (function() {
		__.tile_layer_grass_top.render();
	});
	on_cleanup	 (function() {
		__.tile_layer_grass_top.cleanup();
	});
	