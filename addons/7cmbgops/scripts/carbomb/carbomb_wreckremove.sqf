/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Wreck Remove Script
******************************************************************************************************* */
private "_nearestPlayer";
params ["_wrecklist"];
//Carbomb Wrecks
{
	_nearestPlayer = [_x] call karma_cb_nearest_player;
	if (_nearestPlayer > 1000) then {
	karma_cb_wrecklist = karma_cb_wrecklist - [_x];
	deleteVehicle _x;
	};
} forEach _wrecklist;
//All Dead Units List
{
	_nearestPlayer = [_x] call karma_cb_nearest_player;
	if (_nearestPlayer > 1000) then {deleteVehicle _x};
} forEach allDead;
//karma_cb_wrecklist = [];