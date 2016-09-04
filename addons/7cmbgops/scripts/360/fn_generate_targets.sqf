private "_i";

private _arguments = _this select 3;
private _targetClass     = _arguments select 0;
private _targetQuantity  = _arguments select 1;
private _targetRandomDir = _arguments select 2;
private _targetRangeMin  = _arguments select 3;
private _targetRangeMax  = _arguments select 4;

{_x removeAllEventHandlers "HitPart"; deleteVehicle _x} forEach TrainingCourse_TargetList;
{deleteVehicle _x} forEach allUnits;
{deleteVehicle _x} forEach allDead;

TrainingCourse_TargetList = [];

Projectile_Impact_Aux setposworld [0, 0, 0];

for [{_i = 0}, {_i < _targetQuantity}, {_i = _i + 1}] do
{

	private _range = _targetRangeMin + (_targetRangeMax - _targetRangeMin) * sqrt(random 1);
	private _angle = random 360;

	private _position = getPosATL player;
	_position set [0, (_position select 0) + sin(_angle) * _range];
	_position set [1, (_position select 1) + cos(_angle) * _range];

	private _target = createVehicle [_targetClass, [0, 0, 0], [], 0, "can_collide"];
	_target setPosATL [_position select 0, _position select 1, 0.0];

	if (_targetRandomDir) then
	{
		private _direction = random 360;
	} else
	{
		private _vecToTarget = (getPosworld player) vectorFromTo (getPosworld _target);
		private _direction = (_vecToTarget select 0) atan2 (_vecToTarget select 1);
	};

	_target setDir _direction;

	_target addEventHandler ["HitPart", {(_this select 0) call seven_fnc_on_hit}];

	TrainingCourse_TargetList pushBack _target;
};
