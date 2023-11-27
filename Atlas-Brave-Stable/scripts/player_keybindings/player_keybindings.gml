
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   ______   __  __   ______   __   __   __   _____    //
	// /\ \/ /  /\  ___\ /\ \_\ \ /\  == \ /\ \ /\ "-.\ \ /\  __-.  //
	// \ \  _"-.\ \  __\ \ \____ \\ \  __< \ \ \\ \ \-.  \\ \ \/\ \ //
	//  \ \_\ \_\\ \_____\\/\_____\\ \_____\\ \_\\ \_\\"\_\\ \____- //
	//   \/_/\/_/ \/_____/ \/_____/ \/_____/ \/_/ \/_/ \/_/ \/____/ //
	//                                                              //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	global.keybindings_default = {
		keyboard_mouse: {
			left:			   [{
				keys: [ vk_left, ord("A") ],
			}],
			right:			   [{
				keys: [ vk_right, ord("D") ],
			}],
			up:				   [{
				keys: [ vk_up, ord("W") ],
			}],
			down:			   [{
				keys: [ vk_down, ord("S") ],
			}],
			select:			   [{
				keys: [ ord("X"), ord("J") ],
			}],
			back:			   [{
				keys: [ ord("Z"), ord("K"), vk_backspace, vk_escape ],
			}],
			start:			   [{
				keys: [ vk_enter ],
			}],
			options:		   [{
				keys: [ vk_tab ],
			}],
			pause:			   [{
				keys: [ vk_escape ],
			}],
			next:			   [{
				keys: [ ord("E"), ord("I") ],
			}],
			previous:		   [{
				keys: [ ord("Q"), ord("U") ],
			}],
			ability_basic:	   [{
				keys: [ ord("J"), mb_left ],
			}],
			ability_defense:   [{
				keys: [ vk_space, ord("1") ],
			}],
			ability_primary:   [{
				keys: [ mb_right ],
			}],
			ability_secondary: [{
				keys: [ ord("3") ],
			}],
		},
		gamepad:		{
			left: [
				{ // button
					keys: [ gp_padl ],
				},
				{ // axis
					keys: [ gp_axislh ],
					operator: "<",
					value: 0,
				},
			],
			right: [
				{ // button
					keys: [ gp_padr ],
				},
				{ // axis
					keys: [ gp_axislh ],
					operator: ">",
					value: 0,
				},
			],
			up: [
				{ // button
					keys: [ gp_padu ],
				},
				{ // axis
					keys: [ gp_axislv ],
					operator: "<",
					value: 0,
				},
			],
			down: [
				{ // button
					keys: [ gp_padd ],
				},
				{ // axis
					keys: [ gp_axislv ],
					operator: ">",
					value: 0,
				},
			],
			select:			   [{
				keys: [ gp_face1 ],	
			}],
			back:			   [{
				keys: [ gp_face2 ],	
			}],
			start:			   [{
				keys: [ gp_start ],	
			}],
			options:		   [{
				keys: [ gp_select ],	
			}],
			pause:			   [{
				keys: [ gp_start ],
			}],
			next:			   [{
				keys: [ gp_shoulderr ],
			}],
			previous:		   [{
				keys: [ gp_shoulderl ],
			}],
			ability_basic:	   [{
				keys: [ gp_face3 ],
			}],
			ability_defense:   [{
				keys: [ gp_face1 ],
			}],
			ability_primary:   [{
				keys: [ gp_face2 ],
			}],
			ability_secondary: [{
				keys: [ gp_face4 ],
			}],
			
		},
	};
	