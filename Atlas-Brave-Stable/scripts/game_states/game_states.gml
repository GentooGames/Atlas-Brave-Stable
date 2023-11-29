	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
			function game_state_base() {
				return {
					enter:		function() {},
					begin_step: function() {
						if (IMGUI_ACTIVE) {
							ImGui.__Update();	
						}
					},
					step:		function() {},
					render_gui: function() {
						if (IMGUI_ACTIVE) {
							ImGui.__Render();	
						}
						draw_text(10, SURF_H - 30, room_get_name(room));
					},
					leave:		function() {},
				};
			};
	/*	0.	*/	function game_state_begin() {
					return {
						enter:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_begin enter", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
							__.state.fsm.change("create_controllers");
						},
						begin_step: function() {
							__.state.fsm.inherit();
						},
						step:		function() {
							__.state.fsm.inherit();
						},
						render_gui: function() {
							__.state.fsm.inherit();
						},
						leave:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_begin leave", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
					};
				};
	/*	1.	*/	function game_state_idle() {
					return {
						enter:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_idle enter", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
						begin_step: function() {
							__.state.fsm.inherit();
						},
						step:		function() {
							__.state.fsm.inherit();
						},
						render_gui: function() {
							__.state.fsm.inherit();
						},
						leave:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_idle leave", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
					};
				};
	/*	2.	*/	function game_state_create_controllers() {
					return {
						enter:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_create_controllers enter", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
							
							iceberg.controller_create(objc_radio);
							iceberg.controller_create(objc_difficulty);
							iceberg.controller_create(objc_main_menu);
							iceberg.controller_create(objc_character_select);
							iceberg.controller_create(objc_camera);
							iceberg.controller_create(objc_world);
							iceberg.controller_create(objc_spawn);
							iceberg.controller_create(objc_anim_editor);
							
							if (IMGUI_ACTIVE) {
								instance_create_depth(0, 0, 0, objc_nav_bar);
							}
								
							__.state.fsm.change("load_sprite_data");
						},
						begin_step: function() {
							__.state.fsm.inherit();
						},
						step:		function() {
							__.state.fsm.inherit();
						},
						render_gui: function() {
							__.state.fsm.inherit();
						},
						leave:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_create_controllers leave", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
					};
				};
	/*	3.	*/	function game_state_load_sprite_data() {
					return {
						enter:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_load_sprite_data enter", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
							
							if (file_exists(CHARACTER_SPRITE_DATA_FILE_PATH)) {
								var _buffer = buffer_load(CHARACTER_SPRITE_DATA_FILE_PATH);
								var _string = buffer_read(_buffer, buffer_string);
								var _data   = json_parse(_string);
								global.character_sprite_data = _data;
								__.state.fsm.change("init_global_data");
							}
						},
						begin_step: function() {
							__.state.fsm.inherit();
						},
						step:		function() {
							__.state.fsm.inherit();
						},
						render_gui: function() {
							__.state.fsm.inherit();
						},
						leave:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_load_sprite_data leave", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
					};
				};
	/*	4.	*/	function game_state_init_global_data() {
					return {
						enter:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_init_global_data enter", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
	
							global.ability_config = {};
							#macro ABILITY_CONFIG global.ability_config
							
							Abel_Abilities_Init();
							Arthur_Abilities_Init();
							Enzo_Abilities_Init();
							Viper_Abilities_Init();
							Giblin_Footman_Abilities_Init();
							
							__.state.fsm.change("init_controllers");
						},
						begin_step: function() {
							__.state.fsm.inherit();
						},
						step:		function() {
							__.state.fsm.inherit();
						},
						render_gui: function() {
							__.state.fsm.inherit();
						},
						leave:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_init_global_data leave", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
					};
				};
	/*	5.	*/	function game_state_init_controllers() {
					return {
						enter:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_init_controllers enter", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
							
							objc_radio.initialize();
							objc_difficulty.initialize();
							objc_main_menu.initialize();
							objc_character_select.initialize();
							objc_camera.initialize();
							objc_world.initialize();
							objc_spawn.initialize();
							objc_anim_editor.initialize();
							
							if (IMGUI_ACTIVE) {
								objc_nav_bar.initialize();
							}
							
							__.state.fsm.change("ready");
						},
						begin_step: function() {
							__.state.fsm.inherit();
						},
						step:		function() {
							__.state.fsm.inherit();
						},
						render_gui: function() {
							__.state.fsm.inherit();
						},
						leave:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_init_controllers leave", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
					};
				};
	/* 	7.	*/	function game_state_ready() {
					return {
						enter:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_ready enter", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
						begin_step: function() {
							__.state.fsm.inherit();
						},
						step:		function() {
							__.state.fsm.inherit();
							__.state.fsm.change("running");
						},
						render_gui: function() {
							__.state.fsm.inherit();
						},
						leave:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_ready leave", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
							room_goto_next();
						},
					};
				};
	/*	8.	*/	function game_state_running() {
					return {
						enter:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_running enter", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
						begin_step: function() {
							__.state.fsm.inherit();
						},
						step:		function() {
							__.state.fsm.inherit();
						},
						render_gui: function() {
							__.state.fsm.inherit();
						},
						leave:		function() {
							__.state.fsm.inherit();
							__.IB.log("game_state_running leave", IB_LOG_FLAG.GAME & IB_LOG_FLAG.STATE);
						},
					};
				};
	