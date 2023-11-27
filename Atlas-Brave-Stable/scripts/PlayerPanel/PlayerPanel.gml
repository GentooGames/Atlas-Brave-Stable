
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   __   __   ______   __        //
	// /\  == \/\  __ \ /\ "-.\ \ /\  ___\ /\ \       //
	// \ \  _-/\ \  __ \\ \ \-.  \\ \  __\ \ \ \____  //
	//  \ \_\   \ \_\ \_\\ \_\\"\_\\ \_____\\ \_____\ //
	//   \/_/    \/_/\/_/ \/_/ \/_/ \/_____/ \/_____/ //
	//                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerPanel(_config = {}) : IB_Entity(_config) constructor {
				
		var _self = self;
		
		// public
		static get_index		= function() {
			return __.index;	
		};
		static get_cursor		= function() {
			return __.cursor;	
		};
		static get_player		= function() {
			return __.owner;	
		};
		static page_get_current = function() {
			return __.page;	
		};
		static page_get_name	= function() {
			return __.page_name;
		};
		static page_change		= function(_page_name) {
			
			// deactivate previous page
			if (__.page != undefined) {
				__.page.hide();
				__.page.deactivate();
			}
			
			// set new page
			__.page_name = _page_name;
			__.page		 = __.pages.get(_page_name);
			
			// activate new page
			__.page.activate();
			__.page.show();
			
			return self;
		};
		static page_is			= function(_page_name) {
			return __.page_name = _page_name;
		};
		static audio_play		= function(_audio_index, _mod_pitch = false) {
			
			static _pitch_min = 0.9;
			static _pitch_max = 1.1;
			
			if (_audio_index != undefined) {
				var _gain  = 1;
				var _pitch = (_mod_pitch) 
					? random_range(_pitch_min, _pitch_max)
					: 1;
				return audio_play_sound_on(__.audio_emitter, _audio_index, false, 0, _gain, 0, _pitch);
			}
			return undefined;
		};
		
		// private
		with (__) {
			static __new_page = function(_page_name, _page_class) {
				var _page = new _page_class({
					
					visible: false,
					name:   _page_name,
					color:   color_get(),
					x:		 position_get_x(),
					y:		 position_get_y(),
					width:   size_get_width(),
					height:  size_get_height(),
					
				}).initialize();
				
				__.pages.set(_page_name, _page);
				
				return _page;
			};
			
			index		  = _config[$ "index"] ?? undefined;
			page_name	  = "active";			// starting page
			page		  =  undefined;
			page_first	  = "profile_setup";	// first page after port becomes active
			pages		  =  new IB_Collection_Struct();
			audio_emitter =  audio_emitter_create();
			cursor		  =  new PlayerPanelCursor({
				active:	 false,
				visible: false,
				player:  owner,
				panel:  _self,
				color:	_self.color_get(),
			});
				
			state = {};
			with (state) {
				fsm = new SnowState("__", false, {
					owner: _self,
				});
				fsm.add("__", {
					enter: function() {},
					step:  function() {
						if (__.page   != undefined) {
							__.page.update();
						}
						if (__.cursor != undefined) {
							__.cursor.update();
						}
					},
					draw:  function() {
						if (__.page   != undefined) {
							__.page.render_gui();
						}
						if (__.cursor != undefined) {
							__.cursor.render_gui();
						}
					},
					leave: function() {},
				});
			};
		};
		
		// events
		on_initialize(function() {
			
			__.cursor.initialize();	
				
			__new_page("active",				  PlayerPanelPage_Active);
			__new_page("profile_setup",			  PlayerPanelPage_ProfileSetup);
			__new_page("profile_create",		  PlayerPanelPage_ProfileCreate);
			__new_page("profile_load",			  PlayerPanelPage_ProfileLoad);
			__new_page("character_select",		  PlayerPanelPage_CharacterSelect);
			__new_page("settings",				  PlayerPanelPage_Settings);
			__new_page("settings_profile",		  PlayerPanelPage_SettingsProfile);
			__new_page("settings_profile_rename", PlayerPanelPage_SettingsProfileRename);
			__new_page("settings_input",		  PlayerPanelPage_SettingsInput);
			__new_page("settings_input_devices",  PlayerPanelPage_SettingsInputDevices);
			
			// position audio emitter
			var _emitter_x = (SURF_W / 5.0) * (__.index + 1);
			var _emitter_y =  SURF_H * 0.5;
			audio_emitter_position(__.audio_emitter, _emitter_x, _emitter_y, 0);
			
			__.state.fsm.change("__");
			
		});
		on_update	 (function() {
			__.state.fsm.step();
		});
		on_render_gui(function() {
			__.state.fsm.draw();
		});
		on_cleanup   (function() {
			__.pages.for_each(function(_page) {
				_page.cleanup();
			});
			__.pages.cleanup();
			__.cursor.cleanup();
			audio_emitter_free(__.audio_emitter);
		});
	};
	
	
	