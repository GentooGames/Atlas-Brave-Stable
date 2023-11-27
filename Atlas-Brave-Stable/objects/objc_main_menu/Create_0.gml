	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   __   __   __  __    //
	// /\ "-./  \ /\  ___\ /\ "-.\ \ /\ \/\ \   //
	// \ \ \-./\ \\ \  __\ \ \ \-.  \\ \ \_\ \  //
	//  \ \_\ \ \_\\ \_____\\ \_\\"\_\\ \_____\ //
	//   \/_/  \/_/ \/_____/ \/_/ \/_/ \/_____/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_main_menu.create //
	
	active  = false;
	visible = false;
	
	////////////////////////////
	
	event_inherited();
	var _self = self;
	
	// private
	with (__) {
		render_bg	 = method(_self, function() {
			static _width  = sprite_get_width (spr_title_bg);
			static _height = sprite_get_height(spr_title_bg);
			var	   _scale  = SURF_H / _height;
			var	   _x	   = ((_width * _scale) - SURF_W) * -0.75;
			var    _y	   = 0;
				   _x	  += iceberg.tween.wave(-100, 100, 60);
			draw_sprite_ext(spr_title_bg, 0, _x, _y, _scale, _scale, 0, c_white, 0.6);
		});
		render_title = method(_self, function() {
			
			static _x	  = 300;
			var	   _y	  = 300 + iceberg.tween.wave(0, 10, 25);
			var	   _angle = iceberg.tween.wave(-3, 3, 45);
			
			// drop shadow
			static _x_margin = 10;
			static _y_margin = 10;
			draw_sprite_ext(spr_title_bg_header, 0, _x + _x_margin, _y + _y_margin, 1, 1, _angle, c_black, 0.6);
			
			// core sprite
			draw_sprite_ext(spr_title_bg_header, 0, _x, _y, 1, 1, _angle, c_white, 1);
		});
		
		// state
		fsm = new SnowState("main", false, {
			owner: _self,
		});
		fsm.add("main", {
			enter:	  function() {},
			step:	  function() {
				__.slab_stack.update();
			},
			draw_gui: function() {
				__.slab_stack.render_gui();
			},
			leave:	  function() {},
		});
			
		// audio
		emitter = audio_emitter_create();
		
		// slab
		slab_stack = new MenuSlabStack({
			x:					 SURF_W - 400,
			y:					 600,
			indentation_per:	 0,
			select_indentation: -50,
			select_color:		 COLOR_RED,
			unselect_color:		 c_white,
		});
		var _slab_config = {
			width:		  500,
			height:		  60,
			text_color:	  c_black,
			text_scale:	  1,
			text_padding: 20,
		};
		slab_stack.new_slab("local game",	   method(_self, function() {
			room_goto(rm_character_select);
		}), _slab_config);
		slab_stack.new_slab("settings",		   method(_self, function() {
			// ...
		}), _slab_config);
		slab_stack.new_slab("exit to desktop", method(_self, function() {
			game_end();
		}), _slab_config);	
		slab_stack.on_select	  (method(_self, function() {
			audio_play_sound_on(__.emitter, sfx_confirm, false, 0);
		}));
		slab_stack.on_index_change(method(_self, function() {
			audio_play_sound_on(__.emitter, sfx_navigate, false, 0);
		}));
	};
	
	// events
	on_initialize(function() {
		__.slab_stack.initialize();
	});
	on_update	 (function() {
		__.fsm.step();
	});
	on_render_gui(function() {
		__.render_bg();
		__.render_title();
		__.fsm.draw_gui();
	});
	on_room_start(function() {
		switch (room) {
			case rm_main_menu: 
				show();
				activate();
				break;
		};
	});
	on_room_end	 (function() {
		switch (room) {
			case rm_main_menu: 
				hide();
				deactivate();
				break;
		};
	});
	
	
	