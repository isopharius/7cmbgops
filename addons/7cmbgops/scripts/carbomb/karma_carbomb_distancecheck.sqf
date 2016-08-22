/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Distance Chck Script
******************************************************************************************************* */
private ["_targetpos","_distance"];
_carbomb = _this select 0;
_targetpos = _carbomb getVariable "TargetPos";
_distance = (getPosATL _carbomb) distance _targetpos;
if ((_distance <= 20)) then {
	_carbomb setVariable ["TargetState", 0, false];
	_carbomb setVariable ["Target", 0, false];
	_carbomb setVariable ["TargetScan", 0, false];
	[_carbomb] call karma_cb_target_select;
};