params ["_locality",["_arguments",nil]];

switch (_locality) do {
	case "client": {

		//-- Check if markers are already being displayed
		if (!isNil {player getVariable "STCUnitMarkers"}) exitWith {
			{deleteMarkerLocal _x} forEach (player getVariable "STCUnitMarkers");
			player setVariable ["STCUnitMarkers", nil];
		};

		//-- Use the previously defined STCUnits (Stays defined for 20 seconds) to avoid spamming the server when toggling repeatedly
		if (isNil "STCUnits") then {
			[[["server",player],{
				[(_this select 0),[_this select 1]] call STC_fnc_markUnits;
			}],"BIS_fnc_spawn",false,true] call BIS_fnc_MP;
		};

		//-- Wait for response, exit if failed
		waitUntil {sleep .5;!isNil "STCUnits" or {player getVariable "exitOperation"}};
		if (player getVariable "exitOperation") exitWith {hint "Either ALiVE is not currently running or there are no groups to mark";player setVariable ["exitOperation",false]};

		//-- create markers
		_markers = [];
		{
			_marker = createMarkerLocal [str (_x select 0), _x select 0];
			_marker setMarkerTypeLocal "o_unknown";
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerSizeLocal [.9, .9];
			_marker setMarkerBrushLocal "Solid";

			switch (_x select 1) do {
				case "WEST": {_marker setMarkerColorLocal "ColorBlue"};
				case "EAST": {_marker setMarkerColorLocal "ColorRed"};
				case "GUER": {_marker setMarkerColorLocal "ColorGreen"};
				default {_marker setMarkerColorLocal "ColorPurple"};
			};

			_markers pushback _marker;
		} forEach STCUnits;

		player setVariable ["STCUnitMarkers", _markers];

		//-- Keep variable defined for 20 seconds to avoid spamming server when toggling repeatedly (see above for implementation)
		sleep 20;
		STCUnits = nil;
	};

	case "server": {

		_arguments params ["_player"];
		_returnTo = owner _player;

		//-- Exit if ALiVE is not running or they're are no opcoms
		if (isNil "ALIVE_profileHandler") exitWith {_player setVariable ["exitOperation", true]};

		_profiles = [ALIVE_profileHandler, "getProfilesBySide", str side _player] call ALIVE_fnc_profileHandler;
		_unitData = [];

		{
			_profile = [ALIVE_profileHandler, "getProfile",_x] call ALIVE_fnc_profileHandler;

			if !([_profile,"isPlayer",false] call ALIVE_fnc_hashGet) then {
				_position = [_profile,"position"] call ALIVE_fnc_hashGet;
				_side = [_profile,"side"] call ALIVE_fnc_hashGet;
				_unitData pushBack [_position,_side];
			};
		} forEach _profiles;

		//-- Exit if no data
		if (count _unitData == 0) exitWith {_player setVariable ["exitOperation", true]};

		//-- initialize it all at once (otherwise the waitUntil will activate once array is defined as [] in SP)
		STCUnits = _unitData;

		//-- Return to client if executed in multiplayer
		if (isMultiplayer) then {
			_returnTo publicVariableClient "STCUnits";
		};
	};
};