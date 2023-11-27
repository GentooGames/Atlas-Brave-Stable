
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   __   __   __ ______   __   __   ______  ______   ______   __  __    //
	// /\ \ /\ "-.\ \ /\ \ / //\  ___\ /\ "-.\ \ /\__  _\/\  __ \ /\  == \ /\ \_\ \   //
	// \ \ \\ \ \-.  \\ \ \'/ \ \  __\ \ \ \-.  \\/_/\ \/\ \ \/\ \\ \  __< \ \____ \  //
	//  \ \_\\ \_\\"\_\\ \__|  \ \_____\\ \_\\"\_\  \ \_\ \ \_____\\ \_\ \_\\/\_____\ //
	//   \/_/ \/_/ \/_/ \/_/    \/_____/ \/_/ \/_/   \/_/  \/_____/ \/_/ /_/ \/_____/ //
	//                                                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function Inventory(_config = {}) : IB_Base(_config) constructor {
		
		// public
		static item_add		= function(_item_uid) {
			if (has_space()) {
				array_push(__.items, _item_uid);
				return true;
			}
			return false;
		};
		static item_exists	= function(_item_uid) {
			return iceberg.array.contains(__.items, _item_uid);
		};
		static item_remove	= function(_index) {
			if (_index >= 0 && _index < __.size) {
				__.items = array_delete(__.items, _index, 1);	
			}
		};
		static item_get		= function(_index) {
			if (_index >= 0 &&_index < __.size) {
				return __.items[_index];
			}
			return undefined;
		};
			
		static capacity_get = function() {
			return __.capacity;
		};
		static capacity_set	= function(_capacity) {
			__.capacity = _capacity;
			return self;
		};
		static size_get		= function() {
			return __.size;
		};
		static has_space	= function() {
			return __.size < __.capacity;	
		};
		
		// private
		with (__) {
			
			items	 = [];
			size	 = 0;
			capacity = _config[$ "capacity"] ?? 20;
		};
	};
	
	
	