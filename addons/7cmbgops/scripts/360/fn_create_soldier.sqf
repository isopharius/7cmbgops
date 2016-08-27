private _arguments = _this select 3;
private _targetClass      = _arguments select 0;
private _targetAnimated   = _arguments select 1;
private _targetRandomDir  = _arguments select 2;
private _targetPatrolling = _arguments select 3;

private "_direction";
private _position = screenToWorld [0.5, 0.5];

if (_targetRandomDir) then
{
	_direction = random 360;
} else
{
	private _vecToTarget = (getPosATL player) vectorFromTo _position;
	_direction = (_vecToTarget select 0) atan2 (_vecToTarget select 1);
	_direction = _direction + 90;
};

private _group = createGroup east;
_targetClass createUnit [[_position select 0, _position select 1, 0.0], _group];

if (_targetPatrolling) then
{
	_group addWaypoint [[(_position select 0) + sin(_direction) * 20, (_position select 1) + cos(_direction) * 20, 0.0], 0];
	[_group, 1] setWaypointType "MOVE";
	_group addWaypoint [[(_position select 0) - sin(_direction) * 20, (_position select 1) - cos(_direction) * 20, 0.0], 0];
	[_group, 2] setWaypointType "MOVE";
	_group addWaypoint [[(_position select 0) + sin(_direction) * 20, (_position select 1) + cos(_direction) * 20, 0.0], 0];
	[_group, 3] setWaypointType "CYCLE";

	{[_group, _x] setWaypointSpeed "LIMITED";} forEach [1, 2, 3];
};
