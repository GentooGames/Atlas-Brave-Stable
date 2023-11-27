
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______  __       ______  ______  ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  == \/\ \     /\  ___\/\__  _\/\  ___\   //
	// \ \ \____\ \ \/\ \\ \ \-./\ \\ \  _-/\ \ \____\ \  __\\/_/\ \/\ \  __\   //
	//  \ \_____\\ \_____\\ \_\ \ \_\\ \_\   \ \_____\\ \_____\ \ \_\ \ \_____\ //
	//   \/_____/ \/_____/ \/_/  \/_/ \/_/    \/_____/ \/_____/  \/_/  \/_____/ //
	//                                                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function AbilityCompleteTrigger(_config = {}) constructor {
		
		// public
		static start	= function(_char, _ability, _phase) {};
		static check	= function(_char, _ability, _phase) {};
		static complete = function(_char, _ability, _phase) {};
	};	
	
	function AbilityCompleteTrigger_Duration(_config = {}) : AbilityCompleteTrigger(_config) constructor {
		
		// public
		static start	= function(_char, _ability, _phase) {
			_ability.blackboard_write("duration", __.duration);
		};
		static check	= function(_char, _ability, _phase) {
			var _duration  = _ability.blackboard_read("duration") - 1;
			if (_duration <= 0) {
				_phase.complete();
			}
			else {
				_ability.blackboard_write("duration", _duration - 1);
			}
		};
		static complete = function(_char, _ability, _phase) {
			_ability.blackboard_erase("duration", __.duration);
		};
		
		// private 
		__ = {};
		with (__) {
			duration = _config[$ "duration"] ?? 60;
		};
		
	};
	
	function AbilityCompleteTrigger_AnimationEnd(_config = {}) : AbilityCompleteTrigger(_config) constructor {
	
		// public
		static check = function(_char, _ability, _phase) {
			if (_char.sprite_animation_end()) {
				if (_ability.phase_buffered()) {
					_ability.next_phase();	
				}
				else {
					_ability.complete();
				}
			}
		};
		
	};
	
	