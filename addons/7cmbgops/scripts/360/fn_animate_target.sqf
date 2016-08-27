params ["_target", "_direction", "_speed", "_distance"];
private ["_refPosition", "_velocity"];


private _refPosition = getPosATL _target;
private _velocity = [sin(_direction) * _speed / 100, cos(_direction) * _speed / 100, 0];

private _lastTime = diag_tickTime;

while {!(isNull _target)} do
{
	sleep 0.01;

	if ((vectorMagnitude (_refPosition vectorDiff (getPosATL _target))) > _distance) then
	{
		_refPosition = getPosATL _target;
		_velocity = [-(_velocity select 0), -(_velocity select 1), 0];
	};

	private _translation = _velocity vectorMultiply (1 / (diag_tickTime - _lastTime));
	private _lastTime = diag_tickTime;

	_target setPosATL (getPosATL _target vectorAdd _velocity);
};
