
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   ______   __   __ __    __   ______   ______   __  __    //
	// /\ "-.\ \ /\  __ \ /\ \ / //\ "-./  \ /\  ___\ /\  ___\ /\ \_\ \   //
	// \ \ \-.  \\ \  __ \\ \ \'/ \ \ \-./\ \\ \  __\ \ \___  \\ \  __ \  //
	//  \ \_\\"\_\\ \_\ \_\\ \__|  \ \_\ \ \_\\ \_____\\/\_____\\ \_\ \_\ //
	//   \/_/ \/_/ \/_/\/_/ \/_/    \/_/  \/_/ \/_____/ \/_____/ \/_/\/_/ //
	//                                                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function NavmeshHandler(_config = {}) : IB_Base(_config) constructor {
	
		var _self = self;
		
		// public
		static pathfind_to	 = function(_target_instance, _on_path_end = undefined, _on_segment_end = undefined) {
			if (__.navmesh_instance != noone) {
				__.target_instance = _target_instance;
				__.path_found	   =  mp_grid_path(
					__.navmesh_instance.get_mp_grid(), 
					__.path_instance, 
					__.move_instance.position_get_x(),
					__.move_instance.position_get_y(false), 
					__.target_instance.position_get_x(), 
					__.target_instance.position_get_y(false), 
					__.navmesh_allow_diagonals,
				);
				__.path_index		   =  0;
				__.path_index_previous = -1;
				__.path_n_points	   =  path_get_number(__.path_instance);
				__.path_on_path_end	   = _on_path_end;
				__.path_on_segment_end = _on_segment_end;
				return __.path_found;
			}
			return false;
		};
		static pathfind_stop = function(_execute_callback = true) {
			
			// execute callbacks
			if (_execute_callback
			&&	__.path_on_path_end != undefined
			) {
				__.path_on_path_end();	
			}
			
			// reset values
			__.target_instance	   =  undefined;
			__.path_found		   =  false;
			__.path_next_x		   = -1;
			__.path_next_y		   = -1;
			__.path_n_points	   =  0;
			__.path_on_path_end    = undefined;
			__.path_on_segment_end = undefined;
			path_clear_points(__.path_instance);
			
			return self;
		};
		
		// private
		with (__) {
			// methods
			static __navmesh_update_touching   = function() {
				if (__.navmesh_instance == noone) {
					__.navmesh_instance  = collision_point(
						__.move_instance.position_get_x(), 
						__.move_instance.position_get_y(), 
						IB_Object_Navmesh,
						false,
						true,
					);
				}
			};
			static __owner_update_input_vector = function() {
				if (__.target_instance != undefined) {
					var _input_dir = point_direction(
						__.move_instance.position_get_x(), 
						__.move_instance.position_get_y(false), 
						__.path_next_x, 
						__.path_next_y,
					);
					__.move_instance.input_move_vector_set_direction(_input_dir);
					__.move_instance.input_move_vector_set_magnitude(1);	
				}
				else {
					__.move_instance.input_move_vector_set_magnitude(0);	
				}
			};
			static __path_update_position	   = function() {
				// if path_index has been updated
				if (__.path_index != __.path_index_previous) {
					// entire path finished
					if (__.path_index >= __.path_n_points) {
						__path_end_segment();
						pathfind_stop();
						exit;
					}
					// update next path segment target coordinates
					else {
						__.path_next_x		   = path_get_point_x(__.path_instance, __.path_index);
						__.path_next_y		   = path_get_point_y(__.path_instance, __.path_index);
						__.path_index_previous = __.path_index;
					}
				}
				
				// within cutoff distance to segment
				if (abs(__.move_instance.position_get_x()	   - __.path_next_x) <= __.path_cutoff_distance
				&&	abs(__.move_instance.position_get_y(false) - __.path_next_y) <= __.path_cutoff_distance
				) { 
					__path_end_segment();
					__.path_index++;
				}
			};
			static __path_end_segment		   = function() {
				// execute callback
				if (__.path_on_segment_end != undefined) {
					__.path_on_segment_end();
				}
			};
			
			// configurable
			move_instance			= _config[$ "move_instance"			 ] ?? owner;
			navmesh_allow_diagonals	= _config[$ "navmesh_allow_diagonals"] ?? true;
			path_cutoff_distance	= _config[$ "path_cutoff_distance"   ] ?? 10;
			
			// control vars
			navmesh_instance	=  noone;
			target_instance		=  undefined;	
			path_instance		=  path_add();
			path_found			=  false;
			path_index			=  0;
			path_index_previous	= -1;
			path_next_x			= -1;
			path_next_y			= -1;
			path_n_points		=  0;
			path_on_path_end	=  undefined;
			path_on_segment_end	=  undefined;
		};
		
		// events
		on_initialize(function() {
			path_set_closed(__.path_instance, false);
			path_set_kind  (__.path_instance, false);
		});
		on_update	 (function() {
			__navmesh_update_touching();
			if (__.path_found) {
				__path_update_position();
				__owner_update_input_vector();
			}
		});
		on_render	 (function() {
			draw_path(__.path_instance, __.move_instance.x, __.move_instance.y, true);
		});
		on_cleanup	 (function() {
			path_delete(__.path_instance);
		});
	};
	
	
	