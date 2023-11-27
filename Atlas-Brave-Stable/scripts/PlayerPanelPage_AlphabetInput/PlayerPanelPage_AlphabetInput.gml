
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   __   ______  __  __   ______  //
	// /\ \ /\ "-.\ \ /\  == \/\ \/\ \ /\__  _\ //
	// \ \ \\ \ \-.  \\ \  _-/\ \ \_\ \\/_/\ \/ //
	//  \ \_\\ \_\\"\_\\ \_\   \ \_____\  \ \_\ //
	//   \/_/ \/_/ \/_/ \/_/    \/_____/   \/_/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanelPage_AlphabetInput(_config = {}) : PlayerPanelPage(_config) constructor {
		
		static _alphabet  = [
			"a", "b", "c", "d", "e", 
			"f", "g", "h", "i", "j", 
			"k", "l", "m", "n", "o", 
			"p", "q", "r", "s", "t", 
			"u", "v", "w", "x", "y", 
			"z", "1", "2", "3", "4", 
			"5", "6", "7", "8", "9", 
			".", ",", " ", "_", "-", 
		];
		static _n_letters = array_length(_alphabet);
		
		var _self = self;
		
		// public
		static draw_alphabet	   = function(_x, _y, _scale = __.input_scale, _color = c_white) {
			
			var _space = (__.letter_width * 1.5) * _scale;
			var _dark  = merge_color(_color, c_black, 0.8);
					
			for (var _i = 0; _i < _n_letters; _i++) {
						
				var _letter		= _alphabet[_i];
				var _current	= _i == __.letter_index;
				var _this_color = _current ? _color : _dark;
						
				// draw each letter index
				draw_text_transformed_color(_x + ((_i - __.letter_index) * _space), _y, 
					_letter, _scale, _scale, 0, _this_color, _this_color, _this_color, _this_color, 1);
						
				// draw letter selection underscore
				if (_current) {
					draw_text_transformed_color(_x + ((_i - __.letter_index) * _space), _y + 10, 
						"_", _scale, _scale, 0, _color, _color, _color, _color, 1);
				}
			};
		};
		static draw_input		   = function(_x, _y, _scale = __.input_scale, _color = c_white) {
			draw_text_transformed_color(_x, _y, get_input(), _scale, _scale, 0,
				_color, _color, _color, _color, 1);	
		};
		static draw_input_prompt   = function(_x, _y, _scale = __.input_prompt_scale, _color = c_white) {
			draw_text_transformed_color(_x, _y, get_input_prompt(), _scale, _scale, 0,
				_color, _color, _color, _color, 1);
		};
		static get_input		   = function() {
			return __.input;
		};
		static get_input_prompt	   = function() {
			return __.input_prompt;
		};
		static get_input_length	   = function() {
			return string_length(__.input);
		};
		static is_editing_letters  = function() {
			return __.letters_editing;	
		};
		static set_editing_letters = function(_editing) {
			__.letters_editing = _editing;
			return self;
		};
		
		// private
		with (__) {
			static __letter_delete	 = function() {
				__.input = iceberg.text.delete_last(__.input);
			};
			static __letter_next	 = function() {
				__.letter_index = iceberg.math.wrap(
					__.letter_index + 1,
					0,
					_n_letters - 1,
				);
			};
			static __letter_previous = function() {
				__.letter_index = iceberg.math.wrap(
					__.letter_index - 1,
					0,
					_n_letters - 1,
				);
			};
			static __letter_select	 = function() {
				__.input += _alphabet[__.letter_index];
			};	
			
			input			   = _config[$ "input"			   ] ?? "";
			input_prompt	   = _config[$ "input_prompt"	   ] ?? "enter input";
			input_scale		   = _config[$ "input_scale"	   ] ?? 2.0;
			input_prompt_scale = _config[$ "input_prompt_scale"] ?? 1.5;
			letters_editing	   = _config[$ "editing"		   ] ?? true;
			letter_index	   = 0;
			letter_width	   = string_width("A");
			
			// state
			state.fsm.add_child("__", "type", {
				enter: function() {
					__.state.fsm.inherit();
					__.letter_index = 0;
					__.input		= "";
				},
				step:  function() {
					__.state.fsm.inherit();
					
					if (__.letters_editing) {
						var _player = __get_player();
						if (_player.input_select_pressed()) {
							__.panel.audio_play(sfx_navigate);
							__letter_select();
						}
						if (_player.input_back_pressed()) {
							__.panel.audio_play(sfx_navigate);
							__letter_delete();
						}
						if (_player.input_right_pressed()) {
							__letter_next();
						}
						if (_player.input_left_pressed()) {
							__letter_previous();
						}
					}
				},
				draw:  function() {
					__.state.fsm.inherit();
				},
				leave: function() {
					__.state.fsm.inherit();
				},
			});
		};
	};

