/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Nearest Player Script
******************************************************************************************************* */
private ["_maxdis","_pdistance"];
params ["_object"];
private _playerlist = [];
_playerlist append playableUnits;
_playerlist append switchableUnits;
_maxdis = 5000;
{
	_pdistance = _x distance _object;
	if (_pdistance < _maxdis) then {_maxdis = _pdistance};
} forEach _playerlist;
_maxdis