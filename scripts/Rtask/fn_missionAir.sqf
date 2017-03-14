if(!isServer) exitWith {};

_mrkSpawnSite = [_this, 0, ""] call BIS_fnc_param;
_choose = [_this, 1, ""] call BIS_fnc_param;

if (isnil "_mrkSpawnSite") then {
	if ((count mrkSpawnSite) == 0) exitwith {};
	_mrkSpawnSite = getMarkerPos (mrkSpawnSite call BIS_fnc_selectRandom);
};

if (_choose == "rand") then {
	_choose = ["arty","cas","convoy","warehouse"] call BIS_fnc_selectRandom;
};

[_mrkSpawnSite,_choose] spawn seven_fnc_makeAirOps;