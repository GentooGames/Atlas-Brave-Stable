
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   __     __   __   __    //
	// /\  ___\ /\  == \/\  __ \ /\ \  _ \ \ /\ "-.\ \   //
	// \ \___  \\ \  _-/\ \  __ \\ \ \/ ".\ \\ \ \-.  \  //
	//  \/\_____\\ \_\   \ \_\ \_\\ \__/".~\_\\ \_\\"\_\ //
	//   \/_____/ \/_/    \/_/\/_/ \/_/   \/_/ \/_/ \/_/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_spawn.create //
	event_inherited();
	var _self = self;
	
	// public 
	state_get	= function() {
		return __.state.fsm.get_current_state();	
	};
	spawn_hero	= function(_hero_uid, _player, _spawn_point = undefined) {
		if (_player != undefined
		&&	 instance_exists(_player)
		&&	_player.is_active()
		) {
			_spawn_point ??= __.find_hero_spawn();
			_spawn_point.spawn_hero(_hero_uid, _player);
		}
		return self;
	};
	spawn_enemy = function(_enemy_uid, _spawn_point = undefined) {
		_spawn_point ??= __.find_enemy_spawn();
		_spawn_point.spawn_enemy(_enemy_uid);
		return self;
	};
	
	// private
	with (__) {
		// state machine
		state = {};
		with (state) {
			fsm	= new SnowState("idle", false, { 
				owner: _self,
			});
			fsm.history_enable();
			fsm.history_set_max_size(1);
			
			fsm.add("idle",			 {
				enter: function()	 {},
				step:  function()	 {},
				leave: function()	 {},
			});						
			fsm.add("room_enter",	 {
				enter: function() {
					__.spawn_points_wipe();
					__.spawn_points_store();
					__.spawn_points_initialize();
				},
				step:  function() {
					__.state.fsm.change("spawn_heroes");
				},
				leave: function() {},
			});
			fsm.add("spawn_heroes",  {
				enter: function() {
					__.spawn_heroes_initial();
				},
				step:  function() {
					__.state.fsm.change("spawn_enemies");
				},
				leave: function() {},
			});
			fsm.add("spawn_enemies", {
				enter: function() {
					__.spawn_enemies_initial();
				},
				step:  function() {
					__.state.fsm.change("idle");
				},
				leave: function() {},
			});
		};
		////////////////
		
		create_enemy			= method(_self, function(_type, _x, _y, _config = {}) {
			
			// enforced params
			_config[$ "team"] ??= TEAM.ENEMY();
		
			var _char = __.enemy_factory.create(_type, _x, _y, _config);
			__.character   = _char;
			__.character.initialize();
			
			return _char;
		});
		spawn_points_wipe		= method(_self, function() {
			__.spawn_points		  = [];
			__.spawn_points_hero  = [];
			__.spawn_points_enemy = [];
			__.spawn_points_boss  = [];
		});
		spawn_points_store		= method(_self, function() {
			if (instance_exists(obj_spawn_point)) {
				with (obj_spawn_point) {
					if (type_is_hero ()) array_push(other.__.spawn_points_hero,  self);
					if (type_is_enemy()) array_push(other.__.spawn_points_enemy, self);	
					if (type_is_boss ()) array_push(other.__.spawn_points_boss,  self);
					array_push(other.__.spawn_points, self);
				};
			}
		});
		spawn_points_initialize = method(_self, function() {
			iceberg.array.for_each(__.spawn_points, function(_spawn) {
				_spawn.initialize();
			});
		});
		spawn_heroes_initial	= method(_self, function() {
			// invoke spawn_hero() for each active player
			objc_game.player_for_each(function(_player) {
				var _hero_uid = _player.character_get_selected();
				spawn_hero(_hero_uid, _player);
			});
		});
		spawn_enemies_initial	= method(_self, function() {
			var _spawn  = __.find_enemy_spawn();
			if (_spawn != undefined) {
				_spawn.spawn_enemy("Viper");
			}
		});
		find_any_spawn			= method(_self, function() {
			return iceberg.array.get_random(__.spawn_points);
		});
		find_hero_spawn			= method(_self, function() {
			return iceberg.array.get_random(__.spawn_points_hero);
		});
		find_enemy_spawn		= method(_self, function() {
			return iceberg.array.get_random(__.spawn_points_enemy);
		});
		find_boss_spawn			= method(_self, function() {
			return iceberg.array.get_random(__.spawn_points_boss);
		});
		
		spawn_points			= [];	
		spawn_points_hero		= [];
		spawn_points_enemy		= [];
		spawn_points_boss		= [];
		
		enemy_factory			= new EnemyFactory();
		boss_factory			= new BossFactory();
	};
	
	// events
	on_initialize(function() {
		__.enemy_factory.initialize();
		__.boss_factory.initialize();
		__.state.fsm.change("idle");
	});
	on_update	 (function() {
		__.state.fsm.step();
	});
	on_room_start(function() {
		if (room == rm_test) {
			__.state.fsm.change("room_enter");
		}
	});
	
	