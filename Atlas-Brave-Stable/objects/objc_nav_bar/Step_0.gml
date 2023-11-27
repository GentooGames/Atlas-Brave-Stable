
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __    __   ______   __  __   __    //
	// /\ \ /\ "-./  \ /\  ___\ /\ \/\ \ /\ \   //
	// \ \ \\ \ \-./\ \\ \ \__ \\ \ \_\ \\ \ \  //
	//  \ \_\\ \_\ \ \_\\ \_____\\ \_____\\ \_\ //
	//   \/_/ \/_/  \/_/ \/_____/ \/_____/ \/_/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_imgui.step //
	event_inherited();

	// open() & close()
	if (keyboard_check_pressed(vk_f1)) {
		activate(!is_active());
	}
	
	if (is_active()) {
		if (ImGui.BeginMainMenuBar()) {
			#region file <<<<<<<<<<<<<<<
			
			if (ImGui.BeginMenu("file")) {
				#region [close game]
				
				if (ImGui.Button("close game")) {
					game_end();	
				}
				
				#endregion
				ImGui.EndMenu(); 
			}
			
			#endregion
			#region debug <<<<<<<<<<<<<<
			
			if (ImGui.BeginMenu("debug")) {
				#region [toggle overlay]
				
				if (ImGui.Button("toggle overlay")) {
					__.debug.overlay_visible = !__.debug.overlay_visible;
					show_debug_overlay( __.debug.overlay_visible);
				}
				
				#endregion
				ImGui.EndMenu(); 
			}
			
			#endregion
			#region tools <<<<<<<<<<<<<<
			
			if (ImGui.BeginMenu("tools")) {
				#region [toggle overlay]
				
				if (ImGui.Button("animation editor")) {
					room_goto(__rm_anim_editor);
				}
				
				#endregion
				ImGui.EndMenu(); 
			}
			
			#endregion
			#region window <<<<<<<<<<<<<
			
			if (ImGui.BeginMenu("window")) {
				var _window_width  = window_get_width();
				var _window_height = window_get_height();
				#region current size
				
				ImGui.Text("size: "  + string(_window_width) + "x" + string(_window_height));
				
				#endregion
				#region size ratio
				
				ImGui.Text("ratio: " + string(_window_width / _window_height));
				
				#endregion
				#region ------------
				
				ImGui.Separator();
				
				#endregion
				#region [toggle fullscreen]
				
				if (ImGui.Button("fullscreen")) {
					window_set_fullscreen(!window_get_fullscreen());
				}
					
				#endregion
				#region [snap-to]
				
				if (ImGui.CollapsingHeader("snap to", true)) {
					var _button_width  = 25;
					var _button_height = 25;
					
					// -------------------------------------------------------------- //	
					if (ImGui.Button("<^", _button_width, _button_height)) { // top left
						__.window.snap_to(0, 30);
					}
						ImGui.SameLine();
					if (ImGui.Button("^",  _button_width, _button_height)) { // top mid
						__.window.snap_to(,30);
					}
						ImGui.SameLine();
					if (ImGui.Button("^>", _button_width, _button_height)) { // top right
						__.window.snap_to(display_get_width() - window_get_width(), 30);
					}
						
					// -------------------------------------------------------------- //	
					if (ImGui.Button("<", _button_width, _button_height)) { // left
						__.window.snap_to(0);
					}
						ImGui.SameLine();
					if (ImGui.Button("0", _button_width, _button_height)) { // mid
						var _width_delta  = display_get_width()  - window_get_width();
						var _height_delta = display_get_height() - window_get_height();
						__.window.snap_to(_width_delta * 0.5, _height_delta * 0.5);
					}
						ImGui.SameLine();
					if (ImGui.Button(">", _button_width, _button_height)) { // right
						__.window.snap_to(display_get_width() - window_get_width());
					}
						
					// -------------------------------------------------------------- //
					if (ImGui.Button("<v", _button_width, _button_height)) { // bottom left
						__.window.snap_to(0, display_get_height() - window_get_height());
					}
						ImGui.SameLine();
					if (ImGui.Button("v",  _button_width, _button_height)) { // bottom mid
						__.window.snap_to(,display_get_height() - window_get_height());
					}
						ImGui.SameLine();
					if (ImGui.Button("v>", _button_width, _button_height)) { // bottom mid
						__.window.snap_to(display_get_width() - window_get_width(), display_get_height() - window_get_height());
					}
				}
					
				#endregion
				ImGui.EndMenu(); 
			}
			
			#endregion
			#region room <<<<<<<<<<<<<<<
			
			var _room_panel_width  = 160;
			var _room_panel_height = 120;
			if (ImGui.BeginMenu("room")) {
				if (ImGui.BeginChild("_room", _room_panel_width, _room_panel_height)) {
					ImGui.Text("current: " + room_get_name(room));
					ImGui.Separator();
					// -------------------------------------- //
					#region [previous]
				
					if (ImGui.Button("previous", _room_panel_width)) {
						room_goto_previous();
					}
					
					#endregion
					#region [next]
				
					if (ImGui.Button("next", _room_panel_width)) {
						room_goto_next();
					}
					
					#endregion
					#region [restart]
				
					if (ImGui.Button("restart", _room_panel_width)) {
						room_restart();
					}
					
					#endregion
					#region [goto]
				
					var _asset_tree_util = iceberg.asset_tree;
					var _room_indexes	 = _asset_tree_util.get_rooms_as_array();
					var _room_index		 = _room_indexes[__.rooms.combo_select_index];
					var _room_name		 = room_get_name(_room_index);
					var _is_selected	 = false;
				
					#region [go to]
					
					if (ImGui.Button("go to", 50)) {
						room_goto(_room_index);
					}
					
					#endregion
					#region [room (v)]
					
					ImGui.SameLine();
					if (ImGui.BeginCombo("", _room_name, ImGuiComboFlags.None)) {
						for (var _i = 0, _len_i = array_length(_room_indexes); _i < _len_i; _i++) {
							_is_selected = (_i == __.rooms.combo_select_index);
							if (ImGui.Selectable(room_get_name(_room_indexes[_i]), _is_selected)) {
								__.rooms.combo_select_index = _i;
								ImGui.SetItemDefaultFocus();
							}
						};
						ImGui.EndCombo(); 
					}
				
					//#endregion
					
					#endregion
					ImGui.EndChild();
				}
			ImGui.EndMenu(); }
			
			#endregion
			#endregion
			#region players <<<<<<<<<<<<
			
			if (ImGui.BeginMenu("players")) {
				ImGui.BeginChild("players", 200, 200);
					for (var _i = 0, _len_i = objc_game.player_get_count(); _i < _len_i; _i++) {
						var _port_index   = _i;
						var _player		  =  objc_game.player_get(_port_index);
						var _player_index = "(" + string(_i + 1) + ") ";
						var _player_name  = _player.get_name() ?? "player";
							_player_name  = _player_index + _player_name
							
						if (ImGui.CollapsingHeader(_player_name, true)) {
							#region -characters-
							
							var _character_data = HERO_CONFIG;
							
							if (ImGui.TreeNode("characters")) {
								if (ImGui.BeginChild("_characters_operations", 180, 20)) {
									
									var _struct_util	 =  iceberg.struct;
									var _character_types = _struct_util.names_to_array(_character_data);
									var _character_type  = _character_types[__.players.character.type_combo_select_index];
									var _character_name  = _character_data[$ _character_type].meta.name;
									
									#region [create]
								
									if (ImGui.Button("create")) {
										var _x	   = random_range(100, room_width  - 100);
										var _y	   = random_range(100, room_height - 100);
										var _depth = 0;
										_player.character_create(_character_type, _x, _y, _depth);
									}
								
									#endregion
									#region [type (v)]
								
									ImGui.SameLine();
									if (ImGui.BeginCombo("", _character_name, ImGuiComboFlags.None)) {
										for (var _i = 0, _len_i = array_length(_character_types); _i < _len_i; _i++) {
											_is_selected	= (_i == __.players.character.type_combo_select_index);
											_character_type = _character_types[_i];
											_character_name = _character_data[$ _character_type].meta.name;
											if (ImGui.Selectable(_character_name, _is_selected)) {
												__.players.character.type_combo_select_index = _i;
												ImGui.SetItemDefaultFocus();
											}
										};
										ImGui.EndCombo(); 
									}
									
									#endregion
									ImGui.EndChild();
								}
								ImGui.Separator();
								// -------------------------------------------------- //
								ImGui.Text("characters:");
								var _characters_struct = _player.character_get_all();
								var _characters_types  =  variable_struct_get_names(_characters_struct);
								for (var _j = 0, _len_j = array_length(_characters_types); _j < _len_j; _j++) {
									var _character_type		  = _characters_types[_j];
									var _character_type_index = "(" + string(_j + 1) + ") "; 
									var _character_type_name  = _character_type_index + _character_type;
									// ---------------------------------------------- //
									if (ImGui.TreeNode(_character_type_name)) {
										var _character_array = _characters_struct[$ _character_type];
										for (var _k = 0, _len_k = array_length(_character_array); _k < _len_k; _k++) {
											var _char		 = _character_array[_k];
											var _character_index = "(" + string(_k + 1) + ") ";
											var _character_name  = _char.get_uid() ?? "character";
												_character_name  = _character_index + _character_name;
											ImGui.Text("ref: " + string(_character_name));
										};
									}
								};
							}
							
							#endregion
						}
					};
				ImGui.EndChild();
				ImGui.EndMenu(); 
			}
			
			#endregion
				
		ImGui.EndMainMenuBar(); }
	}
	
	