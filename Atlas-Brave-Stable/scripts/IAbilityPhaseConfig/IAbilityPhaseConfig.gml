	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __  __   ______   ______   ______    //
	// /\  == \/\ \_\ \ /\  __ \ /\  ___\ /\  ___\   //
	// \ \  _-/\ \  __ \\ \  __ \\ \___  \\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_\ \_\\/\_____\\ \_____\ //
	//   \/_/    \/_/\/_/ \/_/\/_/ \/_____/ \/_____/ //
	//                                               //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IAbilityPhaseConfig(_config = {}) constructor {
		
		#region config {}
		/*
			config = {
				phase:									phase is an integer value representing the defined
														phase index. every phase must have this value and will
														crash if undefined, as it is crucial when determining
														phase order.
														
				duration:								duration represents the time that it will take for the 
														phase to execute. if the duration is long, then the 
														sprite's animation speed will be stretched out slowly
														to match the given duration. if the duration is short,
														then the sprite's animation speed will be sped up quickly
														to match the given duration. the ability's attack_speed
														value is used as a multiplier to adjust this value 
														dynamically during gameplay.
										
				image_speed:							conversely, ability_phase sprite timings can be controlled
														using an image_speed parameter instead of using the duration
														parameter listed above. sometimes, conceptually, it will make
														more sense to think of the phase as having a speed. as a result,
														the image_speed parameter controls the speed of the image
														animation. 
														
				
				uses_speed:								because the <duration> and <image_speed> parameters handle the
														same aspect of phase-timing, both cannot be used at the same
														time. set uses_speed = true if you wish to use image_speed as 
														the control paremeter, or set image_speed to false if you wish
														to use duration as the control parameter.
				
				repetitions:							number of times that the ability_phase should repeat.
														a value of 1 means that this phase will only execute once.
														a value of -1 means that this phase will repeat indefinitely
														until the condition_next() or condition_cancel() condition 
														methods are met.
																				
				charge_rate:							some abilities will implement a charging mechanic. this would 
														be seen in something like a "charge for x seconds, and the 
														longer you charge, the more powerful this ability is". 
														because of this, the charge system has been implemented. a 
														charge rate determines how much charge is gained per frame, 
														by default, if charge is implemented, then this should be 1.
				
				charge_limit:							a charge limit is the maximum value that the charge value can 
														be. unlike the threshold, the charge value will NEVER exceed 
														the charge_limit.
														
				charge_threshold:						the charge_threshold is the value in which the ability is 								
														considered "charged" if we were to invoke the Ability.charge_is_charged()
														method. if the charge_limit is greate than the threshold, then
														it is possible that the ability will be considered charged if it
														is above the threshold, but even if it is still below the limit.
					
				goto_next_phase:						this function should return true if we wish the current ability
														phase to be progressed into the next phase. this is generally 
														used with abilities that either charge, or have repetitions = -1.
														
				on_start:								callbacks is a struct containing nested data that is associated 
				on_stop:								to the callback data for the ability phase. this is similar 
				on_running:								to the phase level instead. see the ability callbacks for more 
														info about what each of these callbacks do/how they are handled.
														
			};												
		*/
		#endregion
		
		phase_id		  =  _config[$ "phase_id"		 ] ?? undefined;					
		duration		  =  _config[$ "duration"		 ] ?? SECOND;
		uses_speed		  =  _config[$ "uses_speed"		 ] ?? true;			//g* - to be removed - speed_coeff
		repetitions		  =  _config[$ "repetitions"	 ] ?? 1;			//g* - to be removed
		input_limit		  =  _config[$ "input_limit"	 ] ?? undefined;	// How much to limit the range of the input angle		
		input_window	  =  _config[$ "input_window"	 ] ?? [0,0];		// What frame(s) to get the input angle on, defaulted to frame 0
		charge_min		  =  _config[$ "charge_min"		 ] ?? 0;
		charge_max		  =  _config[$ "charge_max"		 ] ?? 0;
		charge_rate		  =  _config[$ "charge_rate"	 ] ?? 1;
		goto_next_phase	  =  _config[$ "goto_next_phase" ] ?? function(_char, _ability, _phase) {};
		on_start		  =  _config[$ "on_start"		 ] ?? function(_char, _ability, _phase) {};
		on_complete		  =  _config[$ "on_complete"	 ] ?? function(_char, _ability, _phase) {};
		on_success		  =  _config[$ "on_success"		 ] ?? function(_char, _ability, _phase) {};
		on_fail			  =  _config[$ "on_fail"		 ] ?? function(_char, _ability, _phase) {};
		on_cancel		  =  _config[$ "on_cancel"		 ] ?? function(_char, _ability, _phase) {};
		on_running		  = (_config[$ "on_update"		 ] ?? _config[$ "on_running"]) ?? function(_char, _ability, _phase) {};
		on_animation_end  =  _config[$ "on_animation_end"] ?? function(_char, _ability, _phase) {};
		
	};
	