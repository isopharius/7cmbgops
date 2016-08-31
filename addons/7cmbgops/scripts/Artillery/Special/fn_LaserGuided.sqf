private ["_unit","_shell","_maxHeight","_shellAltitude","_firedClear","_shellPos","_ascending","_distance","_guide","_list","_target","_speed"];
disableSerialization;

params ["_inputArray", "_pos"];
_shell = _inputArray select 6;

_maxHeight = -1;
_shellAltitude = 0;
// Is the shell clear of the gun and descending?
_firedClear = false;
_shellPos = [];
_ascending = true;
while {_ascending} do {
	sleep 0.1;
	_shellPos = getPosATL _shell;
	_shellAltitude = _shellPos select 2;
	if (_shellAltitude < _maxHeight) then {_ascending = false};
	_maxHeight = _shellAltitude;
};

// Start guiding when the distance is less than 3000
_distance = 9999999;
_guide = false;
while {NOT(_guide)} do {
	sleep 0.3;
	_distance = _shell distance _pos;
	if (_distance < 1000) then {_guide = true};
};

if (dtaDebug) then {hint "LG shell guiding";systemChat "LG shell guiding"};
_list = _pos nearEntities ["LaserTarget",300];
if ((count _list) isEqualTo 0) exitWith {};
_target = _list select 0;
if (dtaDebug) then {systemChat format ["%1 %2",_list,_target]};
_speed = 150;
[_target,_shell,_speed,_pos,"LG"] spawn seven_fnc_GuideProjectile;