function inst_create(_x,_y,_obj,_config={}) {
	return instance_create_depth(_x,_y,0,_obj,_config);
}

function asset_get_name(_name){
	repeat 2 {
		_name = string_replace(_name,"'", "");
		_name = string_replace(_name," ", "_");
	}
	return _name;
}

function print(_string) {
	if (DEBUG) {
		show_debug_message(_string);
	}
}

function pow(_x,_n) {
	return power(_x,_n);	
}

function draw_shadow_ellipse(_width, _height, _x, _y, _z = 0, _color = c_black, _alpha = 1) {
	
	static __max_z = 50;
	static __alpha = 0.6;
	
	if (_alpha <= 0) exit;
	
	draw_set_alpha(__alpha * _alpha);
	
		var _scale = 1 + (_z / __max_z);
			_scale = clamp(_scale, 0, 1);
		
		var _w  = _width  * _scale;
		var _h	= _height * _scale;
		var _x1	= _x - (_w  * 0.5);
		var _y1	= _y - (_h  * 0.5);
		var _x2	= _x + (_w  * 0.5);
		var _y2	= _y + (_h  * 0.5);
		draw_ellipse_color(_x1, _y1, _x2, _y2, _color, _color, false);
	draw_set_alpha(1.0);
}
