
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   __     __   __   __    //
	// /\  ___\ /\  == \/\  __ \ /\ \  _ \ \ /\ "-.\ \   //
	// \ \___  \\ \  _-/\ \  __ \\ \ \/ ".\ \\ \ \-.  \  //
	//  \/\_____\\ \_\   \ \_\ \_\\ \__/".~\_\\ \_\\"\_\ //
	//   \/_____/ \/_/    \/_/\/_/ \/_/   \/_/ \/_/ \/_/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_spawn_point.create //
	event_inherited();
	var _self = self;
	
	if (MEDIA_MODE) visible = false;
	
	/// variable definitions
	//
	//	types = [];
	//
	////////////////////////
	
	// public
	type_is_hero  = function() {
		return iceberg.array.contains(__.types, obj_hero);
	};
	type_is_enemy = function() {
		return iceberg.array.contains(__.types, obj_enemy);
	};
	type_is_boss  = function() {
		return iceberg.array.contains(__.types, obj_boss);
	};
	spawn_hero	  = function(_uid, _player) {
		var _hero = _player.character_create(_uid, x, y);
		BROADCAST("character_spawned", {
			instance: _hero,
			uid:	  _uid,
			player:   _player,
			spawn:	   self,
		});
		return _hero;
	};
	spawn_enemy	  = function(_uid) {
		var _enemy = objc_spawn.__.create_enemy(_uid, x, y);
		BROADCAST("character_spawned", {
			instance: _enemy,
			uid:	  _uid,
			player:    undefined,
			spawn:	   self,
		});
		return _enemy;
	};
	
	// private
	with (__) {
		types = _self[$ "types"] ?? [];
	};
	
	// events
	on_render(function() {
		draw_self();
	});
	
	
	