/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Nearest Player Script
******************************************************************************************************* */
private ["_object","_playerlist","_objectpos","_maxdis","_pdistance"];
_object = _this select 0;
_playerlist = playableUnits + switchableUnits;
_objectpos = getPosATL _object;
_maxdis = 5000;
{
	_pdistance = (getPosATL _x) distance _objectpos;
	if (_pdistance < _maxdis) then {_maxdis = _pdistance};
} forEach _playerlist;
_maxdis