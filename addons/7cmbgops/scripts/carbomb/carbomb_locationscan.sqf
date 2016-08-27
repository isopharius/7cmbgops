/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Location Scan Script
*******************************************************************************************************/
private ["_list","_location","_maxplayerdis","_removelist","_locationlist","_spawnlocal","_discheck"];
_list = _this select 0;
_selectedlocal = 0;
_nearroad = [];
_location = 0;
_discheck = 0;
_maxplayerdis = karma_cb_maxplayerdis;
_removelist = _list;
_playerlist = switchableUnits + playableUnits;
while {count _nearroad isEqualTo 0} do {
	{
	_location = _x;
	{
		_locationposition = locationPosition _location;
		_discheck = _x distance _locationposition;
		if (_discheck > _maxplayerdis) then {
			_removelist = _removelist - [_location];
		};
	} forEach _playerlist;
	} forEach _list;
	_locationlist = _list - _removelist;
	_spawnlocal = _locationlist call BIS_fnc_selectRandom;
	_position = locationPosition _spawnlocal;
	_nearroad = _position nearRoads 500;
};
_roadpos = getPos (_nearroad call BIS_fnc_selectRandom);
_roadpos