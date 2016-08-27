private ["_distance", "_lower", "_upper", "_mid", "_intersections"];
params ["_source", "_destination", "_accuracy", "_result"];

_result = _destination;

private _distance = _source vectorDistance _destination;

if (count (lineIntersectsWith [_source, _destination]) > 0) then {
	_lower = 0;
	_upper = 1;
	_mid = 0.5;

	private _dir = _source vectorFromTo _destination;

	while {(_upper - _lower) * _distance > _accuracy} do {
		_mid = _lower + (_upper - _lower) / 2;

		_intersections = count (lineIntersectsWith [_source, _source vectorAdd (_dir vectorMultiply (_mid * _distance))]);

		if (_intersections > 0) then {
			_upper = _mid;
		} else {
			_lower = _mid;
		};
	};

	_mid = _lower + (_upper - _lower) / 2;
	_result = _source vectorAdd (_dir vectorMultiply (_mid * _distance));
};

_result