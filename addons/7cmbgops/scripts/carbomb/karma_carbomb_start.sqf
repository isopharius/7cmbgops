/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Start Script
******************************************************************************************************* */

if (isServer) then {
karma_cb_cbombprob = 5;
karma_cb_maxbombcount = 1;
karma_cb_civtrafcount = 8;
karma_cb_maxplayerdis = 2000;
switch tolower(worldname) do {
	case "pja306": { karma_cb_mapscansize = 10500 };
	case "chernarus";
	case "takistan": { karma_cb_mapscansize = 7750 };
	case "sara_dbe1";
	case "sara": { karma_cb_mapscansize = 5100 };
	case "stratis";
	case "zargabad": { karma_cb_mapscansize = 4500 };
	default { karma_cb_mapscansize = 2600 };
};
karma_cb_debug = 0;
karma_cb_carbomblist = [];
karma_cb_wrecklist = [];
karma_cb_civlist = [];

karma_cb_target_scan = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_targetscan.sqf";
karma_cb_target_found = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_targetfound.sqf";
karma_cb_driver_killed = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_driverkilled.sqf";
karma_cb_location_scan = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_locationscan.sqf";
karma_cb_target_select = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_targetselect.sqf";
karma_cb_distance_check = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_distancecheck.sqf";
karma_cb_wreck_remove = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_wreckremove.sqf";
karma_cb_nearest_player = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_nearestplayer.sqf";
karma_cb_carbomb_spawn = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_carbombspawn.sqf";
karma_cb_civtraffic_spawn = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_civtrafficspawn.sqf";
karma_cb_civtraffic_killed = compile preprocessFileLineNumbers "scripts\karma_carbomb_module\karma_carbomb_civkilled.sqf";

_probcbomb = 0;
_nearestCity = nearestLocations [getPosATL center, ["Name","NameLocal","NameVillage","NameCity","NameCityCapital","Airport","Strategic","StrongpointArea","ViewPoint","FlatArea","FlatAreaCity","FlatAreaCitySmall"], karma_cb_mapscansize];
karma_cb_civcenter = createCenter CIVILIAN;
karma_cb_bombcenter = createCenter EAST;
_k = 0;
_j = 0;
if (karma_cb_debug == 1) then {
	hintSilent format ["Karma Module Car Bomb Module:Number Of Locations %1",count _nearestCity];
};
sleep 5;
//hintSilent format ["Number Of Locations %1",20];
while {true} do {
	_playercount = count (playableUnits + switchableUnits);
	waitUntil {_playercount > 0};
//hintSilent "IS IT WORKING";
	_probcbomb = floor (random 100);
	if ((count karma_cb_carbomblist) <= karma_cb_maxbombcount && {_j == 5} && {_probcbomb <= karma_cb_cbombprob}) then {
	[_nearestCity] call karma_cb_carbomb_spawn;
	};
	//hintsilent format ["Carbomb LIst Count = %1",carbomblist];
	if ((count karma_cb_carbomblist) > 0) then {
	//waitUntil {(count carbomblist) > 0};
	{
		_targets = _x getVariable "Target";
		_targetstates = _x getVariable "TargetState";
		_targetscan = _x getVariable "TargetScan";
		_entityscan = _x getVariable "EntityScan";
		if (_targetscan == 0) then {[_x] call karma_cb_target_scan};
		_targets = _x getVariable "Target";
		if (_targetstates != 0) then {
		[_x, _targets] spawn karma_cb_target_found;
		};
		if (alive _x && {karma_cb_debug == 1} && {_j == 6}) then {
		_marker = _x getVariable "markername";
		_marker setMarkerPos getPos _x;
		};
		if (!canMove _x && _j == 10) then {
			_driver = _x getVariable "Driver";
			if (karma_cb_debug == 1) then {
				_marker = _x getVariable "markername";
				deleteMarker _marker;
			};
			karma_cb_carbomblist = karma_cb_carbomblist - [_x];
			karma_cb_wrecklist set [count karma_cb_wrecklist, _x];
			karma_cb_wrecklist set [count karma_cb_wrecklist, _driver];
			};
	} forEach karma_cb_carbomblist;
	};
	//if ((count carbomblist) >= karma_maxbombcount) then {sleep 2};
	if ((count karma_cb_civlist) <= karma_cb_civtrafcount && _j == 5) then {
	[_nearestCity] call karma_cb_civtraffic_spawn;
	};
	if ((count karma_cb_civlist) > 0 && _j == 10) then {
		{
		if (alive _x && {karma_cb_debug == 1}) then {
		_marker = _x getVariable "markername";
		_marker setMarkerPos getPos _x;
		};
		_j = -1;
		if (!canMove _x) then {
			_driver = _x getVariable "Driver";
			if (karma_cb_debug == 1) then {
				_marker = _x getVariable "markername";
				deleteMarker _marker;
			};
			karma_cb_civlist = karma_cb_civlist - [_x];
			karma_cb_wrecklist set [count karma_cb_wrecklist, _x];
			karma_cb_wrecklist set [count karma_cb_wrecklist, _driver];
		};
		} forEach karma_cb_civlist;
	};
	if (_k == 300) then {
		if (karma_cb_debug == 1) then {
			hintSilent format ["Karma Module Car Bomb Module: Wreck Count %1",(count karma_cb_wrecklist)];
		};
	[karma_cb_wrecklist] spawn karma_cb_wreck_remove;
	_k = -1;
	};
	_k = _k + 1;
	_j = _j + 1;
};
};