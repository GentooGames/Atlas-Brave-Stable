
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______   ______   ______   ______  ______   ______    //
	// /\  ___\ /\ \_\ \ /\  __ \ /\  == \ /\  __ \ /\  ___\ /\__  _\/\  ___\ /\  == \   //
	// \ \ \____\ \  __ \\ \  __ \\ \  __< \ \  __ \\ \ \____\/_/\ \/\ \  __\ \ \  __<   //
	//  \ \_____\\ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_____\  \ \_\ \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_/\/_/ \/_/\/_/ \/_/ /_/ \/_/\/_/ \/_____/   \/_/  \/_____/ \/_/ /_/ //
	//																					 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function character_state_base() {
		//  ______   ______   ______   ______    //
		// /\  == \ /\  __ \ /\  ___\ /\  ___\   //
		// \ \  __< \ \  __ \\ \___  \\ \  __\   //
		//  \ \_____\\ \_\ \_\\/\_____\\ \_____\ //
		//   \/_____/ \/_/\/_/ \/_____/ \/_____/ //
		//                                       //
		return {
			enter:		   function() {},
			begin_step:    function() {},
			step:		   function() {},
			end_step:	   function() {},
			draw:		   function() {},
			draw_gui:	   function() {},
			leave:		   function() {},
			animation_end: function() {},
		};
	};
	
	/*---*/function character_state_actions_free() {
			//  ______  ______   ______   ______    //
			// /\  ___\/\  == \ /\  ___\ /\  ___\   //
			// \ \  __\\ \  __< \ \  __\ \ \  __\   //
			//  \ \_\   \ \_\ \_\\ \_____\\ \_____\ //
			//   \/_/    \/_/ /_/ \/_____/ \/_____/ //
			//                                      //
			return {
				enter:		   function() {
					__.IB.log("state moving enter", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
					__.state.fsm.inherit();
					sprite_change("Move");
				},
				begin_step:    function() {
					__.state.fsm.inherit();
					__.movement.controller.update_begin();
				},
				step:		   function() {
					__.state.fsm.inherit();
					
					// movement
					var _motor = __.input.move_vector.has_magnitude();
					__.movement.controller.motor_add_switch(_motor);
					__.movement.controller.steer_add_vector(__.input.move_vector);
					__.movement.controller.update();
				
					// update character's position to match move controller update
					position_adjust_x(__.movement.controller.velocity_get_x_output());
					position_adjust_y(__.movement.controller.velocity_get_y_output());
					x = position_get_x();	   // pull x from entity and apply to character
					y = position_get_y(false); // pull y from entity and apply to character
					
					// sprite
					__.sprite.set_facing_to_input();
					
					// interactions
					__.item.item_purchase_check_interaction();
					__.item.chest_open_check_interaction();
					
					// state transition triggers
					__.state.fsm.trigger("t_ability");
				},
				end_step:	   function() {
					__.state.fsm.inherit();
					__.movement.controller.update_end();
				},
				draw:		   function() {
					__.state.fsm.inherit();
				},
				draw_gui:	   function() {
					__.state.fsm.inherit();
				},
				leave:		   function() {
					__.state.fsm.inherit();
					__.IB.log("state moving leave", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
				},	
				animation_end: function() {
					__.state.fsm.inherit();
				},
			};
		};
	/*--------*/function character_state_idle() {
					//  __   _____    __       ______    //
					// /\ \ /\  __-. /\ \     /\  ___\   //
					// \ \ \\ \ \/\ \\ \ \____\ \  __\   //
					//  \ \_\\ \____- \ \_____\\ \_____\ //
					//   \/_/ \/____/  \/_____/ \/_____/ //
					//                                   //
					return {
						enter:		   function() {
							__.state.fsm.inherit();	
							__.IB.log("state idle enter", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
							sprite_change("Idle");
						},
						begin_step:    function() {
							__.state.fsm.inherit();
						},
						step:		   function() {
							__.state.fsm.inherit();
							__.state.fsm.trigger("t_move");
						},
						end_step:	   function() {
							__.state.fsm.inherit();
						},
						draw:		   function() {
							__.state.fsm.inherit();	
						},
						draw_gui:	   function() {
							__.state.fsm.inherit();	
						},
						leave:		   function() {
							__.state.fsm.inherit();
							__.IB.log("state idle leave", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
						},
						animation_end: function() {
							__.state.fsm.inherit();
						},
					};
				};
	/*--------*/function character_state_move() {
					//  __    __   ______   __   __ ______    //
					// /\ "-./  \ /\  __ \ /\ \ / //\  ___\   //
					// \ \ \-./\ \\ \ \/\ \\ \ \'/ \ \  __\   //
					//  \ \_\ \ \_\\ \_____\\ \__|  \ \_____\ //
					//   \/_/  \/_/ \/_____/ \/_/    \/_____/ //
					//                                        //
					return {
						enter:		   function() {
							__.state.fsm.inherit();	
							__.IB.log("state move enter", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
							sprite_change("Move");
						},
						begin_step:    function() {
							__.state.fsm.inherit();
						},
						step:		   function() {
							__.state.fsm.inherit();
							__.state.fsm.trigger("t_idle");
						},
						end_step:	   function() {
							__.state.fsm.inherit();
						},
						draw:		   function() {
							__.state.fsm.inherit();	
						},
						draw_gui:	   function() {
							__.state.fsm.inherit();	
						},
						leave:		   function() {
							__.state.fsm.inherit();
							__.IB.log("state move leave", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
						},
						animation_end: function() {
							__.state.fsm.inherit();
						},
					};
				};
	
	/*----*/function character_state_actions_locked() {
				//  __       ______   ______   __  __   ______   _____    //
				// /\ \     /\  __ \ /\  ___\ /\ \/ /  /\  ___\ /\  __-.  //
				// \ \ \____\ \ \/\ \\ \ \____\ \  _"-.\ \  __\ \ \ \/\ \ //
				//  \ \_____\\ \_____\\ \_____\\ \_\ \_\\ \_____\\ \____- //
				//   \/_____/ \/_____/ \/_____/ \/_/\/_/ \/_____/ \/____/ //
				//                                                        //
				return {
					enter:		   function() {
						__.state.fsm.inherit();
					},
					begin_step:    function() {
						__.state.fsm.inherit();
					},
					step:		   function() {
						__.state.fsm.inherit();
					},
					end_step:	   function() {
						__.state.fsm.inherit();
					},
					draw:		   function() {
						__.state.fsm.inherit();
					},
					draw_gui:	   function() {
						__.state.fsm.inherit();
					},
					leave:		   function() {
						__.state.fsm.inherit();
					},
					animation_end: function() {
						__.state.fsm.inherit();
					},
				};
			};
	/*--------*/function character_state_hurt() {
					//  __  __   __  __   ______  ______  //
					// /\ \_\ \ /\ \/\ \ /\  == \/\__  _\ //
					// \ \  __ \\ \ \_\ \\ \  __<\/_/\ \/ //
					//  \ \_\ \_\\ \_____\\ \_\ \_\ \ \_\ //
					//   \/_/\/_/ \/_____/ \/_/ /_/  \/_/ //
					//                                    //		
					return {
						enter:		   function() {
							__.state.fsm.inherit();
							sprite_change("Hurt", 0);
							__.IB.log("state hurt enter", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
						},
						begin_step:    function() {
							__.state.fsm.inherit();
						},
						step:		   function() {
							__.state.fsm.inherit();
						},
						end_step:	   function() {
							__.state.fsm.inherit();	
						},
						draw:		   function() {
							__.state.fsm.inherit();	
						},
						draw_gui:	   function() {
							__.state.fsm.inherit();	
						},
						leave:		   function() {
							__.state.fsm.inherit();
							__.IB.log("state hurt leave", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
						},
						animation_end: function() {
							__.state.fsm.inherit();
						},
					};
				};
	/*--------*/function character_state_death() {
					//  _____    ______   ______   ______  __  __    //
					// /\  __-. /\  ___\ /\  __ \ /\__  _\/\ \_\ \   //
					// \ \ \/\ \\ \  __\ \ \  __ \\/_/\ \/\ \  __ \  //
					//  \ \____- \ \_____\\ \_\ \_\  \ \_\ \ \_\ \_\ //
					//   \/____/  \/_____/ \/_/\/_/   \/_/  \/_/\/_/ //
					//                                               //		
					return {
						enter:		   function() {
							__.state.fsm.inherit();
							__.death.is_dead = true;
							sprite_change("Death", 0);
							BROADCAST("character_death", { instance: self });
							__.IB.log("state death enter", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
						},
						begin_step:    function() {
							__.state.fsm.inherit();
						},
						step:		   function() {
							__.state.fsm.inherit();
							if (sprite_animation_end()) {
								destroy();	
							}
						},
						end_step:	   function() {
							__.state.fsm.inherit();	
						},
						draw:		   function() {
							__.state.fsm.inherit();	
						},
						draw_gui:	   function() {
							__.state.fsm.inherit();	
						},
						leave:		   function() {
							__.state.fsm.inherit();
							__.IB.log("state death leave", IB_LOG_FLAG.CHARACTER & IB_LOG_FLAG.STATE);
						},
						animation_end: function() {
							__.state.fsm.inherit();
						},
					};
				};
	/*--------*/function character_state_ability() {
					//  ______   ______   __   __       __   ______  __  __    //
					// /\  __ \ /\  == \ /\ \ /\ \     /\ \ /\__  _\/\ \_\ \   //
					// \ \  __ \\ \  __< \ \ \\ \ \____\ \ \\/_/\ \/\ \____ \  //
					//  \ \_\ \_\\ \_____\\ \_\\ \_____\\ \_\  \ \_\ \/\_____\ //
					//   \/_/\/_/ \/_____/ \/_/ \/_____/ \/_/   \/_/  \/_____/ //
					//                                                         //
					return {
						enter:		   function() {
							__.state.fsm.inherit();	
							
							// wipe velocity
							move_velocity_zero_out();
							
							// trigger ability start
							var _phase_advance = __.ability.current.get_phase_advance();
						//	var _ability_speed =    ability_speed_mult_get(__.ability.current_type);
							__.ability.current.start(_phase_advance, function() {
								ability_complete(true, __.ability.current_type,, false, false);	
							});
						},
 						begin_step:    function() {
							__.state.fsm.inherit();	
						},
						step:		   function() {
							__.state.fsm.inherit();	
							
							// update input vector snapshot
							var _ability		= __.ability.current;
							var _ability_phase  = _ability.get_phase();
							var _image_index	= sprite_get_frame_index();
							var _input_window	= _ability_phase.get_input_window();
							var _input_limit	= 60;//_ability_phase.get_input_limit();
							
							if (input_window_check(_input_window, _image_index)) {
								input_move_vector_set_snapshot(,_input_limit);
							}
							
							__.ability.current.update();
						},
						end_step:	   function() {
							__.state.fsm.inherit();	
						},
						draw:		   function() {
							__.state.fsm.inherit();	
						},
						draw_gui:	   function() {
							__.state.fsm.inherit();	
						},
						leave:		   function() {
							__.state.fsm.inherit();	
							
							// get previous ability, because at this point
							// what is considered the "current" ability
							// reference has already been wiped. and now it
							// is stored as the previous ability.
							var _ability = __.ability.current;
							
							// unlock velocity
							var _ability_name = ability_get_unique_name(_ability);
							//move_velocity_lock_remove(_lock_name);
							//move_steer_lock_remove(_lock_name);
							
							tween_destroy(_ability_name);
							
							__.ability.check_clear();
						},
						animation_end: function() {
							__.state.fsm.inherit();
						},
					};
				};
	
	// triggers //
	function character_state_trigger_idle() {
		return !input_move_vector_get().has_magnitude();
	};
	function character_state_trigger_move() {
		return input_move_vector_get().has_magnitude();
	};
	function character_state_trigger_ability() {
		if (ability_can_start("basic") && input_ability_basic_pressed()) {
			__.ability.set_current("basic");
			return true;
		}
	
		if (ability_can_start("defense") && input_ability_defense_pressed()) {
			__.ability.set_current("defense");
			return true;
		}
		
		if (ability_can_start("primary") && input_ability_primary_pressed()) {
			__.ability.set_current("primary");
			return true;
		}
		
		if (ability_can_start("secondary") && input_ability_secondary_pressed()) {
			__.ability.set_current("secondary");
			return true;
		}

		return false;
	};
	
	