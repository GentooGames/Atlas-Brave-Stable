
	function EditorFrame(_config = {}) constructor {
		owner					= _config[$ "owner"		] ?? other;
		frame_time				= 0;																// current animation time
		step_count			=	 _config[$ "step_count"	] ?? 6;	// 10 fps
	
		static set_step_count = function(_time) {
			step_count = _time;
			return self;
		}
	}