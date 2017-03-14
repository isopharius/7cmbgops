if(!isServer) exitWith {};

_mrkSpawnTown = [_this, 0, ""] call BIS_fnc_param;
_choose = [_this, 1, ""] call BIS_fnc_param;

if (isnil "_mrkSpawnTown") then {
	if ((count mrkSpawnTown) == 0) exitwith {};
	_mrkSpawnTown = getMarkerPos (mrkSpawnTown call BIS_fnc_selectRandom);
};

if (_choose == "rand") then {
	_choose = ["clear","kill","ammo","ammo2","comms","clear2","antiair","capture","nuke"] call BIS_fnc_selectRandom;
};

[_mrkSpawnTown,_choose] spawn seven_fnc_makeClearOps;