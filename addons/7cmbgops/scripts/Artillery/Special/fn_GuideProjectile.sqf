// This is a modification of a script by kylania
// Original: http://www.kylania.com/ex/?p=21

params ["_primaryTarget", "_missile", "_missileSpeed", "_basicPos", "_shellType"];

if (dtaDebug) then {systemChat "Guiding"};

// Z adjustment. Use 2.5 for laser guided and 5 for guided
_zAdj = 3;
_zAdj = 0.1;
if (_shellType == "LG") then {_zAdj = 0.3};

_missileStart = getPosASL _missile; //position where the missile will be spawned
_defaultTargetPos = getPos _primaryTarget;

if (isNull _primarytarget) exitWith {hintSilent "No Target Found!"};

_perSecondChecks = 50; //direction checks per second
_getPrimaryTarget = {if (typeName _primaryTarget isEqualTo "CODE") then {call _primaryTarget} else {_primaryTarget}}; //code can be used for laser dots
_target = call _getPrimaryTarget;

//secondary target used for random trajectory when laser designator is turned off prematurily
_secondaryTarget = createVehicle ["HeliHEmpty", [0,0,0], [], 0, "CAN_COLLIDE"];
_secondaryTarget setPos _basicPos;

_guidedRandomly = FALSE;

_relDirHor = 0;
_steps = 0;
_travelTime = 0;
_relDirVer = 0;
_velocityX = 0;
_velocityY = 0;
_velocityZ = 0;

//procedure for guiding the missile
_homeMissile = {
	//here we switch to secondary target at random position if the laser dot no longer exists
	//if the designator is turned on again, the missile will return to it's original target (providing it hadn't flown too far)
	private ["_velocityX", "_velocityY", "_velocityZ", "_target"];
	_target = _secondaryTarget;

	if (!(_guidedRandomly) && {_missile distance _target > _missileSpeed * 1.5}) then {
		_guidedRandomly = TRUE;
		_target = _secondaryTarget;
		_dispersion = (_missile distance _defaultTargetPos) / 20;
		_dispersionMin = _dispersion / 10;
		_target setPos [(_defaultTargetPos select 0) + _dispersionMin - (_dispersion / 2) + random _dispersion, (_defaultTargetPos select 1) + _dispersionMin - (_dispersion / 2) + random _dispersion, 0];
	};

	if (!(isNull (call _getPrimaryTarget))) then {_target = call _getPrimaryTarget; _defaultTargetPos = getPos _target; _guidedRandomly = FALSE};


	//altering the direction, pitch and trajectory of the missile
	if (_missile distance _target > (_missileSpeed / 20)) then {
		_travelTime = (_target distance _missile) / _missileSpeed;
		_steps = floor (_travelTime * _perSecondChecks);

		_relDirHor = [_missile, _target] call BIS_fnc_DirTo;
		_missile setDir _relDirHor;

		_relDirVer = asin ((((getPosASL _missile) select 2) - (((getPosASL _target) select 2) + _zAdj)) / (_target distance _missile));
		_relDirVer = (_relDirVer * -1);
		[_missile, _relDirVer, 0] call BIS_fnc_setPitchBank;

		_velocityX = (((getPosASL _target) select 0) - ((getPosASL _missile) select 0)) / _travelTime;
		_velocityY = (((getPosASL _target) select 1) - ((getPosASL _missile) select 1)) / _travelTime;
		_velocityZ = (((getPosASL _target) select 2) - ((getPosASL _missile) select 2)) / _travelTime;
	};

	[_velocityX, _velocityY, _velocityZ]
};

call _homeMissile;

//missile flying
while {alive _missile} do {
	_velocityForCheck = call _homeMissile;
	if ({(typeName _x) isEqualTo "SCALAR"} count _velocityForCheck isEqualTo 3) then {_missile setVelocity _velocityForCheck};
	sleep (1 / _perSecondChecks)
};
deleteVehicle _secondaryTarget;