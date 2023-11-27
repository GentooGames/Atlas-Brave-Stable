
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __ ______   ______   ______  ______   ______    //
	// /\ \ / //\  ___\ /\  ___\ /\__  _\/\  __ \ /\  == \   //
	// \ \ \'/ \ \  __\ \ \ \____\/_/\ \/\ \ \/\ \\ \  __<   //
	//  \ \__|  \ \_____\\ \_____\  \ \_\ \ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_____/   \/_/  \/_____/ \/_/ /_/ //
	//                                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Vector() constructor {
	
		static ZERO		= { x:  0, y:  0 }  
		static ONE		= { x:  1, y:  1 } 
		static NEGATIVE = { x: -1, y: -1 } 
		static LEFT		= { x: -1, y:  0 }
		static RIGHT	= { x:  1, y:  0 }
		static UP		= { x:  0, y: -1 }
		static DOWN		= { x:  0, y:  1 }
		
		static create				 = function(_x = 0, _y = 0) {
			return new XD_Vector2(_x, _y);
		};
		static distance				 = function(_vector_1, _vector_2) {
			return point_distance(_vector_1.x, _vector_1.y, _vector_2.x, _vector_2.y);
		};
		static distance_squared		 = function(_vector_1, _vector_2) {
			var _dx = _vector_1.x - _vector_2.x;
			var _dy = _vector_1.y - _vector_2.y;
			return _dx * _dx + _dy * _dy;
		};
		static dot					 = function(_vector_1, _vector_2) {
			return dot_product(_vector_1.x, _vector_1.y, _vector_2.x, _vector_2.y);
		};
		static get_direction_limited = function(_vector_dir, _angle_limit, _sign = 1) {
		
			// get and normalize the direction angle of the vector
			var _direction_angle = _vector_dir % 360;
			if (_direction_angle < 0) _direction_angle += 360;

			// define restricted zones based on _angle_limit
			var _restricted_zone_1_start = 90 - _angle_limit;
			var _restricted_zone_1_end   = 90 + _angle_limit;

			var _restricted_zone_2_start = 270 - _angle_limit;
			var _restricted_zone_2_end   = 270 + _angle_limit;

			// check if _direction_angle falls in the restricted zones and adjust
			if (_direction_angle > _restricted_zone_1_start && _direction_angle <= _restricted_zone_1_end) {
			    if (_direction_angle == 90) {
			        _direction_angle = (_sign == 1) ? _restricted_zone_1_start : _restricted_zone_1_end;
			    } 
				else {
			        _direction_angle = (_direction_angle - _restricted_zone_1_start < _restricted_zone_1_end - _direction_angle)
						? _restricted_zone_1_start : _restricted_zone_1_end;
			    }
			} 
			else if (_direction_angle > _restricted_zone_2_start && _direction_angle <= _restricted_zone_2_end) {
			    if (_direction_angle == 270) {
			        _direction_angle = (_sign == 1) ? _restricted_zone_2_end : _restricted_zone_2_start;
			    } 
				else {
			        _direction_angle = (_direction_angle - _restricted_zone_2_start < _restricted_zone_2_end - _direction_angle)
						? _restricted_zone_2_start : _restricted_zone_2_end;
			    }
			}
	
			return _direction_angle;
		};
	};

