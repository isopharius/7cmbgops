if(!isServer) exitWith {};

_mrkSpawnPos = [_this, 0, ""] call BIS_fnc_param;
_choose = [_this, 1, ""] call BIS_fnc_param;

if (isnil "_mrkSpawnPos") then {
	if ((count mrkSpawnPos) == 0) exitwith {};
	_mrkSpawnPos = getMarkerPos (mrkSpawnPos call BIS_fnc_selectRandom);
};

if (_choose == "rand") then {
	_choose = ["ied","roadrepair","hqbuild","towrepair","vehrepair","rescue","uavrec","pilotrescue"] call BIS_fnc_selectRandom;
};

[_mrkSpawnPos,_choose] spawn seven_fnc_makeSupportOps;