
//           _     _ _ _ _         
//     /\   | |   (_| (_| |        
//    /  \  | |__  _| |_| |_ _   _ 
//   / /\ \ | '_ \| | | | __| | | |
//  / ____ \| |_) | | | | |_| |_| |
// /_/    \_|_.__/|_|_|_|\__|\__, |
//                            __/ |
//                           |___/ 
/*
function iAbility(_config = {}) constructor {
	
	var __default =		global.ability_config[$ _config.name ]; // needs to have a default exception
	
	state =				PHASE.START;
	owner =				_config[$ "owner"]				?? other.id;
						
	name =				_config[$ "name"]				?? "Attack";	
	ability_type =		_config[$ "ability_type"]		?? __default.ability_type;
	trigger_prefix =	_config[$ "trigger_prefix"]		?? get_trigger_prefix();
	sprite_prefix =		_config[$ "sprite_prefix"]		?? get_sprite_prefix();
						
	phase_array =		_config[$ "phase_array"]		?? [];
	phase_id =			_config[$ "phase_id"]			?? 1;
	auto_phase =		_config[$ "auto_phase"]			?? false;		
	phase =				phase_array[0];					// every ability needs at least 1 phase
	
	cooldown =			_config[$ "cooldown"]			?? __default.cooldown;
	cd_trigger =		_config[$ "cd_trigger"]			?? "on_start";
	cd_timer =			_config[$ "cd_timer"]			?? 0;
	
	on_start =			_config[$ "on_start"]			?? function() {};
	on_update =			_config[$ "on_update"]			?? function() {};
	on_end =			_config[$ "on_end"]				?? function() {};
	
	speed_coeff	=		__default.speed_coeff;	
	energy_coeff =		__default.energy_coeff;
	
	input_angle =		noone; // ref to phase.input_angle
	
	combo =				false;
	cancel =			false;
	end_phase =			false;
	
	#region FUNCTIONS
	
	static update =					function() {
		if (cd_timer > 0) cd_timer --;
	}

	static check_next_phase =		function() {
		var _go_next = auto_phase || combo;
	
		if _go_next {
			if ( phase_id >= size(phase_array) ) _go_next = false;
		}
	
		return _go_next
	}
	
	static get_sprite_prefix =		function() {
		var _prefix = asset_get_name(owner.name +"_"+name);
	
		if ability_type == ABILITY.BASIC {
			_prefix = asset_get_name(owner.name +"_Attack");
		}
		return _prefix
	}
	
	static get_trigger_prefix =		function() {
		var _prefix = "None";
		
		switch (ability_type) {
		    case ABILITY.BASIC:
		        _prefix = "Basic";
		        break;
			case ABILITY.DEFENSE:
		        _prefix = "Defense";
		        break;
			case ABILITY.PRIMARY:
		        _prefix = "Primary";
		        break;
			case ABILITY.SECONDARY:
		        _prefix = "Secondary";
		        break;
		}
		
		return _prefix
	}
		
	static set_cooldown =			function() {
		cd_timer = cooldown;
	};	
	
	#endregion
	
}	




/*

	super_armor =		_config[$ "super_armor"]		?? ARMOR.NONE;	
	s_armor_trigger =	_config[$ "s_armor_trigger"]	?? "on_end";	// trigger to remove super armor
	s_armor_timer =		_config[$ "s_armor_timer"]		?? noone;		// timer that removes super armor
	
	invulnerable =		_config[$ "invulnerable"]		?? false;	
	invul_trigger =		_config[$ "invul_trigger"]		?? "on_end";	
	invul_timer =		_config[$ "invul_timer"]		?? noone;	


	set_cancel_trigger =	function(_type,_exit_frame) {
		cancel_trigger.type =		_type;
		cancel_trigger.exit_frame = _exit_frame;
	}

	reset_cancel_trigger =	function() {
		cancel = false;
		cancel_trigger.type =		noone;
		cancel_trigger.exit_frame = noone;
	}






















	