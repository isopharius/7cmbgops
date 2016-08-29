private["_unit","_shell","_maxHeight","_shellAltitude","_firedClear","_shellPos","_ascending","_distance","_guide","_list","_target","_speed"];
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
	//systemChat format ["alt: %1 %2",_shellAltitude,_maxHeight];
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
	//systemChat format ["%1",_distance];
};

_range = 50;
//if (dtaDebug) then {hint "Shell guiding";systemChat "Shell guiding"};
//_list = _pos nearEntities ["LaserTarget",300];
_list = [];
_go = true;
while {_go} do {
	_list = _pos nearEntities [["Car","Tank"],_range];
	// If at least one target is present, stop searching
	if ((count _list) > 0) then {_go = false};
	_range = _range + 50;
	// Max range to search for is 300
	if (_range > 300) then {_go = false};
};

_target = objNull;
//systemChat format ["GUIDED: %1   T: %2",_list,_target];

if ((count _list) isEqualTo 0) exitWith {};
//_target = _list select 0;
_target = _list call BIS_fnc_selectRandom;
//systemChat format ["GUIDED: %1   T: %2",_list,_target];
if (dtaDebug) then {systemChat format ["%1 %2",_list,_target]};
_speed = 150;
//_speed = speed _shell;
[_target,_shell,_speed,_pos,"SG"] execVM "\7cmbgops\scripts\Artillery\Special\GuideProjectile.sqf";