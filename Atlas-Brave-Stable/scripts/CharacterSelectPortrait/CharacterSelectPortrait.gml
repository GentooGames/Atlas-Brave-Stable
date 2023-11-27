
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______  ______  ______   ______   __   ______  //
	// /\  == \/\  __ \ /\  == \/\__  _\/\  == \ /\  __ \ /\ \ /\__  _\ //
	// \ \  _-/\ \ \/\ \\ \  __<\/_/\ \/\ \  __< \ \  __ \\ \ \\/_/\ \/ //
	//  \ \_\   \ \_____\\ \_\ \_\ \ \_\ \ \_\ \_\\ \_\ \_\\ \_\  \ \_\ //
	//   \/_/    \/_____/ \/_/ /_/  \/_/  \/_/ /_/ \/_/\/_/ \/_/   \/_/ //
	//                                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function CharacterSelectPortrait(_config = {}) : IB_Entity(_config) constructor {

		var _self = self;
		
		// public
		static cursor_add	 = function(_cursor) {
			array_push(__.cursors, _cursor);
			if (_cursor.is_active() && !__.sprite.is_active()) {
				__.sprite.activate();
			}
			return self;
		};
		static cursor_exists = function(_cursor) {
			return iceberg.array.contains(__.cursors, _cursor);
		};
		static cursor_remove = function(_cursor) {
			iceberg.array.find_delete(__.cursors, _cursor);
			if (array_length(__.cursors) == 0 && __.sprite.is_active()) {
				__.sprite.deactivate();	
			}
			return self;
		};
		
		// private
		with (__) {
			static __render_character_sprite = function() {
				var _color = __.sprite.is_active() ? c_white : c_dkgray;
				__.sprite.color_set(_color);
				__.sprite.render();	
			};
			
			index	= _config[$ "index"] ?? undefined;
			type	= _config[$ "type" ] ?? "";
			cursors	=  [];
			sprite	=  new IB_Entity_Sprite({
				x:			_self.position_get_x() + (_self.size_get_width () * 0.5),
				y:			_self.position_get_y() + (_self.size_get_height() * 0.5),
				active:		 false,
				scale:		_self.scale_get(),	
				image_speed: 0.25,
			});
		};
			
		// events
		on_initialize(function() {
			var _character_data  = HERO_CONFIG[$ __.type];
			if (_character_data != undefined) {
				var _sprite_index = _character_data.sprite.portrait;
				__.sprite.sprite_set_sprite_index(_sprite_index);
			}
			__.sprite.initialize();
		});
		on_render_gui(function() {
			__render_character_sprite();
		});
	};
	
			
		
	 