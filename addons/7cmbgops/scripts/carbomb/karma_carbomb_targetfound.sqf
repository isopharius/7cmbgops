/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Target Found Script
******************************************************************************************************* */
private ["_targetunit","_trigdistance"];
_cbomb = _this select 0;
_targetunit = _this select 1;
karma_cb_carbomblist = karma_cb_carbomblist - [_cbomb];
_cbomb setVariable ["TargetState", 0, false];
_cbomb setVariable ["Target", 0, false];
_cbomb setVariable ["TargetScan", 0, false];
doStop _cbomb;
sleep (round (random 10));
//(group _cbomb) setBehaviour "AWARE";
_cbomb setSpeedMode "FULL";
_cbomb doMove getPosATL _targetunit;
_cbomb setSpeedMode "FULL";
//hint "moving";
_cbomb setSpeedMode "FULL";
_trigdistance = round random 40;
if (karma_cb_debug == 1) then {
hint format ["Karma Module Car Bomb Module: Target Found Trigger Distance = %1",_trigdistance];
};
waitUntil {((_cbomb distance _targetunit) < _trigdistance) || !alive (driver _cbomb)}; 
if (alive (driver _cbomb)) then {
	if (karma_cb_debug == 1) then {
		_marker = _cbomb getVariable "markername";
		deleteMarker _marker;
	};
	(driver _cbomb) removeAllEventHandlers "Killed";
	//hint "boom";
	_veh = createVehicle ["Bo_Mk82", getPosATL _cbomb, [], 0, "NONE"];
};