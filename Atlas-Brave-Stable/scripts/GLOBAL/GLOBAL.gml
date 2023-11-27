
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __       ______   ______   ______   __        //
	// /\  ___\ /\ \     /\  __ \ /\  == \ /\  __ \ /\ \       //
	// \ \ \__ \\ \ \____\ \ \/\ \\ \  __< \ \  __ \\ \ \____  //
	//  \ \_____\\ \_____\\ \_____\\ \_____\\ \_\ \_\\ \_____\ //
	//   \/_____/ \/_____/ \/_____/ \/_____/ \/_/\/_/ \/_____/ //
	//                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// CONFIG ================================================ //
	#macro ADMIN			true
	#macro DEBUG			ADMIN && 1
	#macro Computer:ADMIN	false
	#macro Console:ADMIN	false
	#macro Mobile:ADMIN		false
	
	// DEBUG ================================================= //
	global.imgui_active		= ((os_type == os_windows) && (asset_get_index("ImGui_") != -1));
	#macro IMGUI_ACTIVE		global.imgui_active
	#macro DEBUG_OVERLAY	DEBUG && !MEDIA_MODE && os_type == os_macosx
	
	if (DEBUG_OVERLAY) show_debug_overlay(true);
	if (IMGUI_ACTIVE ) ImGui.__Initialize();
	
	#macro MEDIA_MODE  false
	
	// SAVE & LOAD =========================================== //
	#macro PLAYER_PROFILE_FILE_DIR			game_project_name + "/player/profiles/"
	#macro PLAYER_PROFILE_FILE_TYPE			".buf"
	
	#macro CHARACTER_SPRITE_DATA_FILE_DIR	""
	#macro CHARACTER_SPRITE_DATA_FILE_NAME	"ANIM_DATA_TEST"
	#macro CHARACTER_SPRITE_DATA_FILE_TYPE	".save"
	#macro CHARACTER_SPRITE_DATA_FILE_PATH	(CHARACTER_SPRITE_DATA_FILE_DIR + CHARACTER_SPRITE_DATA_FILE_NAME + CHARACTER_SPRITE_DATA_FILE_TYPE)
	
	// NETWORKING ============================================ //
	
	// VISUALS =============================================== //
	#macro COLOR_RED		#e92f34
	#macro COLOR_BLUE		#2f63e9
	#macro COLOR_GREEN		#40dc3e
	#macro COLOR_YELLOW		#efb82d
	#macro COLOR_WHITE		#F9EBE2
	
	// MISCELLANEOUS ========================================= //
	#macro SECOND		(room_speed)
	#macro MINUTE		(SECOND * 60)
	
	#macro BROADCAST	 objc_radio.broadcast
	#macro SUBSCRIBE	 objc_radio.subscribe
	#macro UNSUBSCRIBE	 objc_radio.unsubscribe
	
	#macro SURF_W		 surface_get_width (application_surface)
	#macro SURF_H		 surface_get_height(application_surface)
	
	#macro CHARACTER_SELECT_COUNTDOWN_TIME (DEBUG ? 1 : SECOND * 3)

	