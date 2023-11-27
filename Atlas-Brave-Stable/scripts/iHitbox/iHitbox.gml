
//  _    _ _ _   _               
// | |  | (_| | | |              
// | |__| |_| |_| |__   _____  __
// |  __  | | __| '_ \ / _ \ \/ /
// | |  | | | |_| |_) | (_) >  < 
// |_|  |_|_|\__|_.__/ \___/_/\_\
/*                             
function iHitbox(_config = {}) constructor {
	
	//state =				PHASE.START;
	owner =				_config[$ "owner"]				?? other.id;
	
	ability =			_config[$ "ability"]			?? noone;	// ref to iAbility
	tween =				_config[$ "tween"]				?? noone;	// ref to iTween
	anchor =			_config[$ "anchor"]				?? owner;	
	
	damage =			_config[$ "damage"]				?? 0;
	hit_stun =			_config[$ "hit_stun"]			?? 0;
	offset =			_config[$ "offset"]				?? 0;
	input_angle =		_config[$ "input_angle"]		?? noone;	// grabbed from phase.input_angle if not passed in
	sprite_index =		_config[$ "sprite_index"]		?? noone;	// constructed from ability.sprite_prefix if not passed in

	duration =			_config[$ "duration"]			?? noone;
	
	hit_pause =			_config[$ "hit_pause"]			?? 5;
	hit_spark =			_config[$ "hit_spark"]			?? true;
	hit_limit =			_config[$ "hit_limit"]			?? noone;  
	hit_dir =			_config[$ "hit_dir"]			?? HIT_DIR.PUSH; 
	hit_text =			_config[$ "hit_text"]			?? HIT_TEXT.BASIC;  
	hit_area =			_config[$ "hit_area"]			?? HIT_AREA.ALL;  
	
	tick_rate =			0;
	repetitions =		noone;
	
	target_array =		_config[$ "target_array"]		?? [TARGET_TYPE.ENEMY];
	effect_trigger =	_config[$ "effect_trigger"]		?? noone;	// grabbed from ability.ability_type if not passed in
	
	on_hit_vfx =		_config[$ "on_hit_vfx"]			?? noone;	// iVFX struct
	on_hit_snd =		_config[$ "on_hit_snd"]			?? noone;	// iSND struct
	
	callback =			_config[$ "callback"]			?? function() {};	
	
	#region FUNCTIONS
	
	static init =			function() {
		state = PHASE.UPDATE;
		
		if ability != noone {
			var _phase = ability.phase;
		
			if sprite_index == noone {		// construct sprite
				sprite_index = hitbox_set_sprite(ability);
			}
		
			if input_angle == noone {		// get input angle from phase
				input_angle = _phase.input_angle;
			}
		
			if effect_trigger == noone {	// get effect trigger from ability
				effect_trigger = ability.trigger_prefix+"_Hit";
			}
		}
	}
	init();
		
	#endregion
}

/*





function hitbox_update_pseudo() {
	
	if ( place_meeting(x,y,obj_shield) ) { // Look for Shields 1st
		// get instance_place_list of all oShields
		var _inst =			obj_shield; // 
		var _ignore =		false; // check to see if this instance is already in the ignore_list
		var _trigger =		false; // check the target_trigger type against the colliding instance
		var _valid_dir =	false; // certain shields have a directional variable which means they will only 'block' an attack from the front
		
		if (!_ignore && _trigger && _valid_dir) {
			// add the colliding instancae to the ignore_list, so it can't trigger another collision
			
			// check for effect_triggers - loop through current instances effect_list
			
			// play relevant sfx and vfx
			
			// check if the shield is supposed to break hboxes and if this hbox can break
			if (_inst.break_hbox && break_on_shield) {
				// destroy the hitbox
				// subtract from the shields hit_limit (if any)
				// destroy the shield if the hit_limit == 0
			}
		}	
	}
	
	
	if ( place_meeting(x,y,obj_hurtbox) ) { // Look for Hurtboxes 2nd
		// get instance_place_list of all oHurtboxes
		var _inst =			obj_hurtbox; // 
		var _ignore =		false; // check to see if this instance is already in the ignore_list
		var _trigger =		false; // check the target_trigger type against the colliding instance
		var _valid_area =	false; // check for specific collision area if hit_area != HIT_AREA.ALL
		
		if (!_ignore && _trigger && _valid_area) {
			// add the colliding instancae to the ignore_list, so it can't trigger another collision
			
			// play relevant sfx and vfx
			
			// check for effect_triggers - loop through current instances effect_list
			
			// apply damage and any buffs effects
				// apply all relevant hitbox variables to the colliding instance
				// put colliding instance into a hit stun state
			
			// subtract from the hitboxes hit_limit (if any)
			// destroy the instance if hit_limit == 0
		}	
	}
	
	if (!hit_pause) duration --;
	if (duration == 0) instance_destroy();
}