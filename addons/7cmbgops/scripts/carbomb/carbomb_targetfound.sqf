/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Target Found Script
******************************************************************************************************* */
private ["_trigdistance"];
params ["_cbomb", "_targetunit"];
karma_cb_carbomblist = karma_cb_carbomblist - [_cbomb];
_cbomb setVariable ["TargetState", 0, false];
_cbomb setVariable ["Target", 0, false];
_cbomb setVariable ["TargetScan", 0, false];
doStop _cbomb;
sleep (round (random 10));
//(group _cbomb) setBehaviour "AWARE";
_cbomb setSpeedMode "FULL";
_cbomb doMove getPosWorld _targetunit;
_cbomb setSpeedMode "FULL";
_trigdistance = round random 40;
waitUntil {((_cbomb distance _targetunit) < _trigdistance) || {!alive (driver _cbomb)}};
if (alive (driver _cbomb)) then {
	(driver _cbomb) removeAllEventHandlers "Killed";
	//hint "boom";
	_veh = createVehicle ["Bo_Mk82", getPosATL _cbomb, [], 0, "NONE"];
};