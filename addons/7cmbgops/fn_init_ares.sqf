if (isHC) exitwith {};

if (isserver) then { //server

	mish = profileNamespace getVariable [format["savemish_%1", worldname], []];

	publicVariable "mish";

	"mish" addPublicVariableEventHandler {
		profileNamespace setVariable [format["savemish_%1", worldname], mish];
	};

	if (isdedicated) then { //save server profile when all players gone
		["saveprofile", "onPlayerDisconnected", {
			if ( ({isPlayer _x} count playableUnits) isEqualTo 0 ) then { saveprofileNamespace };
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
			if (count _dialogResult isEqualTo 0) exitWith {};

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
			if (count _dialogResult isEqualTo 0) exitWith {};

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
			if (count _dialogResult isEqualTo 0) exitWith {};

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
						["Mission Name:", ""],
						["Radius:", ["50m", "100m", "500m", "1km", "2km", "5km", "Entire Map"], 6],
						["Include AI?", ["Yes", "No"]],
						["Include Empty Vehicles?", ["Yes", "No"]],
						["Include Objects?", ["Yes", "No"]],
						["Include Markers?", ["Yes", "No"], 1]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};

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
			_includeUnits = if (_dialogResult select 2 isEqualTo 0) then { true; } else { false; };
			_includeEmptyVehicles = if (_dialogResult select 3 isEqualTo 0) then { true; } else { false; };
			_includeEmptyObjects = if (_dialogResult select 4 isEqualTo 0) then { true; } else { false; };
			_includeMarkers = if (_dialogResult select 5 isEqualTo 0) then { true; } else { false; };

			_objectsToFilter = curatorEditableObjects (allCurators select 0);
			_emptyObjects = [];
			_emptyVehicles = [];
			_groups = [];
			{
				_ignoreFlag = false;
				if ((typeOf _x) in Ares_EditableObjectBlacklist or _x == player or isPlayer _x) then
				{
					_ignoreFlag = true;
				};

				if (!_ignoreFlag and ((_x distance _position <= _radius) or _radius isEqualTo -1)) then
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
					if (vehicle _x isEqualTo _x) then
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
						if ((markerShape _x) isEqualTo "RECTANGLE" ||(markerShape _x) isEqualTo "ELLIPSE") then { "_newMarker setMarkerSize " + str(markerSize _x) + ";"; } else { ""; },
						if ((markerShape _x) isEqualTo "RECTANGLE" || (markerShape _x) isEqualTo "ELLIPSE") then { "_newMarker setMarkerBrush " + str(markerBrush _x) + ";"; } else { ""; }
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
			if (count _dialogResult isEqualTo 0) exitWith {};

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
			if (count _dialogResult isEqualTo 0) exitWith {};

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

			if (count _dialogResult isEqualTo 0) exitWith {};

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
				if ((isnil "_npad") || ((count _npad) isEqualTo 0)) exitwith {_badpad = true};
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
				if ((alive _x) && (side _x isEqualTo CIVILIAN) && (random 10 > 2)) then {
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
		"Attack Nearest Enemy",
		{
			_pos = _this select 0;
			_nearunits = _pos nearEntities 10;
			_unit = _nearunits select 0;

			_grp = group _unit;
			if (isNull _grp) exitwith {["ERROR: NO GROUP SELECTED."] call Ares_fnc_ShowZeusMessage;};

			[_grp, getPosWorld (_unit findNearestEnemy _pos)] remoteExec ["CBA_fnc_taskAttack", _unit, false];

			["ATTACK STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Defuse Bomb",
		{
			if (!isNil "BOMB") exitWith {["BOMB ALREADY ARMED."] call Ares_fnc_ShowZeusMessage;};

			_object = _this select 1;

			_dialogResult =
				["SELECT 4 DIGITS CODE",
						[
							["First digit:", ["random", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]],
							["Second digit:", ["random", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]],
							["Third digit:", ["random", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]],
							["Fourth digit:", ["random", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};

			_digit1 = (_dialogResult select 0) - 1;
			if (_digit1 isEqualTo -1) then {
				_digit1 = round (random 9);
			};
			_digit2 = (_dialogResult select 1) - 1;
			if (_digit2 isEqualTo -1) then {
				_digit2 = round (random 9);
			};
			_digit3 = (_dialogResult select 2) - 1;
			if (_digit3 isEqualTo -1) then {
				_digit3 = round (random 9);
			};
			_digit4 = (_dialogResult select 3) - 1;
			if (_digit4 isEqualTo -1) then {
				_digit4 = round (random 9);
			};

			CODE = [_digit1, _digit2, _digit3, _digit4];
			WIRE = selectRandom ["BLUE", "WHITE", "YELLOW", "GREEN"];
			CODEINPUT = [];
			DEFUSED = false;
			ARMED = false;
			BOMB = true;
			publicVariable "CODE";
			publicVariable "WIRE";
			publicVariable "CODEINPUT";
			publicVariable "DEFUSED";
			publicVariable "ARMED";
			publicVariable "BOMB";

			_object addAction [("<t color='#E61616'>" + ("Defuse the Bomb") + "</t>"),"createDialog 'KeypadDefuse'","",1,true,true,"","(_target distance _this) < 3"];

			["BOMB ARMED. HIDE THE CODE ON ANOTHER OBJECT."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Hide Bomb Code",
		{
			if (isNil "BOMB") exitWith {["No bomb previously armed."] call Ares_fnc_ShowZeusMessage;};

			_object = _this select 1;
			_object addAction [("<t color='#E61616'>" + ("Search Bomb Code") + "</t>"),seven_fnc_searchAction,"",1,true,true,"","(_target distance _this) < 3"];

			["BOMB CODE HIDDEN."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"ACE",
		"Place IED",
		{
			_pos = _this select 0;
			_object = "#lightpoint" createVehicleLocal [0,0,0];

			[_object, _pos, random 360, "iEDurbanSmall_Remote_Mag" , "PressurePlate", []] call ACE_Explosives_fnc_placeExplosive;
			deletevehicle _object;

			["IED PLACED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Environment",
		"Sandstorm (experimental))",
		{
			_dialogResult =
				["SELECT SANDSTORM INTENSITY",
						[
							["Sand Particles:", ["Random","Light","Moderate","Heavy","Disabled"], 4]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};

			varEnableSand = nil;
			publicvariable "varEnableSand";

			_sand = _dialogResult select 0;

			if (_sand isEqualTo 4) then {
				["SANDSTORM DISABLED."] call Ares_fnc_ShowZeusMessage;

			} else {
				["WAIT 10 seconds for sync."] call Ares_fnc_ShowZeusMessage;
				sleep 10;

				if (_sand isEqualTo 0) then {["RANDOM SANDSTORM INCOMING."] call Ares_fnc_ShowZeusMessage;};
				if (_sand isEqualTo 1) then {["LIGHT SANDSTORM INCOMING."] call Ares_fnc_ShowZeusMessage;};
				if (_sand isEqualTo 2) then {["MEDIUM SANDSTORM INCOMING."] call Ares_fnc_ShowZeusMessage;};
				if (_sand isEqualTo 3) then {["HEAVY SANDSTORM INCOMING."] call Ares_fnc_ShowZeusMessage;};

				// define the global sand parameter array
				//[fog,overcast,use ppEfx,allow rain,force wind,vary fog,use wind audio,EFX strength]
				_MKY_arSandEFX = [0,"",true,false,true,true,true,_sand];
				// init the EFX scripts
				_MKY_arSandEFX remoteExec ["seven_fnc_Sand_Snow_Init", 0, true];
			};
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Player",
		"HALO",
		{
			_dialogResult =
				["SELECT JUMP ALTITUDE (chutes not included)",
						[
							["Altitude:", ["3000m","5000m","8000m","10000m","12000m"],2]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};

			["SELECT PLAYERS TO HALO THEN PRESS Enter."] call Ares_fnc_ShowZeusMessage;
			_selection = [toLower localize "STR_PLAYERS"] call Achilles_fnc_SelectUnits;
			if (isNil "_selection") exitWith {nil};
			_haloplayers = [{isPlayer _this},_selection] call Achilles_fnc_filter;

			_altitude = 8000;
			switch (_dialogResult select 0) do
			{
				case 0: { _altitude = 4000; };
				case 1: { _altitude = 6000; };
				case 2: { _altitude = 9000; };
				case 3: { _altitude = 11000; };
				case 4: { _altitude = 13000; };
			};

			//spawn plane
			_pos = _this select 0;
			_posx = (_pos select 0);
			_posy = (_pos select 1);
			_randompos = selectRandom [[_posx + 8000, _posy + 8000, _altitude], [_posx + 8000, _posy - 8000, _altitude], [_posx - 8000, _posy + 8000, _altitude], [_posx - 8000, _posy - 8000, _altitude]];
			_createplane = [_randompos, 0, "ONS_AIR_CC130J", WEST] call BIS_fnc_spawnVehicle;
			_plane = _createplane select 0;
			_crewplane = _createplane select 1;
			_groupplane = _createplane select 2;
			_plane setDir (_plane getRelDir _pos);
			_altitude = _altitude - (random 1000);
			_plane flyInHeight _altitude;
			_waypoint = _groupplane addWaypoint [[_posx,_posy,_altitude],500];
			_waypoint setWaypointSpeed "LIMITED";
			_waypoint setWaypointType "MOVE";

			//put players in the plane
			{
				_x moveInCargo _plane;
			} foreach _haloplayers;
			waitUntil {(!alive _plane) or ((_plane distance (waypointPosition _waypoint)) < 5000)};
			if (!alive _plane) exitWith {};

			_plane animateSource ["ramp", 0.65];
			_groupplane setSpeedMode "LIMITED";

			//delete plane after a while
			sleep 120;
			{
				_plane deleteVehicleCrew _x;
			} foreach _crewplane;
			deletevehicle _plane;
			deleteGroup _groupplane;
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
