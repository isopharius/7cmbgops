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
						["Radius", ["50m", "100m", "500m", "1km", "2km", "5km", "Entire Map"], 6],
						["Include AI?", ["Yes", "No"]],
						["Include Empty Vehicles?", ["Yes", "No"]],
						["Include Objects?", ["Yes", "No"]],
						["Include Markers?", ["Yes", "No"], 1]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };


			["Name your file if you want."] call Ares_fnc_ShowZeusMessage;

			missionNamespace setVariable ['Ares_CopyPaste_Dialog_Text', ""];
			missionNamespace setVariable ["Ares_CopyPaste_Dialog_Result", ""];
			_dialog = createDialog "Ares_CopyPaste_Dialog";
			waitUntil { dialog };
			waitUntil { !dialog };

			_dialogname = missionNamespace getVariable ["Ares_CopyPaste_Dialog_Result", -1];

			if !(_dialogname == 1) exitwith {"User cancelled dialog.";};

			_mishname = missionNamespace getVariable ["Ares_CopyPaste_Dialog_Text", "[]"];

			["User chose radius with index '%1'", _dialogResult] call Ares_fnc_LogMessage;
			_radius = 100;
			switch (_dialogResult select 0) do
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
			_includeUnits = if (_dialogResult select 1 == 0) then { true; } else { false; };
			_includeEmptyVehicles = if (_dialogResult select 2 == 0) then { true; } else { false; };
			_includeEmptyObjects = if (_dialogResult select 3 == 0) then { true; } else { false; };
			_includeMarkers = if (_dialogResult select 4 == 0) then { true; } else { false; };

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

			_totalUnitsProcessed = 0;
			{
				_output pushBack format [
					"_newObject = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; _newObject setposworld %3; _newObject setVectorDirAndUp [%4, %5];",
					(typeOf _x),
					(getPosworld _x),
					(getPosworld _x),
					(vectorDir _x),
					(vectorUp _x)];
			} forEach _emptyObjects + _emptyVehicles;

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
							"_newUnit = _newGroup createUnit ['%1', %2, [], 0, 'CAN_COLLIDE']; _newUnit setSkill %3; _newUnit setRank '%4'; _newUnit setFormDir %5; _newUnit setDir %5; _newUnit setposworld %6;",
							(typeOf _x),
							(getPosworld _x),
							(skill _x),
							(rank _x),
							(getDir _x),
							(getPosworld _x)];
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
						"_newUnit = createVehicle ['%1', %2, [], 0, 'CAN_COLLIDE']; createVehicleCrew _newUnit; (crew _newUnit) join _newGroup; _newUnit setDir %3; _newUnit setFormDir %3; _newUnit setposworld %4;",
						(typeOf _x),
						(position _x),
						(getDir _x),
						(getPosworld _x)];
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

			["Saving file %4 to client ... (%1 objects, %2 groups, %3 units)", count _emptyObjects, count _groups, _totalUnitsProcessed,_mishname] call Ares_fnc_ShowZeusMessage;

			_mish = profileNamespace getVariable [format["savemish_%1", worldname],[]];
			_mish pushback [format ["%1_%2_%3", name player, _mishname, time],_text];
			profileNamespace setVariable [format["savemish_%1", worldname],_mish];
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

	//custom modules
	[
		"ALiVE",
		"Add OPCOM Objective",
		{
			_dialogResult =
				[
					"Objective parameters",
					[
						["Size", ["Small", "Medium", "Large", "Huge"], 2],
						["Type", ["Military", "Civilian"]],
						["Priority", ["Low", "Medium", "High"], 2]
					]
				] call Ares_fnc_ShowChooseDialog;

			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			switch (_dialogResult select 0) do
				{
					case 0: { _size = 50 };
					case 1: { _size = 100 };
					case 2: { _size = 200 };
					case 3: { _size = 500 };
				};

			switch (_dialogResult select 1) do
				{
					case 0: { _type = "MIL" };
					case 1: { _type = "CIV" };
				};

			switch (_dialogResult select 2) do
				{
					case 0: { _type = "100" };
					case 1: { _type = "200" };
					case 2: { _type = "300" };
				};

			_pos = _this select 0;
			{[[_x,"addObjective", ["OPCOM_custom", _pos, _size, _type, _type]], "ALiVE_fnc_OPCOM", false] call BIS_fnc_MP;} foreach OPCOM_INSTANCES;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"SIDEOPS",
		"Start Insurgency",
		{
			if (!isnil "insurgency") exitwith {"insurgency already started"};
			[[],"seven_fnc_ins_init", true, true, true] call BIS_fnc_MP;
			["INSURGENCY STARTED"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"SIDEOPS",
		"Start Air SideOps",
		{
			_dialogResult =
				[
					"Objective",
					[
						["Pick Objective Type", ["Random", "SEAD", "Close Air Support", "Search & Destroy", "Bomb Run"]]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_choose = "rand";
			switch (_dialogResult select 0) do
			{
				case 0: { _choose = "rand"; };
				case 1: { _choose = "arty"; };
				case 2: { _choose = "cas"; };
				case 3: { _choose = "convoy"; };
				default { _choose = "warehouse"; };
			};

			[[(_this select 0),_choose],"seven_fnc_missionair", false, false, true] call BIS_fnc_MP;
			["SIDEOPS STARTED"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"SIDEOPS",
		"Start Combat SideOps",
		{
			_dialogResult =
				[
					"Objective",
					[
						["Pick Objective Type", ["Random", "Secure Town","Kill HVT","Locate Intel","Find Cache","Sabotage Comms","Full Frontal","Destroy AA","Capture Leader","Nuclear Countdown"]]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_choose = "rand";
			switch (_dialogResult select 0) do
			{
				case 0: { _choose = "rand" };
				case 1: { _choose = "clear"; };
				case 2: { _choose = "kill"; };
				case 3: { _choose = "ammo"; };
				case 4: { _choose = "ammo2"; };
				case 5: { _choose = "comms"; };
				case 6: { _choose = "clear2"; };
				case 7: { _choose = "antiair"; };
				case 8: { _choose = "capture"; };
				default { _choose = "nuke"; };
			};

			[[(_this select 0),_choose],"seven_fnc_missionclear",false, false, true] call BIS_fnc_MP;
			["SIDEOPS STARTED"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"SIDEOPS",
		"Start Support SideOps",
		{
			_dialogResult =
				[
					"Type of objective",
					[
						["Pick Objective Type", ["Random", "EOD", "Road Maintenance", "Deploy HQ", "Supply Run","Towing Duty", "CASEVAC", "UAV Recovery", "CSAR"]]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_choose = "rand";
			switch (_dialogResult select 0) do
			{
				case 0: { _choose = "rand"; };
				case 1: { _choose = "ied"; };
				case 2: { _choose = "roadrepair"; };
				case 3: { _choose = "hqbuild"; };
				case 4: { _choose = "towrepair"; };
				case 5: { _choose = "vehrepair"; };
				case 6: { _choose = "rescue"; };
				case 7: { _choose = "uavrec"; };
				default { _choose = "pilotrescue"; };
			};

			[[(_this select 0),_choose],"seven_fnc_missionsupport",false, false, true] call BIS_fnc_MP;
			["SIDEOPS STARTED"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

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
		"AI Behaviours",
		"AI Sweep",
		{
			_unit = _this select 1;
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

			_pos = _this select 0;
			[[_grp, _pos, _radius], _mode, _unit, false, true] call BIS_fnc_MP;

			["SWEEP STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"AI Behaviours",
		"AI Defend",
		{
			_unit = _this select 1;
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

			if ((_dialogResult select 0) == 1) then {
				 _mode = "bis_fnc_taskDefend";
			} else {
				 _mode = "CBA_fnc_taskDefend";
			};

			_pos = _this select 0;
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
				[[_grp, _pos, _radius], _mode, _unit, false, true] call BIS_fnc_MP;
			} else {
				[[_grp, _pos], _mode, _unit, false, true] call BIS_fnc_MP;
			};

			["DEFENCE STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set High Commander",
		{
			_unit = (_this select 0) nearestObject "Man";
			if ((_unit == objNull) || (group _unit == grpNull) || (!alive _unit) || !(_unit == player) || (!isplayer _unit)) exitwith {"NO PLAYER SELECTED.";};

			{
				if (side _x == west) then {
					_unit hcsetgroup [_x,""];
				};
			} foreach allgroups;

			["%1 SET TO HIGH COMMANDER.", _unit] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set Medic (TCCC)",
		{
			_unit = (_this select 0) nearestObject "Man";
			if ((_unit == objNull) || (group _unit == grpNull) || (!alive _unit) || !(_unit == player) || (!isplayer _unit)) exitwith {"NO PLAYER SELECTED.";};
			_unit setvariable ["ace_medical_medicClass", 1, true];

			["%1 SET AS MEDIC.", _unit] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set Medical Facility",
		{
			_facility = _this select 1;
			if (!alive _facility) exitwith {"NO SUITABLE OBJECT SELECTED.";};
			_facility setvariable ["ace_medical_isMedicalFacility", 1, true];
			_facility addBackpackCargoGlobal ['B_ons_Carryall_TCCC_TW',1];
			_facility addBackpackCargoGlobal ['B_ons_Carryall_Paramedic',1];

			["%1 SET AS MEDICAL FACILITY.", _facility] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set Medical Vehicle",
		{
			_veh = _this select 1;
			if (!alive _veh) exitwith {"NO SUITABLE VEHICLE SELECTED.";};
			_veh setvariable ["ace_medical_medicClass", 1, true];
			_veh addBackpackCargoGlobal ['B_ons_Carryall_TCCC_TW',1];
			_veh addBackpackCargoGlobal ['B_ons_Carryall_Paramedic',1];

			["%1 SET AS MEDICAL VEHICLE.", _veh] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set Suicide Bomber",
		{
			_bomber = _this select 1;
			if ((group _bomber == grpNull) || (!alive _bomber)) exitwith {"NO SUITABLE BOMBER SELECTED.";};

			_dialogResult =
				["Bomber settings",
						[
							["Explosive:", ["Small", "Medium", "Big", "Huge","Nuclear!"]],
							["Target side(s):", ["BLUFOR", "OPFOR", "INDEPENDENT","ALL"]]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_bomb = "grenadeHand";
			switch (_dialogResult select 0) do
			{
				case 0: { _bomb = "grenadeHand"; };
				case 1: { _bomb = "M_Mo_82mm_AT_LG"; };
				case 2: { _bomb = "M_Mo_120mm_AT_LG"; };
				case 3: { _bomb = "Bo_GBU12_LGB_MI10"; };
				default { _bomb = "Nuke"; };
			};

			_targetside = [WEST];
			switch (_dialogResult select 1) do
			{
				case 0: { _targetside = [WEST]; };
				case 1: { _targetside = [EAST]; };
				case 2: { _targetside = [RESISTANCE]; };
				default { _targetside = [CiVILIAN,WEST,EAST,RESISTANCE]; };
			};

			[[_bomber,_targetside,_bomb], "seven_fnc_suicidebomber", _bomber] call BIS_fnc_MP;

			if (vehicle _bomber == _bomber) then {
				["%1 SET AS SUICIDE BOMBER.", _bomber] call Ares_fnc_ShowZeusMessage;
			} else {
				["%1 SET AS BOMBCAR.", _bomber] call Ares_fnc_ShowZeusMessage;
			};
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set Armed Civilian",
		{
			_sleeper = _this select 1;
			if ((group _sleeper == grpNull) || (!alive _sleeper) || (side _sleeper != civilian)) exitwith {"NO SUITABLE CIVILIAN SELECTED.";};

			[[_sleeper,"",(50+random 50),10,1,0.8], "seven_fnc_ws_assassins", _sleeper] call BIS_fnc_MP;

			["CIVILIAN %1 ARMED.", _sleeper] call Ares_fnc_ShowZeusMessage;
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
			[[_pos,_yield], "RHS_fnc_ss21_nuke", false, false, true] call BIS_fnc_MP;

			["TAKE COVER!"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Helipad lights (Add)",
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

			_dialogResult =
				["Colors",
						[
							["Inner Lights:", ["Red", "Green", "Yellow", "IR"], 2],
							["Outer Lights:", ["Red", "Green", "Yellow", "Blue", "White", "IR"], 1]
						]
				] call Ares_fnc_ShowChooseDialog;

			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_inner = "Yellow";
			switch (_dialogResult select 0) do
			{
				case 0: { _inner = "Red"; };
				case 1: { _inner = "Green"; };
				case 2: { _inner = "Yellow"; };
				default { _inner = "IR"; };
			};

			_outer = "Green";
			switch (_dialogResult select 0) do
			{
				case 0: { _outer = "Red"; };
				case 1: { _outer = "Green"; };
				case 2: { _outer = "Yellow"; };
				case 3: { _outer = "Blue"; };
				case 4: { _outer = "White"; };
				default { _outer = "IR"; };
			};

			[_pad, _inner, _outer, false] spawn seven_fnc_helipad_light;

			["HELIPAD LIGHTS ADDED"] call Ares_fnc_ShowZeusMessage;
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

	[
		"Spawn",
		"LHD Carrier",
		{
			_pos = _this select 0;

			if !(isnil "LHAAlive") exitwith {"LHD already exists"};
			if !(surfaceiswater _pos) exitwith {"Surface is not water"};

			_pad = createVehicle ["Land_HelipadEmpty_F", [(_pos select 0), (_pos select 1), (_pos select 2) + 10], [], 0, "can_collide"];
			if (worldname == "mog") then {
				_pad setposworld [_pos select 0, _pos select 1, 7.5];
			} else {
				_pad setposworld [_pos select 0, _pos select 1, 0];
			};

			_lhd = createVehicle ["ATLAS_ONS_LHD_helper", (getposatl _pad), [], 0, "none"];
			[[_lhd,_pad], "seven_fnc_lha_main", true, true, true] call BIS_fnc_MP;

			["LHD spawned"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;
};

waituntil {!isnil "Ares_EditableObjectBlacklist"};
Ares_EditableObjectBlacklist = Ares_EditableObjectBlacklist + [
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
	"mcc_sandbox_moduleGAIASettings",
	"mcc_sandbox_moduleCover",
	"mcc_sandbox_moduleMissionSettings",
	"ACE_ModuleCheckPBOs",
	"ACE_ModuleSitting",
	"ace_finger_moduleSettings",
	"HeadlessClient_F",
	"ALiVE_civ_placement",
	"ALiVE_mil_placement"
];