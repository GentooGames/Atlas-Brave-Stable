	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   _____    __   ______  ______   ______    //
	// /\  ___\ /\  __-. /\ \ /\__  _\/\  __ \ /\  == \   //
	// \ \  __\ \ \ \/\ \\ \ \\/_/\ \/\ \ \/\ \\ \  __<   //
	//  \ \_____\\ \____- \ \_\  \ \_\ \ \_____\\ \_\ \_\ //
	//   \/_____/ \/____/  \/_/   \/_/  \/_____/ \/_/ /_/ //
	//                                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_anim_editor.create //
	active = false;
	event_inherited();
	
	var _self = self;
	
	get_temp_data			= function() {
		var _temp_data = {};																													
		_temp_data[$	"Abel"	] = {	health :	90	, damage :	16	, defense :	12	, attack_speed :	90	, anim_speed :	0.25	, input_limit :	60	, move_speed :	100	, health_plv :	5	, damage_plv :	1	, armor_plv :	0.7	, attack_speed_plv :	0.8	, move_speed_plv :	0.5	, abilities :	["Abel Attack", "Roll", "Whirlwind", "Arc Slash"]	};
		_temp_data[$	"Arthur"	] = {	health :	100	, damage :	15	, defense :	14	, attack_speed :	95	, anim_speed :	0.25	, input_limit :	60	, move_speed :	97	, health_plv :	6	, damage_plv :	1	, armor_plv :	0.8	, attack_speed_plv :	0.8	, move_speed_plv :	0.5	, abilities :	["Arthur Attack", "Defend", "Hammer Throw", "Earthbreaker"]	};	
		return _temp_data
	}
		
	get_character			= function() {
		return __.character_current
	}
	set_character			= function(_index=0) {
		__.character_current = __.character_list[_index];
		return
	}
	set_character_sprite	= function(_index=0) {
		var _char = get_character();
		_char.sprite_current = _char.sprite_list[_index];
		return
	}
		
	// private
	with (__) {
		get_character_list = method(_self, function(_char_type = CHARACTER_TYPE.HERO) {
		
			var _char_struct = {}; 
		
			switch (_char_type) {
				case CHARACTER_TYPE.HERO:  _char_struct = get_temp_data();
				
				//case CHARACTER_TYPE.ENEMY: _char_struct = ENEMY_DATA;
			};
	
			var _names = variable_struct_get_names(_char_struct);
		
			for (var _i = 0, _len_i = array_length(_names); _i < _len_i; _i++) {
				var _name  = _names[_i];
				if (_name != "") { // skip empty data
					var _char = new EditorCharacter({ name: _name, });
					print("CREATING "+ _name);
					array_push(__.character_list, _char);
				}
			};
		});
		init_characters	   = method(_self, function() {
	
			for (var _i = 0, _len_i = array_length(__.character_list); _i < _len_i; _i++) {
			
				var _char		 = __.character_list[_i];
				//var _sprite_data = __.load_sprite_data(_char.name);
			
				//if (_sprite_data == undefined) continue;
			
				var _sprite_list = __.get_sprite_list(_char.name);
			
				for (var _j = 0, _len_j = array_length(_sprite_list); _j < _len_j; _j++) {
				
					var _sprite = new EditorSprite({
						name: _sprite_list[_j],
					});
					//_sprite.load_data(_sprite_data);
					print(_sprite.name);
					_char.add_sprite (_sprite);
				};
			};
		});
		get_sprite_list	   = method(_self, function(_name) {
		
			var _data = {};
	
			if (variable_struct_exists(HERO_DATA, _name)) {
				_data = HERO_DATA[$ _name];
			}
			else {
				_data = ENEMY_DATA[$ _name];
			}
	
			var _ability_list = _data.abilities;
			var _sprite_list  = [];
			var _core_sprites = ["Idle", "Move"];

			// CORE SPRITES
			for (var _i = 0, _len_i = array_length(_core_sprites); _i < _len_i; _i++) {
		
				var _sprite_string = asset_get_name("spr_" + _name + "_" + _core_sprites[_i]);
				array_push(_sprite_list, _sprite_string);
		
				//print(_sprite_string);
			};
	
			// ABILITY SPRITES
			for (var _i = 0, _len_i = array_length(_ability_list); _i < _len_i; _i++) {
			
				var _sprite_string = asset_get_name( "spr_"+_name+"_"+_ability_list[_i] );
		
				if (_i == 0) _sprite_string = asset_get_name("spr_" + _ability_list[_i]); // basic attacks
		
				var _next_sprite  =  asset_get_index(_sprite_string + "_1");
				if (_next_sprite == -1) {
					//print(_sprite_string);
					array_push(_sprite_list, _sprite_string);
				} 
				else {
					var _n = 1; 
					while (_next_sprite != -1) {
						//print(_sprite_string + "_" + string(_n));
						array_push(_sprite_list, sprite_get_name(_next_sprite));
						_n++;
						_next_sprite = asset_get_index(_sprite_string + "_" + string(_n));
					};
				}
			};
	
			return _sprite_list;
		});
		load_sprite_data   = method(_self, function(_name) {
			if (file_exists(__.filename)) {
		
				var _buffer = buffer_load(__.filename);
				var _string = buffer_read(_buffer, buffer_string);
				buffer_delete(_buffer);
		
				var _load_data = json_parse(_string);
		
				if (variable_struct_exists(_load_data, _name)) {
					var _char_data = _load_data[$_name];
					return _char_data;
				}
			}
			return undefined;
		});
		save_sprite_data   = method(_self, function() {	
		
			if (file_exists(__.filename)) {
				file_delete(__.filename);
			}

			var _save_data = {};
	
			for (var _n = 0, _len_n = array_length(__.character_list); _n < _len_n; _n++) {
		
				var _char = __.character_list[_n];
	
				_save_data[$ _char.name] = {};
		
				var _char_data = _save_data[$ _char.name];

				// Loop through animations
				for (var _i = 0, _len_i = array_length(_char.sprite_list); _i < _len_i; _i++) {
	    
					var _sprite_name = _char.sprite_list[_i].name;
					_char_data[$ _sprite_name] = []; // array for frame data
		
					// Loop through frames
					for (var _j = 0, _len_j = array_length(_char.sprite_list[_i].frame_list); _j < _len_j; _j++) {
			
						var _frame		 = _char.sprite_list[_i].frame_list[_j];
						var _sprite_data = _char_data[$ _sprite_name];
			
						_sprite_data[_j] = {};
						_sprite_data[_j][$ "step_count"] = _frame.step_count;
					};
				};
			};
	
			var _string = json_stringify(_save_data);
			var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
			buffer_write (_buffer, buffer_string, _string);
			buffer_save  (_buffer, __.filename);
			buffer_delete(_buffer);
		});
	
		character_list	   = [];
		character_current  = undefined;
	
		filename		   = CHARACTER_SPRITE_DATA_FILE_PATH;
	};
	
	// events
	on_room_start(function() {
		if (room == __rm_anim_editor) {
			show();
			activate();
			
			__.get_character_list();
			__.init_characters();
			set_character();
		}
	});
	on_room_end  (function() {
		if (room == __rm_anim_editor) {
			hide();
			deactivate();
		}
	});		

	on_update	 (function() {
		// IMGUI code
		//print("UPDATING ROOM");
	});
	
	