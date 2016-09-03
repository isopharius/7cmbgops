/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Target Scan Script
******************************************************************************************************* */
private ["_driver","_cbombtarget","_targetside",
		"_targetpos","_targetunit"];
params ["_cbomb"];
_driver = driver _cbomb;
_cbombtarget = _driver nearTargets 1500;
{
	_targetside = _x select 2;
	_targetpos = _x select 0;
	_targetunit = _x select 4;
	if (_targetside == WEST) then {
		_cbomb setVariable ["TargetState", 1, false];
		_cbomb setVariable ["Target", _targetunit, false];
		_cbomb setVariable ["TargetScan", 1, false];
		doStop _cbomb;
	};
} forEach _cbombtarget;
if (speed _cbomb isEqualTo 0) then {[_cbomb] call karma_cb_distance_check};