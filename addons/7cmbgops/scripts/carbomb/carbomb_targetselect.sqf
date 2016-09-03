/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Target Select Script
******************************************************************************************************* */
private ["_playerlist","_targetselect","_targetPos"];
params ["_car"];
_playerlist = switchableUnits + playableUnits;
_targetselect = selectRandom _playerlist;
_targetPos = getPosATL _targetselect;
_car setSpeedMode "NORMAL";
_car doMove _targetPos;
_car setSpeedMode "NORMAL";
_car setVariable ["TargetPos", _targetPos, false];
