
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   ______  ______   __    __    //
	// /\ \ /\__  _\/\  ___\ /\ "-./  \   //
	// \ \ \\/_/\ \/\ \  __\ \ \ \-./\ \  //
	//  \ \_\  \ \_\ \ \_____\\ \_\ \ \_\ //
	//   \/_/   \/_/  \/_____/ \/_/  \/_/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_item.create //
	event_inherited();
	var _self = self;
	
	// public
	get_x	 = function() {
		return __.x;	
	};
	get_y	 = function(_apply_z = true) {
		if (_apply_z) {
			return y - __.z;	
		}
		return y;
	};
	get_z	 = function() {
		return __.z;	
	};
	get_cost = function() {
		return __.data.cost;	
	};
	
	// private
	with (__) {
		depth_sort			   = method(_self, function() {
			depth = -bbox_bottom;
		});
		update_bob			   = method(_self, function() {
			__.bob_iter += __.bob_speed;
			__.z = abs(sin(__.bob_iter)) * __.bob_height;
		});
		update_character_close = method(_self, function() {
			var _character  = iceberg.collision.ellipse(x, bbox_bottom, __.prompt_radius, obj_hero);
			if (_character != noone) {
				__.character_in_prompt = true;
			}
			else {
				__.character_in_prompt = false;
			}
		});
		render_prompt_radius   = method(_self, function() {
			iceberg.draw.ellipse(x, bbox_bottom, __.prompt_radius, c_white, true);
		});
		render_sprite		   = method(_self, function() {
			draw_shadow_ellipse(9, 4, x - 0.5, bbox_bottom - 1, -__.z,, __.alpha);
			draw_sprite_ext(sprite_index, image_index, x, get_y(true), image_xscale, image_yscale, image_angle, image_blend, __.alpha);
		});
		render_cost			   = method(_self, function() {
			if (__.cost_alpha > 0) {
				var _scale = 0.25;
				var _cost  = get_cost();
				var _x	   = x - string_width(_cost) * _scale * 0.5;
				var _y	   = bbox_top - (string_height(_cost) * _scale) - __.bob_height;
				var _color = c_white;
				draw_text_transformed_color(_x, _y, _cost, _scale, _scale, 0, _color, _color, _color, _color, __.cost_alpha);
			}
			__.cost_alpha = lerp(__.cost_alpha, __.character_in_prompt, 0.2);
		});
		
		// stats
		data				   = global.item_data[$ _self.get_uid()];
	//	rarity ...
	//	rest of stats here ...
		
		// movement
		bob_height			   = _self[$ "bob_height"   ] ?? 6;
		bob_speed			   = _self[$ "bob_speed"	] ?? 0.035;
		prompt_radius		   = _self[$ "prompt_radius"] ?? 30;
		arc_curve			   =  new IB_TweenCurve({
			curve_index:	crv_item,
			curve_channel: "arc",
			auto_destroy:	false,
			value_end:	   _self[$ "arc_height"] ?? 30,
			duration:	   _self[$ "arc_time"  ] ?? 20,
		});
		
		z					   = 0;
		bob_iter			   = 0;
		alpha				   = 0;
		cost_alpha			   = 0;
		character_in_prompt	   = false;
		character_in_buy	   = false;
		
		arc_curve.on_start(method(_self, function() {
			image_xscale = 0.6;
		}));
		arc_curve.on_stop (method(_self, function() {
			__.arc_curve.deactivate();
			image_xscale = 1.0;
			image_yscale = 0.5;
			hspeed		 = 0.0;
			
		}));
	};
	
	on_initialize(function() {
		__.arc_curve.initialize();
		__.arc_curve.start();
		var _sprite_name = "spr_item_" + get_uid();
		sprite_index = asset_get_index(_sprite_name);
	});
	on_update	 (function() {
		__.depth_sort();
		__.arc_curve.update();
		__.update_character_close();
		
		// arc pop-off
		if (__.arc_curve.is_running()) {
			__.z	 = __.arc_curve.get_value_curve();	
			__.alpha = lerp(__.alpha, 1, 0.15);
			hspeed	 = lerp(hspeed, 0, 0.05);
		}
		// sin wave bobbing
		else {
			__.update_bob();
			__.alpha	 = 1;
			image_yscale = lerp(image_yscale, 1, 0.3);
		}
		
	});
	on_render	 (function() {
		__.render_prompt_radius();
		__.render_sprite();
		__.render_cost();
	});
	on_cleanup	 (function() {
		__.arc_curve.cleanup();
	});
	
	