	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_game.step //
	event_inherited();
	
	if (!DEBUG) exit;
	
	// toggle fullscreen
	//if (keyboard_check_pressed(vk_f11) 
	//||  keyboard_check_pressed(vk_f12)
	//|| (keyboard_check_pressed(ord("F")) && keyboard_check(vk_lcontrol))
	//) {
	//	window_set_fullscreen(!window_get_fullscreen());	
	//}
	
	// next room 
	if (keyboard_check(vk_lcontrol)
	&&  keyboard_check_pressed(vk_right)
	) {
		room_goto_next()
	}
	
	// previous room 
	if (keyboard_check(vk_lcontrol)
	&&  keyboard_check_pressed(vk_left)
	) {
		room_goto_previous()
	}
	
	// restart room 
	if (keyboard_check(vk_lcontrol)
	&&  keyboard_check_pressed(vk_down)
	) {
		room_restart()
	}
	