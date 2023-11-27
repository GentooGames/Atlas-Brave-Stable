
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __       __   ______  __  __    //
	// /\  __ \ /\  == \ /\ \ /\ \     /\ \ /\__  _\/\ \_\ \   //
	// \ \  __ \\ \  __< \ \ \\ \ \____\ \ \\/_/\ \/\ \____ \  //
	//  \ \_\ \_\\ \_____\\ \_\\ \_____\\ \_\  \ \_\ \/\_____\ //
	//   \/_/\/_/ \/_____/ \/_/ \/_____/ \/_/   \/_/  \/_____/ //
	//                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IAbilityConfig(_config = {}) constructor {
		
		#region config {}
		/*
			config = {
				on_start:								callbacks.on_start() is a callback function that is 
														triggered when the ability starts. this will happen
														before any of the phases start running. this is great
														for controlling certain locks, hitboxes, effects, sfx,
														etc, and should be used for things that are independent
														of certain frames.
														
				on_stop:								callbacks.on_stop() is a callback function that is
														triggered when the ability stops. this will happen
														after all of the phases finish running. this is great
														for controlling certain locks, hitboxes, effects, sfx,
														etc, and should be used for things that are independent
														of certain frames.
				
				on_next:								callbacks.on_next() is a callback function that is
														triggered when the ability moves onto the next phase of
														the sequence.
				
				on_running:								callbacks.on_running() is a callback function that is
														triggered every frame of the ability. this triggers once
														per frame. this cannot be called on_update, because the
														base class that the Ability inherits from already has a
														method called on_update, so this will simply act as a
														translation layer
				
				phases:									phases is an array of IAbilityPhaseConfig() instances
														this array of phases define the sequencing of the 
														ability and each sub-section of that ability.
														
				phase_advance:							phase_advance is a function that checks for whether a 		
														certain condition has been met, and if so, also return
														the target phase to advance to. this is used for more 
														quick transitions into an ability. the function should
														should take the following format:
														
														phase_advance: function(_char, _ability) {
															if (_char.ability_is_previous_type("defense")) {
																return { advance: true, index: 3 };
															}
															return { advance: false };
														},
														
														the phase_advance function needs to return a struct
														that contains at least one member "advance", which
														is a boolean that communicates whether or not the
														phase_advancement should happen, and if it returns
														true, then it should contain a second member called
														"index" which communicates the target phase to advance
														the ability into. 
														
				cooldown_time:							cooldown.time is a member inside of the cooldown
														struct, this defines what the cooldown time should
														be for the ability. this cooldown time starts as 
														soon as the ability has finished executing.
				
				cooldown_time_miscast:					if an ability has a charge phase, or has the ability
														to be canceled early (if the player lets go of the 
														input within a certain frame window, for example) 
														then this is the amount of time that will be applied
														to the cooldown. this allows for ability canceling
														but not without some sort of quick penaly. if this is
														not desired functionality, then set this to 0. this
														has to also be triggered manually by invoking:
														ability.miscast();
				
				charges_max:							an ability may be able to store additional charges in 
				charges_start:							a "back pocket". (think Reinhardt's Fire-Strike in OW)
				charges_consumed:						charges max is the max capacity of charges that can be
														held, and every ability by default will have at least 1.
														charges_start is the number of charges to spawn with, 
														and the charges consumed, is the number of charges to
														consume on each successful activation of the ability.
														
				
				condition_to_active:					condition_to_activate is a callback function that is
														checked before an ability can be activated. so if an
														ability requires a very specific activation condition
														such as possessing an item in an inventory, then that
														would be placed here. this condition always passes in
														the associated ability instance in as the parameter,
														and should return true if the condition determines that
														the ability can be activated. keep in mind that even if
														this condition does return true, if other conditions
														tied to activation are not ALSO met, then the ability
														may still not activate. this returning true doesnt 
														guarantee an activation trigger. it just adds another 
														layer of control if a very specific condition needs to
														also be met.
										
			};
		*/
		#endregion
		
		name				  =  _config[$ "name"				  ] ?? "";
		type				  =  _config[$ "type"				  ] ?? ABILITY.BASIC;	// see enum ABILITY
		phases				  =  _config[$ "phases"				  ] ?? [];
		activation_check	  =  _config[$ "activation_check"	  ] ?? function(_char, _ability, _phase) { return true;  }; // extra condition to check before ability will fire
		completion_trigger	  =  _config[$ "completion_trigger"	  ] ?? new AbilityCompleteTrigger_AnimationEnd();
		phase_advance		  =  _config[$ "phase_advance"		  ] ?? undefined;
		on_start			  =  _config[$ "on_start"			  ] ?? function(_char, _ability, _phase) {};
		on_complete			  =  _config[$ "on_complete"		  ] ?? function(_char, _ability, _phase) {};
		on_success			  =  _config[$ "on_success"			  ] ?? function(_char, _ability, _phase) {};
		on_fail				  =  _config[$ "on_fail"			  ] ?? function(_char, _ability, _phase) {};
		on_cancel			  =  _config[$ "on_cancel"			  ] ?? function(_char, _ability, _phase) {};
		on_phase_change		  =  _config[$ "on_phase_change"	  ] ?? function(_char, _ability, _phase) {};
		on_running			  = (_config[$ "on_update"			  ] ?? _config[$ "on_running"]) ?? function(_char, _ability, _phase) {};
		on_animation_end	  =  _config[$ "on_animation_end"	  ] ?? function(_char, _ability, _phase) {};
		cooldown_time		  =  _config[$ "cooldown_time"		  ] ?? 0;
		cooldown_time_miscast =  _config[$ "cooldown_time_miscast"] ?? SECOND;
		
	};
	