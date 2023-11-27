function EaseLinear(_time, _start, _end, _dur) {
	return _end * _time / _dur + _start;
}

function EaseInQuad(_time, _start, _end, _dur) {
	var _val = _time / _dur;
	return _end * _val * _val + _start;   
}

function EaseOutQuad(_time, _start, _end, _dur) {
	var _val = _time / _dur;
	return -_end * _val * (_val - 2) + _start;
}

function EaseInOutQuad(_time, _start, _end, _dur) {
	var _arg0 = 2*_time/_dur;

	if (_arg0 < 1){
	    return _end * 0.5 * _arg0 * _arg0 + _start;
	}
	return _end * -0.5 * ((_arg0-1) * (_arg0 - 3) - 1) + _start;
}

function EaseInCubic(_time, _start, _end, _dur) {
	return _end * power(_time/_dur, 3) + _start;
}

function EaseOutCubic(_time, _start, _end, _dur) {
	return _end * (power(_time/_dur - 1, 3) + 1) + _start;
}

function EaseInOutCubic(_time, _start, _end, _dur) {
	var _val = 2 * _time / _dur;

	if (_val < 1) { return _end * 0.5 * power(_val, 3) + _start; }

	return _end * 0.5 * (power(_val - 2, 3) + 2) + _start;
}

function EaseOutInCubic(_time, _start, _end, _dur ){
	if (_time < _dur / 2) {
		return EaseOutCubic( _time * 2, _start, _end / 2, _dur );
	} else {
		return EaseInCubic( ( _time * 2 ) - _dur, _start + _end / 2, _end / 2, _dur, );
	}
}

function EaseInQuart(_time, _start, _end, _dur) {
	return _end * power(_time / _dur, 4) + _start;
}

function EaseOutQuart(_time, _start, _end, _dur) {
	return -_end * (power(_time / _dur - 1, 4) - 1) + _start;
}

function EaseInOutQuart(_time, _start, _end, _dur) {
	var _val = 2 * _time / _dur;

	if (_val < 1) { return _end * 0.5 * power(_val, 4) + _start; }

	return _end * -0.5 * (power(_val - 2, 4) - 2) + _start;
}

function EaseInQuint(_time, _start, _end, _dur) {
	return _end * power(_time / _dur, 5) + _start;
}

function EaseOutQuint(_time, _start, _end, _dur) {
	return _end * (power(_time/_dur - 1, 5) + 1) + _start;
}

function EaseInOutQuint(_time, _start, _end, _dur) {
	var _val = 2 * _time / _dur;

	if (_val < 1) { return _end * 0.5 * power(_val, 5) + _start; }

	return _end * 0.5 * (power(_val - 2, 5) + 2) + _start;
}

function EaseInSine(_time, _start, _end, _dur) {
	return _end * (1 - cos(_time / _dur * (pi / 2))) + _start;
}

function EaseOutSine(_time, _start, _end, _dur) {
	return _end * sin(_time/_dur * (pi/2)) + _start;
}

function EaseInOutSine(_time, _start, _end, _dur) {
	return _end * 0.5 * (1 - cos(pi*_time/_dur)) + _start;
}

function EaseInCirc(_time, _start, _end, _dur) {
	var _val = _time/_dur;
	return _end * (1 - sqrt(1 - _val * _val)) + _start;
}

function EaseOutCirc(_time, _start, _end, _dur) {
	var _val = _time/_dur - 1;
	return _end * sqrt(abs(1 - _val * _val)) + _start;
}

function EaseInOutCirc(_time, _start, _end, _dur) {
	var _val = 2 * _time / _dur;

	if (_val < 1) { return _end * 0.5 * (1 - sqrt(abs(1 - _val * _val))) + _start; }

	_val -= 2;
	return _end * 0.5 * (sqrt(abs(1 - _val * _val)) + 1) + _start;
}

function EaseInExpo(_time, _start, _end, _dur) {
	return _end * power(2, 10 * (_time/_dur - 1)) + _start;
}

function EaseOutExpo(_time, _start, _end, _dur) {
	return _end * (-power(2, -10 * _time / _dur) + 1) + _start;
}

function EaseInOutExpo(_time, _start, _end, _dur) {
	var _val = 2 * _time / _dur;

	if (_val < 1) { return _end * 0.5 * power(2, 10 * --_val) + _start; }

	return _end * 0.5 * (-power(2, -10 * --_val) + 2) + _start;
}

function EaseInElastic(_time, _start, _end, _dur) {
	var _s = 1.70158;
	var _p = 0;
	var _a = _end;
	var _val = _time;

	if (_val == 0 || _a == 0) { return _start; }

	_val /= _dur;

	if (_val == 1) { return _start+_end; }

	if (_p == 0) { _p = _dur*0.3; }

	if (_a < abs(_end)) 
	{ 
	    _a = _end; 
	    _s = _p*0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (_end / _a);
	}

	return -(_a * power(2,10 * (--_val)) * sin((_val * _dur - _s) * (2 * pi) / _p)) + _start;
}

function EaseOutElastic(_time, _start, _end, _dur) {
	var _s = 1.70158;
	var _p = 0;
	var _a = _end;
	var _val = _time;

	if (_val == 0 || _a == 0){ return _start; }

	_val /= _dur;

	if (_val == 1){ return _start + _end; }

	if (_p == 0){ _p = _dur * 0.3; }

	if (_a < abs(_end)) 
	{ 
	    _a = _end;
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (_end / _a);
	}

	return _a * power(2, -10 * _val) * sin((_val * _dur - _s) * (2 * pi) / _p ) + _end + _start;			
}

function EaseInOutElastic(_time, _start, _end, _dur) {
	var _s = 1.70158;
	var _p = 0;
	var _a = _end;
	var _val = _time;

	if (_val == 0 || _a == 0) { return _start; }

	_val /= _dur*0.5;

	if (_val == 2) { return _start+_end; }

	if (_p == 0) { _p = _dur * (0.3 * 1.5); }

	if (_a < abs(_end)) 
	{ 
	    _a = _end;
	    _s = _p * 0.25;
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (_end / _a);
	}

	if (_val < 1) { return -0.5 * (_a * power(2, 10 * (--_val)) * sin((_val * _dur - _s) * (2 * pi) / _p)) + _start; }

	return _a * power(2, -10 * (--_val)) * sin((_val * _dur - _s) * (2 * pi) / _p) * 0.5 + _end + _start;
}

function EaseInBack(_time, _start, _end, _dur) {
	var _s = 1.70158;
	var _val = _time/_dur;
	return _end * _val * _val * ((_s + 1) * _val - _s) + _start;
}

function EaseOutBack(_time, _start, _end, _dur) {
	var _s = 1.70158;
	var _val = _time/_dur - 1;
	return _end * (_val * _val * ((_s + 1) * _val + _s) + 1) + _start;
}

function EaseInOutBack(_time, _start, _end, _dur) {
	var _s = 1.70158;
	var _val = _time/_dur*2;

	if (_val < 1)
	{
	    _s *= 1.525;
	    return _end * 0.5 * (((_s + 1) * _val - _s) * _val * _val) + _start;
	}

	_val -= 2;
	_s *= 1.525;

	return _end * 0.5 * (((_s + 1) * _val + _s) * _val * _val + 2) + _start;
}

function EaseInBounce(_time, _start, _end, _dur) {
	return _end - EaseOutBounce(_dur - _time, 0, _end, _dur) + _start;
}

function EaseOutBounce(_time, _start, _end, _dur) {
	var _val = _time/_dur;

	if (_val < 1/2.75)
	{
	    return _end * 7.5625 * _val * _val + _start;
	}
	else
	if (_val < 2/2.75)
	{
	    _val -= 1.5/2.75;
	    return _end * (7.5625 * _val * _val + 0.75) + _start;
	}
	else
	if (_val < 2.5/2.75)
	{
	    _val -= 2.25/2.75;
	    return _end * (7.5625 * _val * _val + 0.9375) + _start;
	}
	else
	{
	    _val -= 2.625/2.75;
	    return _end * (7.5625 * _val * _val + 0.984375) + _start;
	}
}

function EaseInOutBounce(_time, _start, _end, _dur) {

	if (_time < _dur*0.5)
	{
	    return (EaseInBounce(_time*2, 0, _end, _dur)*0.5 + _start);
	}

	return (EaseOutBounce(_time*2 - _dur, 0, _end, _dur)*0.5 + _end*0.5 + _start);
}