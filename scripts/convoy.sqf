// =========================================================================================================
//  Convoy creator
//  Version: 1.6
//  Author: DTM2801
//  
// Credits & thanks: TRexian for providing random cargo part
// =========================================================================================================
//
// Description:
// This script wil create a convoy (configurable) and will keep monitoring all convoy vehicles for the correct distance by adjusting speed. 
// If the distance between convoy vehicles gets too far the forward vehicle will slowdown and eventually wait until the follower gets back 
// in acceptable distance.
//
// Usage:
// - Define a route for the convoy by placing and naming markers on the map.
// - Place a Game Logic on the map at the location and direction where you want the convoy be spawned.
// - Put the initstring in the initialisation field of the Game Logic.
//
// NOTE: ** Functions module must be placed on the map **
//
// Explanation of initstring:
//   null= [1:objectname,2:side,[3:"nameofmarker1","nameofmarker2","nameofmarker3"],4:cycle,5:convoysize,6:delay,[7:"classname1","classname2","classname3"],[8:namevehicle1, namevehicle2, namevehicle3],9:wpmarkers,10:debug]execvm "convoy.sqf";
//
//  1 : _position	: objectname spawnpoint of convoy vehicles (default: this)
//  2: _side		: side of convoy vehicles (WEST, EAST, RESISTANCE,CIVILIAN)
//  3: _wparray	: array of markernames used to create waypoints (have to be between "")
//  4: _wpcycle	: turn on/off cycle waypoint (true/false)
//  5: _convoysize	: number of default spawned vehicles (default: 5)
//  6: _delay		: time between vehicle spawns, needed to prevent pile ups (default: 7)
//  7: _vehiclearray	: array of vehicle classnames by choice, will be spawned it the order left to right (default: [])
//  8: _customarray	: array of vehiclenames on the map (default: [])
//  9: _wpmarkers	: turn on/off display of waypoint markers on map (true/false)
// 10: _debug		: turn on/off debug messages (true/false)
//
// example default vehicles:		null= [this,WEST,["convoywp1","convoywp2","convoywp3"],false,5,7,[],[],true,false]execvm "convoy.sqf";
// example vehicle array: 		null= [this,WEST,["convoywp1","convoywp2","convoywp3"],false,0,7,["HMMWV_M2","MTVR","HMMWV_M2"],[],true,false]execvm "convoy.sqf";
// example preplaced vehicle array:	null= [this,WEST,["convoywp1","convoywp2","convoywp3"],false,0,7,[],[veh1, veh2, veh3],true,false]execvm "convoy.sqf";
// =========================================================================================================

waitUntil {!isnil "bis_fnc_init" };
if (isServer) then {
	private ["_position", "_side", "_wparray", "_convoysize", "_delay", "_vehiclearray", "_customarray", "_wpmarkers", "_debug", "_wpcycle","_wpcount", "_vehiclecount", "_customcount", "_vehspawn", "_convoytype", "_convoycenter", "_convoygrp", "_vehicle", "_i", "_selectwp", "_wp", "_wpmarker", "_convoyarray", "_spawn", "_spawned", "_convoycount", "_convoy1", "_convoy2", "_cselect1", "_cselect2", "_customgrp", "_custom"];
	_position = _this select 0; 	if (isNil ("_position")) exitWith {hint "CONVOY: \nPosition not defined."};
	_side = _this select 1; 		if (isNil ("_side")) exitWith {hint "CONVOY: \nSide not defined."};
	_wparray = _this select 2; 		if (isNil ("_wparray")) exitWith {hint "CONVOY: \nWaypoints not defined."};
	_wpcycle = _this select 3; 		if (isNil ("_wpcycle")) exitWith {hint "CONVOY: \nCycle waypoint not defined."};
	_convoysize = _this select 4; 	if (isNil ("_convoysize")) exitWith {hint "CONVOY: \nConvoysize not defined."};
	_delay = _this select 5; 		if (isNil ("_delay")) exitWith {hint "CONVOY: \nDelay not defined."};
	_vehiclearray = _this select 6; if (isNil ("_vehiclearray")) exitWith {hint "CONVOY: \nVehicles not defined."};
	_customarray = _this select 7; 	if (isNil ("_customarray")) exitWith {hint "CONVOY: \nVehicles not defined."};
	_wpmarkers = _this select 8; 	if (isNil ("_wpmarkers")) exitWith {hint "CONVOY: \nMarkers true/false not defined."};
	_debug = _this select 9; 		if (isNil ("_debug")) exitWith {hint "CONVOY: \nDebug true/false not defined."};
	
	_wpcount = (count _wparray);
	_vehiclecount = (count _vehiclearray);
	_customcount = (count _customarray);
	if (_vehiclecount >0 && _customcount >0) exitWith {hint "CONVOY: \nCannot use both vehicle arrays."};
	_vehspawn = 0;

	_convoytype = 0;
		if (_vehiclecount > 0) then {_convoytype = 1};
		if (_customcount > 0) then {_convoytype = 2};
			
	switch (_convoytype) do {
		case 0:
		{
		_convoycenter = createCenter _side;
		_convoygrp = createGroup _side;

		_vehicle = objNull;
		if (_side == WEST) then {_vehicle = "MTVR"};
		if (_side == EAST) then {_vehicle = "Kamaz"};
		if (_side == RESISTANCE) then {_vehicle = "V3S_Gue"};
		if (_side == CIVILIAN) then {_vehicle = "UralCivil2"};

			for "_i" from 0 to (_wpcount -1) do {
			_selectwp = (_wparray select _i);
			_wp = _convoygrp addWaypoint [(getmarkerpos _selectwp), 0];
			[_convoygrp,_i] setWaypointType "MOVE";
			[_convoygrp,_i] setWaypointCompletionRadius 30;
			[_convoygrp,_i] setwaypointCombatMode "BLUE";
			[_convoygrp,_i] setWaypointFormation "FILE";
			[_convoygrp,_i] setWaypointBehaviour "SAFE";
	
				if (_wpmarkers) then {
				_wpmarker_name = (_wparray select _i);
				_wpmarker = createMarker[_wpmarker_name,(getmarkerpos _selectwp)];
				_wpmarker setMarkerShape "ICON";
				_wpmarker_name setMarkerType "DOT";
				};
			};
		if (_wpcycle) then {
		_wp = _convoygrp addWaypoint [(getmarkerpos (_wparray select 0)), 0];
		_wp setWaypointType "CYCLE";
		};
		_convoyarray = [];
			
			while {_vehspawn < (_convoysize)} do {
			_spawn = [(getpos _position), (getdir _position), _vehicle, _convoygrp] call BIS_fnc_spawnVehicle;
			_spawned = (_spawn select 0);
			_spawned setVehicleVarname format ["Convoy_%1",(_vehspawn + 1)];
			_spawned addEventHandler ["dammaged", {if (_debug) then {hint format ["%1 has been damaged",_this select 0];}}];
			_spawned addEventHandler ["killed", {if (_debug) then {hint format ["%1 has been destroyed!",_this select 0];}}];	
			_convoyarray = _convoyarray + [_spawn];
			_convoycount = count _convoyarray;
			_vehspawn = _vehspawn + 1;
			
			_cargoNum = _spawned emptyPositions "cargo";
				if (_cargoNum > 0) then {
				_fillSlots = round (random _cargoNum);
				_pos = getpos _position;
				_locGr =  _pos findEmptyPosition [10, 100];
				sleep .2;
					if (_locGr select 0 > 0)then {
					_cargo = [_locGr, _side , _cargoNum,[],[],[],[],[_fillSlots,.5], _dir] call BIS_fnc_spawnGroup;
					sleep .2;
					{_x moveInCargo _spawned;} forEach units _cargo;
					};
				};
						
				if (_convoycount > 1) then {
				_convoy1 = (_convoyarray select _convoycount -1);
				_convoy2 = (_convoyarray select _convoycount -2);
				_cselect1 = _convoy1 select 0;
				_cselect2 = _convoy2 select 0;
				_spawn call { [_cselect1,_cselect2,_debug] execVM "convoy_control.sqf"; } ;
				};
			sleep _delay;		
			};
		};
		
		case 1:
		{
		_convoycenter = createCenter _side;
		_convoygrp = createGroup _side;
		
			for "_i" from 0 to (_wpcount -1) do {
			_selectwp = (_wparray select _i);
			_wp = _convoygrp addWaypoint [(getmarkerpos _selectwp), 0];
			[_convoygrp,_i] setWaypointType "MOVE";
			[_convoygrp,_i] setWaypointCompletionRadius 30;
			[_convoygrp,_i] setwaypointCombatMode "BLUE";
			[_convoygrp,_i] setWaypointFormation "FILE";
			[_convoygrp,_i] setWaypointBehaviour "SAFE";
	
				if (_wpmarkers) then {
				_wpmarker_name = (_wparray select _i);
				_wpmarker = createMarker[_wpmarker_name,(getmarkerpos _selectwp)];
				_wpmarker setMarkerShape "ICON";
				_wpmarker_name setMarkerType "DOT";
				};
			};
			if (_wpcycle) then {
			_wp = _convoygrp addWaypoint [(getmarkerpos (_wparray select 0)), 0];
			_wp setWaypointType "CYCLE";
			};	
		_convoyarray = [];
			
			for "_i" from 0 to (_vehiclecount -1) do {
			_spawn = [(getpos _position), (getdir _position),(_vehiclearray select _i), _convoygrp] call BIS_fnc_spawnVehicle;
			_spawned = (_spawn select 0);
			_spawned setVehicleVarname format ["Convoy%1",(_vehspawn + 1)];
			_spawned addEventHandler ["dammaged", {if (_debug) then {hint format ["%1 has been damaged",_this select 0];}}];
			_spawned addEventHandler ["killed", {if (_debug) then {hint format ["%1 has been destroyed!",_this select 0];}}];
			_convoyarray = _convoyarray + [_spawn];
			_convoycount = count _convoyarray;
			_vehspawn = _vehspawn + 1;
			
			_cargoNum = _spawned emptyPositions "cargo";
				if (_cargoNum > 0) then {
				_fillSlots = round (random _cargoNum);
				_pos = getpos _position;
				_locGr =  _pos findEmptyPosition [10, 100];
				sleep .2;
					if (_locGr select 0 > 0)then {
					_cargo = [_locGr, _side , _cargoNum,[],[],[],[],[_fillSlots,.5], _dir] call BIS_fnc_spawnGroup;
					sleep .2;
					{_x moveInCargo _spawned;} forEach units _cargo;
					};
				};
			
				if (_convoycount > 1) then {
				_convoy1 = (_convoyarray select _convoycount -1);
				_convoy2 = (_convoyarray select _convoycount -2);
				_cselect1 = _convoy1 select 0;
				_cselect2 = _convoy2 select 0;
				_spawn call { [_cselect1,_cselect2,_debug] execVM "convoy_control.sqf"; } ;
				};
			sleep _delay;		
			};
		};
		
		case 2:
		{
		_convoygrp = group (_customarray select 0);
			for "_i" from 0 to (_wpcount -1) do {
			_selectwp = (_wparray select _i);
			_wp = _convoygrp addWaypoint [(getmarkerpos _selectwp), 0];
			[_convoygrp,_i] setWaypointType "MOVE";
			[_convoygrp,_i] setWaypointCompletionRadius 30;
			[_convoygrp,_i] setwaypointCombatMode "BLUE";
			[_convoygrp,_i] setWaypointFormation "FILE";
			[_convoygrp,_i] setWaypointBehaviour "SAFE";
	
				if (_wpmarkers) then {
				_wpmarker_name = (_wparray select _i);
				_wpmarker_name setMarkerType "DOT";
				_wpmarker = createMarker[_wpmarker_name,(getmarkerpos _selectwp)];
				_wpmarker setMarkerShape "ICON";
				};
			};
			if (_wpcycle) then {
			_wp = _convoygrp addWaypoint [(getmarkerpos (_wparray select 0)), 0];
			_wp setWaypointType "CYCLE";
			};	
		_convoyarray = [];
			
			for "_i" from 0 to (_customcount -1) do {
			_custom = (_customarray select _i);
			_custom addEventHandler ["dammaged", {if (_debug) then {hint format ["%1 has been damaged",_this select 0];}}];
			_custom addEventHandler ["killed", {if (_debug) then {hint format ["%1 has been destroyed!",_this select 0];}}];
			_convoyarray = _convoyarray + [_custom];
			_convoycount = count _convoyarray;

				if (_convoycount > 1) then {
				_convoy1 = (_convoyarray select _convoycount -1);
				_convoy2 = (_convoyarray select _convoycount -2);
				_cselect1 = _convoy1;
				_cselect2 = _convoy2;
				_custom call { [_cselect1,_cselect2,_debug] execVM "convoy_control.sqf"; } ;
				};
			sleep _delay;
			};		
		};
	};

};