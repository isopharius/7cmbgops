/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Location Scan Script
*******************************************************************************************************/
private ["_location","_maxplayerdis","_removelist","_locationlist","_spawnlocal","_discheck"];
params ["_list"];
_selectedlocal = 0;
_nearroad = [];
_location = 0;
_discheck = 0;
_maxplayerdis = karma_cb_maxplayerdis;
_removelist = _list;
_playerlist = [];
_playerlist append switchableUnits;
_playerlist append playableUnits;

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
	_spawnlocal = selectRandom _locationlist;
	_position = locationPosition _spawnlocal;
	_nearroad = _position nearRoads 500;
};
_roadpos = getPos (selectRandom _nearroad);
_roadpos