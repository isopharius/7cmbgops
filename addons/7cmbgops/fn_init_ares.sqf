if (isHC) exitwith {};

if (isserver) then { //server

	mish = profileNamespace getVariable [format["savemish_%1", worldname], []];

	publicVariable "mish";

	"mish" addPublicVariableEventHandler {
		profileNamespace setVariable [format["savemish_%1", worldname], mish];
	};

	if (isdedicated) then { //save server profile when all players gone
		["saveprofile", "onPlayerDisconnected", {
			if ( ({isPlayer _x} count playableUnits) == 0 ) then { saveprofileNamespace };
		}] call BIS_fnc_addStackedEventHandler;
	};

} else { //clients

	[ //Mish transfer
		"Save/Load",
		"Transfer to server",
		{
			_mish = profileNamespace getVariable [format["savemish_%1", worldname],[]];
			_mishlist = [];
			{
				_mishlist pushback (_x select 0);
			} foreach _mish;

			_dialogResult =
				[
					"Transfer from client to server",
					[
						["Choose file", _mishlist]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			mish pushback (_mish select (_dialogResult select 0));
			publicVariable "mish";

			_mishname = _mishlist select (_dialogResult select 0);
			[format["File %1 transferred to server.",_mishname]] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[ //Mish load
		"Save/Load",
		"Load from server",
		{
			_mishlist = [];
			{
				_mishlist pushback (_x select 0);
			} foreach mish;

			_dialogResult =
				[
					"Load from server",
					[
						["Choose file", _mishlist]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_loadmish = (mish select (_dialogResult select 0)) select 1;
			try
			{
				[(compile _loadmish), _this, false] call Ares_fnc_BroadcastCode;
			}
			catch
			{
				diag_log _exception;
				["Failed to parse code. See RPT for error."] call Ares_fnc_ShowZeusMessage;
			};

			_mishname = _mishlist select (_dialogResult select 0);
			[format["If you don't see any errors, file %1 is now loaded!",_mishname]] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[ //Mish delete server
		"Save/Load",
		"Delete from server",
		{
			_mishlist = [];
			{
				_mishlist pushback (_x select 0);
			} foreach mish;

			_dialogResult =
				[
					"Delete from server",
					[
						["Choose file", _mishlist]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			mish deleteAt (_dialogResult select 0);
			publicVariable "mish";

			_mishname = _mishlist select (_dialogResult select 0);
			[format["File %1 deleted from server!",_mishname]] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;
};

if (!isdedicated) then { //players
	[ //Mish save
		"Save/Load",
		"Save to client",
		{
			_radius = 100;
			_position = _this select 0;

			_dialogResult =
				[
					"Save to client",
					[
						["Mission Name", ""],
						["Radius", ["50m", "100m", "500m", "1km", "2km", "5km", "Entire Map"], 6],
						["Include AI?", ["Yes", "No"]],
						["Include Empty Vehicles?", ["Yes", "No"]],
						["Include Objects?", ["Yes", "No"]],
						["Include Markers?", ["Yes", "No"], 1]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			["User chose radius with index '%1'", _dialogResult] call Ares_fnc_LogMessage;
			_radius = 100;
			switch (_dialogResult select 1) do
			{
				case 0: { _radius = 50; };
				case 1: { _radius = 100; };
				case 2: { _radius = 500; };
				case 3: { _radius = 1000; };
				case 4: { _radius = 2000; };
				case 5: { _radius = 5000; };
				case 6: { _radius = -1; };
				default { _radius = 100; };
			};
			_includeUnits = if (_dialogResult select 2 == 0) then { true; } else { false; };
			_includeEmptyVehicles = if (_dialogResult select 3 == 0) then { true; } else { false; };
			_includeEmptyObjects = if (_dialogResult select 4 == 0) then { true; } else { false; };
			_includeMarkers = if (_dialogResult select 5 == 0) then { true; } else { false; };

			_objectsToFilter = curatorEditableObjects (allCurators select 0);
			_emptyObjects = [];
			_emptyVehicles = [];
			_groups = [];
			{
				_ignoreFlag = false;
				if ((typeOf _x) in Ares_EditableObjectBlacklist || _x == player || isPlayer _x) then
				{
					_ignoreFlag = true;
				};

				if (!_ignoreFlag && ((_x distance _position <= _radius) || _radius == -1)) then
				{
					["Processing object: %1 - %2", _x, typeof(_x)] call Ares_fnc_LogMessage;
					_ignoreFlag = true;
					_isUnit = (_x isKindOf "CAManBase")
						|| (_x isKindOf "car")
						|| (_x isKindOf "tank")
						|| (_x isKindOf "air")
						|| (_x isKindOf "StaticWeapon")
						|| (_x isKindOf "ship");
					if (_isUnit) then
					{
						if (_x isKindOf "CAManBase") then
						{
							["Is a man."] call Ares_fnc_LogMessage;
							if ((group _x) in _groups) then
							{
								["In an old group."] call Ares_fnc_LogMessage;
							}
							else
							{
								["In a new group."] call Ares_fnc_LogMessage;
								_groups pushBack (group _x);
							};

						}
						else
						{
							if (count crew _x > 0) then
							{
								["Is a vehicle with units."] call Ares_fnc_LogMessage;
								if ((group _x) in _groups) then
								{
									["In an old group."] call Ares_fnc_LogMessage;
								}
								else
								{
									["In a new group."] call Ares_fnc_LogMessage;
									_groups pushBack (group _x);
								};
							}
							else
							{
								["Is an empty vehicle."] call Ares_fnc_LogMessage;
								_emptyVehicles pushBack _x;
							};
						};
					}
					else
					{
						if (_x isKindOf "Logic") then
						{
							["Is a logic. Ignoring."] call Ares_fnc_LogMessage;
						}
						else
						{
							["Is an empty vehicle."] call Ares_fnc_LogMessage;
							_emptyObjects pushBack _x;
						};
					};
				}
				else
				{
					["Ignoring object: %1 - %2", _x, typeof(_x)] call Ares_fnc_LogMessage;
				};
			} forEach _objectsToFilter;

			_output = [];
			if (!_includeUnits) then { _groups = []; };
			if (!_includeEmptyVehicles) then { _emptyVehicles = []; };
			if (!_includeEmptyObjects) then { _emptyObjects = []; };

			_emptyObjects append _emptyVehicles;

			_totalUnitsProcessed = 0;
			{
				_output pushBack format [
					"_newObject = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; _newObject setPosASL %3; _newObject setVectorDirAndUp [%4, %5];",
					(typeOf _x),
					(position _x),
					(getPosASL _x),
					(vectorDir _x),
					(vectorUp _x)];
			} forEach _emptyObjects;

			{
				_output pushBack format [
					"_newGroup = createGroup %1; ",
					(side _x)];
				_groupVehicles = [];
				// Process all the infantry in the group
				{
					if (vehicle _x == _x) then
					{
						_output pushBack format [
							"_newUnit = _newGroup createUnit ['%1', %2, [], 0, 'CAN_COLLIDE']; _newUnit setSkill %3; _newUnit setRank '%4'; _newUnit setFormDir %5; _newUnit setDir %5; _newUnit setPosASL %6;",
							(typeOf _x),
							(position _x),
							(skill _x),
							(rank _x),
							(getDir _x),
							(getPosASL _x)];
					}
					else
					{
						if (not ((vehicle _x) in _groupVehicles)) then
						{
							_groupVehicles pushBack (vehicle _x);
						};
					};
					_totalUnitsProcessed = _totalUnitsProcessed + 1;
				} forEach (units _x);

				// Create the vehicles that are part of the group.
				{
					_output pushBack format [
						"_newUnit = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; createVehicleCrew _newUnit; (crew _newUnit) join _newGroup; _newUnit setDir %3; _newUnit setFormDir %3; _newUnit setPosASL %4;",
						(typeOf _x),
						(position _x),
						(getDir _x),
						(getPosASL _x)];
				} forEach _groupVehicles;

				// Set group behaviours
				_output pushBack format [
					"_newGroup setFormation '%1'; _newGroup setCombatMode '%2'; _newGroup setBehaviour '%3'; _newGroup setSpeedMode '%4';",
					(formation _x),
					(combatMode _x),
					(behaviour (leader _x)),
					(speedMode _x)];

				{
					if (_forEachIndex > 0) then
					{
						_output pushBack format [
							"_newWaypoint = _newGroup addWaypoint [%1, %2]; _newWaypoint setWaypointType '%3';%4 %5 %6",
							(waypointPosition _x),
							0,
							(waypointType _x),
							if ((waypointSpeed _x) != 'UNCHANGED') then { "_newWaypoint setWaypointSpeed '" + (waypointSpeed _x) + "'; " } else { "" },
							if ((waypointFormation _x) != 'NO CHANGE') then { "_newWaypoint setWaypointFormation '" + (waypointFormation _x) + "'; " } else { "" },
							if ((waypointCombatMode _x) != 'NO CHANGE') then { "_newWaypoint setWaypointCombatMode '" + (waypointCombatMode _x) + "'; " } else { "" }
							];
					};
				} forEach (waypoints _x)
			} forEach _groups;

			if (_includeMarkers) then
			{
				{
					_markerName = "Ares_Imported_Marker_" + str(_forEachIndex);
					_output pushBack format [
						"_newMarker = createMarker ['%1', %2]; _newMarker setMarkerShape '%3'; _newMarker setMarkerType '%4'; _newMarker setMarkerDir %5; _newMarker setMarkerColor '%6'; _newMarker setMarkerAlpha %7; %8 %9",
						_markerName,
						(getMarkerPos _x),
						(markerShape _x),
						(markerType _x),
						(markerDir _x),
						(getMarkerColor _x),
						(markerAlpha _x),
						if ((markerShape _x) == "RECTANGLE" ||(markerShape _x) == "ELLIPSE") then { "_newMarker setMarkerSize " + str(markerSize _x) + ";"; } else { ""; },
						if ((markerShape _x) == "RECTANGLE" || (markerShape _x) == "ELLIPSE") then { "_newMarker setMarkerBrush " + str(markerBrush _x) + ";"; } else { ""; }
						];
				} forEach allMapMarkers;
			};

			_text = "";
			{
				_text = _text + _x;
				[_x] call Ares_fnc_LogMessage;
			} forEach _output;

			_objectscount = count _emptyObjects;
			_groupscount = count _groups;
			["Saving file %4 to client ... (%1 objects, %2 groups, %3 units)", _objectscount, _groupscount, _totalUnitsProcessed] call Ares_fnc_ShowZeusMessage;

			_mish = profileNamespace getVariable [format["savemish_%1", worldname], []];
			_mish pushback [format ["%1_%2_%3", name player, (_dialogResult select 0), date], _text];
			profileNamespace setVariable [format["savemish_%1", worldname], _mish];
		}
	] call Ares_fnc_RegisterCustomModule;

	[ //Mish load
		"Save/Load",
		"Load from client",
		{
			_mish = profileNamespace getVariable [format["savemish_%1", worldname],[]];
			_mishlist = [];
			{
				_mishlist pushback (_x select 0);
			} foreach _mish;

			_dialogResult =
				[
					"Load from client",
					[
						["Choose file", _mishlist]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_loadmish = (_mish select (_dialogResult select 0)) select 1;
			try
			{
				[(compile _loadmish), _this, 2] call Ares_fnc_BroadcastCode;
			}
			catch
			{
				diag_log _exception;
				["Failed to parse code. See RPT for error."] call Ares_fnc_ShowZeusMessage;
			};

			_mishname = _mishlist select (_dialogResult select 0);
			[format["If you don't see any errors, file %1 is now loaded!",_mishname]] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[ //Mish delete player
		"Save/Load",
		"Delete from client",
		{
			_mish = profileNamespace getVariable [format["savemish_%1", worldname],[]];
			_mishlist = [];
			{
				_mishlist pushback (_x select 0);
			} foreach _mish;

			_dialogResult =
				[
					"Delete from client",
					[
						["Choose file", _mishlist]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_mish deleteAt (_dialogResult select 0);
			profileNamespace setVariable [format["savemish_%1", worldname], _mish];

			_mishname = _mishlist select (_dialogResult select 0);
			[format["File %1 deleted from client!",_mishname]] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Detonate Nuke",
		{
			_dialogResult =
				["Bomb settings",
						[
							["Explosive yield:", ["Small", "Medium", "Big", "Huge"]]
						]
				] call Ares_fnc_ShowChooseDialog;

			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_yield = "grenadeHand";
			switch (_dialogResult select 0) do
			{
				case 0: { _yield = 500; };
				case 1: { _yield = 1000; };
				case 2: { _yield = 2000; };
				default { _yield = 5000; };
			};

			_pos = _this select 0;
			[_pos,_yield] remoteExec ["RHS_fnc_ss21_nuke", 2, false];

			["TAKE COVER!"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Helipad lights (Remove)",
		{
			_pads = ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"];
			_pad = _this select 1;
			if !((typeof _pad) in _pads) then {
				_npad = nearestObjects [(_this select 0), _pads, 15];
				_badpad = false;
				if ((isnil "_npad") || ((count _npad) == 0)) exitwith {_badpad = true};
				_pad = _npad select 0;
			};

			if (_badpad) exitwith {["NO HELIPAD SELECTED"] call Ares_fnc_ShowZeusMessage};

			[_pad] call seven_fnc_helipad_light_remove;

			["HELIPAD LIGHTS DELETED"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;
/*
	[
		"7CMBG",
		"Start Riot",
		{
			_pos = _this select 0;
			_men = _pos nearEntities ["Man", 1000];
			_tire =	createVehicle ["misc_tyreheap", _pos, [], 1, "NONE"];

			{
				if ((alive _x) && (side _x == CIVILIAN) && (random 10 > 2)) then {
					_newpos = (position _tire) findEmptyPosition [1, 20];
					_x moveto _newpos;
				};
			} foreach _men;

			["RIOT STARTED."] call Ares_fnc_ShowZeusMessage;

			while {count (_pos nearEntities ["Man", 10]) < 5} do {
				sleep 10;
			};

			[1, _tire] execvm "\ares_zeusExtensions\scripts\spawnSmoke.sqf";

			while {count (_pos nearEntities ["Man", 10]) > 5} do {
				playSound3D ["crowd.ogg", objnull, false, _pos, 1];
				sleep 12;
			};

			deletevehicle _tire;
		}
	] call Ares_fnc_RegisterCustomModule;
*/
	[
		"Spawn",
		"Flies",
		{
			[(_this select 0)] call BIS_fnc_flies;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Spawn",
		"Sandstorm",
		{
			[(_this select 1)] call BIS_fnc_sandstorm;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set Renegade",
		{

			(_this select 1) addrating -100000;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"AI Behaviour",
		"AI Attack Nearest Enemies",
		{
			private ["_pos","_nearunits","_unit","_grp"];
			_pos = _this select 0;
			_nearunits = _pos nearEntities 10;
			_unit = _nearunits select 0;

			_grp = group _unit;
			if (_grp == grpNull) exitwith {"ERROR: NO GROUP SELECTED.";};

			[_grp, getPosWorld (_unit findNearestEnemy _pos)] remoteExec ["CBA_fnc_taskAttack", _unit, false];

			["ATTACK STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"AI Behaviour",
		"AI Sweep ",
		{
			private ["_pos","_nearunits","_unit","_grp","_dialogResult","_radius","_mode"];
			_pos = _this select 0;
			_nearunits = _pos nearEntities 10;
			_unit = _nearunits select 0;

			_grp = group _unit;
			if (_grp == grpNull) exitwith {"ERROR: NO GROUP SELECTED.";};

			_dialogResult =
				["Begin Sweep",
						[
							["Sweep Mode:", ["Basic", "Advanced"]],
							["Waypoints max spacing:", ["50m", "100m", "200m", "300m", "500m", "750m", "1000m"],3]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_radius = 50;
			switch (_dialogResult select 1) do
			{
				case 0: { _radius = 50; };
				case 1: { _radius = 100; };
				case 2: { _radius = 200; };
				case 3: { _radius = 300; };
				case 4: { _radius = 500; };
				case 5: { _radius = 750; };
				default { _radius = 1000; };
			};

			_mode = "bis_fnc_taskPatrol";
			switch (_dialogResult select 0) do
			{
				case 0: { _mode = "bis_fnc_taskPatrol"; };
				default { _mode = "CBA_fnc_taskPatrol"; };
			};

			[_grp, _pos, _radius] remoteExec [_mode, _unit, false];

			["SWEEP STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"AI Behaviour",
		"AI Defend",
		{
			private ["_pos","_nearunits","_unit","_grp","_dialogResult","_radius","_mode"];
			_pos = _this select 0;
			_nearunits = _pos nearEntities 10;
			_unit = _nearunits select 0;

			_grp = group _unit;
			if (_grp == grpNull) exitwith {"ERROR: NO GROUP SELECTED.";};

			_dialogResult =
				["Begin Defence",
						[
							["Defence Mode:", ["Hold", "Fortify"]],
							["Defend Radius (Fortify only):", ["50m", "100m", "200m", "300m", "500m", "750m", "1000m"],3]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_mode = "bis_fnc_taskDefend";
			switch (_dialogResult select 0) do
			{
				case 0: { _mode = "bis_fnc_taskDefend"; };
				default { _mode = "CBA_fnc_taskDefend"; };
			};

			if (_mode == "CBA_fnc_taskDefend") then {
				_radius = 50;
				switch (_dialogResult select 1) do
				{
					case 0: { _radius = 50; };
					case 1: { _radius = 100; };
					case 2: { _radius = 200; };
					case 3: { _radius = 300; };
					case 4: { _radius = 500; };
					case 5: { _radius = 750; };
					default { _radius = 1000; };
				};
				[_grp, _pos, _radius] remoteExec [_mode, _unit, false];
			} else {
				[_grp, _pos] remoteExec [_mode, _unit, false];
			};

			["DEFENCE STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;
};

waituntil {!isnil "Ares_EditableObjectBlacklist"};

Ares_EditableObjectBlacklist append [
	"ALiVE_mil_placement_custom",
	"ALiVE_mil_OPCOM",
	"ALiVE_mil_logistics",
	"ALiVE_amb_civ_placement",
	"ALiVE_amb_civ_population",
	"ALiVE_MIL_C2ISTAR",
	"ALiVE_sys_data",
	"ALiVE_SUP_PLAYER_RESUPPLY",
	"ALiVE_sys_profile",
	"ALiVE_require",
	"ALiVE_SYS_LOGISTICSDISABLE",
	"HeadlessClient_F",
	"ALiVE_civ_placement",
	"ALiVE_mil_placement",
	"tfar_ModuleTaskForceRadioFrequencies",
	"RyanZM_ModuleAbilities",
	"RyanZM_ModuleSettings",
	"RyanZM_ModuleInfection",
	"SpyderAddons_amb_ambiance",
	"SpyderAddons_civ_interact",
	"acex_headless_module",
	"LT_settings",
	"LT_makeLTmenu",
	"CUP_B_LHD_WASP_USMC_Empty",
	"CUP_WV_B_Phalanx",
	"CUP_WV_B_SS_Launcher_naval",
	"CUP_WV_B_RAM_Launcher_naval",
	"CUP_LHD_Light",
	"CUP_LHD_Light2",
	"CUP_LHD_Light_Green",
	"CUP_LHD_Int_1",
	"CUP_LHD_Int_2",
	"CUP_LHD_Int_3",
	"CUP_LHD_house_1",
	"CUP_LHD_house_",
	"CUP_LHD_1",
	"CUP_LHD_2",
	"CUP_LHD_3",
	"CUP_LHD_4",
	"CUP_LHD_5",
	"CUP_LHD_6",
	"CUP_LHD_7",
	"CUP_LHD_Monitor",
	"CUP_LHD_elev_1",
	"CUP_LHD_elev_2"
];