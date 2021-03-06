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

			_mishpick = _dialogResult select 0;
			mish pushback (_mish select _mishpick);
			publicVariable "mish";

			_mishname = _mishlist select _mishpick;
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

			_mishpick = _dialogResult select 0;
			_loadmish = (mish select _mishpick) select 1;
			try
			{
				[(compile _loadmish), _this, false] call Ares_fnc_BroadcastCode;
			}
			catch
			{
				diag_log _exception;
				["Failed to parse code. See RPT for error."] call Ares_fnc_ShowZeusMessage;
			};

			_mishname = _mishlist select _mishpick;
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

			_mishpick = _dialogResult select 0;
			mish deleteAt _mishpick;
			publicVariable "mish";

			_mishname = _mishlist select _mishpick;
			[format["File %1 deleted from server!",_mishname]] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;
};

if (hasInterface) then { //players
	[ //Mish save
		"Save/Load",
		"Save to client",
		{

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

			params ["_position"];

			//get radius
			_radius = [50, 100, 500, 1000, 2000, 5000, -1];
			_radius = _radius select (_dialogResult select 1);

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
				if ((typeOf _x) in Ares_EditableObjectBlacklist or _x isEqualTo player or isPlayer _x) then
				{
					_ignoreFlag = true;
				};

				if (!_ignoreFlag and {(_radius isEqualTo -1 or {(_x distance _position <= _radius)})}) then
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
					"_newObject = createVehicle ['%1', [0,0,0], [], 0, 'CAN_COLLIDE']; _newObject setPosASL %3; _newObject setVectorDirAndUp [%4, %5];",
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

			_mishpick = _dialogResult select 0;
			_loadmish = (_mish select _mishpick) select 1;
			try
			{
				[(compile _loadmish), _this, 2] call Ares_fnc_BroadcastCode;
			}
			catch
			{
				diag_log _exception;
				["Failed to parse code. See RPT for error."] call Ares_fnc_ShowZeusMessage;
			};

			_mishname = _mishlist select _mishpick;
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

			_mishpick = _dialogResult select 0;
			_mish deleteAt _mishpick;
			profileNamespace setVariable [format["savemish_%1", worldname], _mish];

			_mishname = _mishlist select _mishpick;
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

			//get yield
			_yield = [500, 1000, 2000, 5000];
			_yield = _yield select (_dialogReslut select 0);

			params ["_pos"];
			[_pos,_yield] remoteExec ["RHS_fnc_ss21_nuke", 2, false];

			["TAKE COVER!"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Defuse DA NUKE",
		{
			if (!isNil "BOMB") then {
				if (BOMB) exitWith {["BOMB ALREADY ARMED!"] call Ares_fnc_ShowZeusMessage;};
			};

			_dialogResult =
				["SELECT BOMB TIMER",
						[
							["Bomb timer (in minutes):", ""],
							["Bomb container:", ["Weirdo Device"]],
							["Bomb yield:", ["Random"]]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};

			if ((_dialogResult select 0) isEqualTo "") exitWith {["PLEASE SET TIMER."] call Ares_fnc_ShowZeusMessage;};

			CODE = [round (random 9),round (random 9),round (random 9),round (random 9)];
			WIRE = selectRandom ["BLUE", "WHITE", "YELLOW", "GREEN"];
			CODEINPUT = [];
			DEFUSED = false;
			ARMED = false;
			BOMB = true;
			bombcontainer = createVehicle ["Land_Device_assembled_F", [0,0,0], [], 0, "CAN_COLLIDE"];
			bombcontainer enableSimulation false;
			bombcontainer setPos (_this select 0);

			[[bombcontainer], true] remoteExec ["Ares_fnc_AddUnitsToCurator", 2, false];

			publicVariable "CODE";
			publicVariable "WIRE";
			publicVariable "CODEINPUT";
			publicVariable "BOMB";
			publicVariable "bombcontainer";
			publicVariableServer "DEFUSED";
			publicVariableServer "ARMED";

			[format["BOMB ARMED with CODE %1 - %2 - %3 - %4!", CODE select 0, CODE select 1, CODE select 2, CODE select 3]] call Ares_fnc_ShowZeusMessage;
			player sidechat format["the CODE is %1 - %2 - %3 - %4, add it somewhere with Spawn>Intel", CODE select 0, CODE select 1,CODE select 2, CODE select 3];

			sleep 2;

       		[[bombcontainer, ((parseNumber(_dialogResult select 0)) * 60), 5000], "7cmbgops\scripts\defuse\bombTimer.sqf"] remoteExecCall ["BIS_fnc_execVM", 2, false];
       		[bombcontainer,["<t color='#E61616'>Defuse the BOMB</t>","createDialog 'KeypadDefuse'","",1,true,true,"","true",3]] remoteexecCall ["addAction", 0,true];
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
		"AI Behaviour",
		"Attack Nearest Enemy",
		{
			_unit = _this select 1;
			_grp = group _unit;
			if (isNull _grp) exitwith {["ERROR: NO GROUP SELECTED."] call Ares_fnc_ShowZeusMessage;};

			[_grp, getPosWorld (_unit findNearestEnemy (_this select 0)),500] remoteExecCall ["CBA_fnc_taskAttack", _unit, false];

			["ATTACK STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"ACE",
		"Place IED",
		{
			_dialogResult =
				["ACE IED options",
						[
							["IED type:", ["Random", "Small", "Small Urban", "Big", "Big Urban"]]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};

			params ["_pos"];

			//pick IED type
				_iedpick = _dialogResult select 0;
				_iedtype = ["IEDLandSmall_Remote_Mag", "iEDurbanSmall_Remote_Mag", "IEDLandBig_Remote_Mag","IEDUrbanBig_Remote_Mag"];
			    if (_iedpick isEqualTo 0) then {
					_iedtype = selectRandom _iedtype;
			    } else {
					_iedtype = _iedtype select (_iedpick - 1);
				};

			_object = "#lightpoint" createVehicleLocal [0,0,0];

			[_object, _pos, random 360, _iedtype, "PressurePlate", []] call ACE_Explosives_fnc_placeExplosive;
			deletevehicle _object;
			_ied = _pos nearestobject _iedtype;
			[[_ied], true] remoteExec ["Ares_fnc_AddUnitsToCurator",2,false];

			["IED PLACED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Environment",
		"Sandstorm (experimental)",
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

				_msg = ["SANDSTORM INCOMING!", "LIGHT SANDSTORM INCOMING!", "MEDIUM SANDSTORM INCOMING!", "HEAVY SANDSTORM INCOMING!"];
				_msg = _msg select _sand;
				[_msg] call Ares_fnc_ShowZeusMessage;

				// define the global sand parameter array
				//[fog,overcast,use ppEfx,allow rain,force wind,vary fog,use wind audio,EFX strength]
				[[0,"",true,false,true,true,true,_sand], "\7cmbgops\scripts\Sand_Snow_Init.sqf"] remoteExecCall ["BIS_fnc_execVM", 0, true];
			};
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Player",
		"PARA Jump",
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

			//get altitude
			_altitude = [4000, 6000, 9000, 11000, 13000];
			_altitude = _altitude select (_dialogResult select 0);

			//spawn plane
			params ["_pos"];
			_posx = _pos select 0;
			_posy = _pos select 1;
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

			//put players in plane
			{
				_x moveInCargo _plane;
			} foreach _haloplayers;

			waitUntil {sleep 1; (!alive _plane) or {((_plane distance (waypointPosition _waypoint)) < 5000)}};
			if (!alive _plane) exitWith {};

			_plane animateSource ["ramp", 0.65];
			_groupplane setSpeedMode "LIMITED";

			//delete plane after a while
			sleep 120;
			{
				_plane deleteVehicleCrew _x;
			} foreach _crewplane;
			deletevehicle _plane;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Rooftop Statics",
		{
			_dialogResult =
				[
					"Rooftop Statics Settings",
					[
						["Zone radius in meters", ""],
						["Static Type", ["Light", "Medium", "Heavy"]],
						["Max number of statics", ""],
						["SIDE", ["INDEPENDENTS", "EAST", "WEST"]]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};
			if (((_dialogResult select 0) isEqualTo "") || {((_dialogResult select 2) isEqualTo "")}) exitWith {["PLEASE ENTER SETTINGS."] call Ares_fnc_ShowZeusMessage;};

			_pos = _this select 0;
			_size = parseNumber(_dialogResult select 0);
			["rooftops", [_pos select 0, _pos select 1], "ELLIPSE", [_size, _size], "GLOBAL"] call CBA_fnc_createMarker;
			"rooftops" setMarkerAlpha 0;

			_side = _dialogResult select 3;
			if (_side isEqualTo 0) then {
				_side = RESISTANCE;
			} else {
				if (_side isEqualTo 1) then {
					_side = EAST;
				} else {
					_side = WEST;
				};
			};

			["rooftops", (_dialogResult select 1) + 1, parseNumber(_dialogResult select 2), true, "LOP_AFR_Infantry_Rifleman", _side] remoteExecCall ["seven_fnc_spawnRooftopStaticWeapons", 2, false];

			["Statics placed."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Environment",
		"Hurricane",
		{
			_dialogResult =
				[
					"Hurricane Settings",
					[
						["Direction in degrees", ""],
						["Duration in seconds", ""],
						["Throw objects", ["YES", "NO"]]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};
			if (((_dialogResult select 0) isEqualTo "") || {((_dialogResult select 1) isEqualTo "")}) exitWith {["PLEASE ENTER SETTINGS."] call Ares_fnc_ShowZeusMessage;};

			_throw = false;
			if ((_dialogResult select 2) isEqualTo 0) then {
				_throw = true;
			};

			[parseNumber(_dialogResult select 0), parseNumber(_dialogResult select 1), _throw] remoteExec ["seven_fnc_al_monsoon", 2, false];

			["HURRICANE INCOMING!"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Environment",
		"Tornado Start",
		{
			if !((getmarkerPos "start") isEqualto [0,0,0]) exitWith {["START POSITION ALREADY SET!"] call Ares_fnc_ShowZeusMessage;};
			params ["_pos"];
			["start", [_pos select 0, _pos select 1], "ELLIPSE", [0,0], "GLOBAL"] call CBA_fnc_createMarker;
			["NOW SET END POSITION"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Environment",
		"Tornado End",
		{
			if ((getmarkerPos "start") isEqualto [0,0,0]) exitWith {["SET START POSITION FIRST!"] call Ares_fnc_ShowZeusMessage;};
			params ["_pos"];
			["end", [_pos select 0, _pos select 1], "ELLIPSE", [0,0], "GLOBAL"] call CBA_fnc_createMarker;
			["start", "end"] remoteExec ["seven_fnc_al_tornado", 2, false];

			["TORNADO INCOMING!"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"Environment",
		"Dust Storm",
		{
			_dialogResult =
				[
					"Dust Storm Settings",
					[
						["Direction in degrees", ""],
						["Duration in seconds", ""],
						["Throw objects", ["YES", "NO"]],
						["Wall of Dust", ["YES", "NO"]]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult isEqualTo 0) exitWith {};
			if (((_dialogResult select 0) isEqualTo "") || {((_dialogResult select 1) isEqualTo "")}) exitWith {["PLEASE ENTER SETTINGS."] call Ares_fnc_ShowZeusMessage;};

			_throw = false;
			_wall = false;
			if ((_dialogResult select 2) isEqualTo 0) then {
				_throw = true;
			};
			if ((_dialogResult select 3) isEqualTo 0) then {
				_wall = true;
			};

			[parseNumber(_dialogResult select 0), parseNumber(_dialogResult select 1), _throw, _wall] remoteExec ["seven_fnc_al_duststorm", 2, false];

			["DUSTSTORM INCOMING!"] call Ares_fnc_ShowZeusMessage;
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
