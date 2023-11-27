
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   __    __    //
	// /\  == \ /\  __ \ /\  __ \ /\ "-./  \   //
	// \ \  __< \ \ \/\ \\ \ \/\ \\ \ \-./\ \  //
	//  \ \_\ \_\\ \_____\\ \_____\\ \_\ \ \_\ //
	//   \/_/ /_/ \/_____/ \/_____/ \/_/  \/_/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function Room(_config = {}) : IB_Base(_config) constructor {
		
		// = PRIVATE ===============
		with (__) {
			grid = new IB_Grid({
				cell_size: _config[$ "grid_cell_size"] ?? 16,
				width:	   _config[$ "grid_width"	 ] ?? 1,
				height:	   _config[$ "grid_height"	 ] ?? 1,
			});
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.grid.initialize();
		});
		on_render_gui(function() {
			__.grid.render_grid(40, 40, 8, 1, c_white);
		});
		on_cleanup	 (function() {
			__.grid.cleanup();
		});
	};
	
	/*
		current implementation doesnt include the buffer at all.
		next goal should be to instead of applying the automata's
		output to the determining if a time should be placed at a 
		given cell, instead it should be applied to the buffer and
		start erasing pixel data to make the final output more smooth
		and organic looking, not seeming so tied to a grid
	*/
	
	function RoomTileLayer(_config = {}) : IB_Base(_config) constructor {
		
		// = PRIVATE ===============
		with (__) {
			static __generate_tiled_sprite	= function() {
				
				if (__.tile_sprite_index == undefined) exit;
				
				__.surface.ensure();
				__.surface.focus();
				__.surface.clear();
				
				// draw repeated sprite tiles to surface
				var _tile_width  = sprite_get_width (__.tile_sprite_index);
				var _tile_height = sprite_get_height(__.tile_sprite_index);
				var _grid_width	 = __.automata.size_get_width();
				var _grid_height = __.automata.size_get_height();
				
				for (var _i = 0; _i < _grid_width; _i++) {
					for (var _j = 0; _j < _grid_height; _j++) {
						if (__.automata.cell_is_filled(_i, _j)) {
							draw_sprite(
								__.tile_sprite_index, 
								__.tile_sprite_image, 
								_i * _tile_width, 
								_j * _tile_height,
							);	
						}
					};
				};
				
				__.surface.unfocus();
			};
			static __tiled_sprite_to_buffer = function() {
				__.buffer.from_surface(__.surface.get_surface());
			};
			static __erase_automata_cells	= function() {};
			
			layer_position_x  = _config[$ "layer_position_x" ] ?? 0;
			layer_position_y  = _config[$ "layer_position_y" ] ?? 0;
			surface_width	  = _config[$ "surface_width"	 ] ?? room_width;
			surface_height	  = _config[$ "surface_height"	 ] ?? room_height;
			tile_sprite_index = _config[$ "tile_sprite_index"] ?? undefined;
			tile_sprite_image = _config[$ "tile_sprite_image"] ?? 0; 
			automata		  =  new IB_CellularAutomata({
				width:	surface_width  div sprite_get_width (tile_sprite_index),
				height: surface_height div sprite_get_height(tile_sprite_index),
			});
			buffer			  =  new IB_Buffer(); // should become IB_BufferGrid()
			surface			  =  new IB_Surface({
				width:	surface_width,
				height: surface_height,
			});
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.automata.initialize();
			__.automata.iterate();
			__.buffer.initialize();
			__.surface.initialize();
			__generate_tiled_sprite();
			__tiled_sprite_to_buffer();
			__erase_automata_cells();
		});
		on_render	 (function() {
			__.surface.draw(__.layer_position_x, __.layer_position_y);
		});
		on_cleanup	 (function() {
			__.automata.cleanup();
			__.buffer.cleanup();
			__.surface.cleanup();
		});
	};
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	