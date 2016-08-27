private _arguments = _this select 3;
private _targetClass     = _arguments select 0;
private _targetRandomDir = _arguments select 1;
private _targetAnimated  = _arguments select 2;

private ["_vecToTarget", "_direction"];

private _position = screenToWorld [0.5, 0.5];

// Table
private _target = createVehicle ["Land_WoodenTable_small_F", [0, 0, 0], [], 0, "can_collide"];
_target setPosATL [_position select 0, _position select 1, 0.0];

if (_targetRandomDir) then
{
	_direction = random 360;
} else
{
	_vecToTarget = (getPosworld player) vectorFromTo (getPosworld _target);
	_direction = (_vecToTarget select 0) atan2 (_vecToTarget select 1);
};

_target setDir _direction;

_target addEventHandler ["HitPart", {(_this select 0) call seven_fnc_on_hit}];

TrainingCourse_TargetList pushBack _target;

// Balloon
_target = createVehicle ["Land_Balloon_01_water_F", [0, 0, 0], [], 0, "can_collide"];
_target setPosATL [_position select 0, _position select 1, 0.9];

if (_targetRandomDir) then
{
	_direction = random 360;
} else
{
	_vecToTarget = (getPosworld player) vectorFromTo (getPosworld _target);
	_direction = (_vecToTarget select 0) atan2 (_vecToTarget select 1);
};

_target setDir _direction;

_target addEventHandler ["HitPart", {(_this select 0) call seven_fnc_on_hit}];

TrainingCourse_TargetList pushBack _target;

