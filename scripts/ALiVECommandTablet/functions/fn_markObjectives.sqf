/*------------------------------------------------------------------
STC_fnc_markObjectives

Call using:
["client"] spawn STC_fnc_markObjectives;

Filters:
Orders - colors objectives based on opcoms current stance with that objective

Author: SpyderBlack723
------------------------------------------------------------------*/

params ["_locality",["_arguments",nil]];

switch (toLower (_locality)) do {

	case "client": {

		//-- Check if markers are already being displayed
		if (!isNil {player getVariable "STCObjectiveMarkers"}) exitWith {
			{deleteMarkerLocal _x} forEach (player getVariable "STCObjectiveMarkers");
			player setVariable ["STCObjectiveMarkers", nil];
		};

		//-- Use the previously defined STCObjectives (Stays defined for 20 seconds) to avoid spamming the server when toggling repeatedly
		if (isNil "STCObjectives") then {
			[[["server",player],{
				[(_this select 0),[_this select 1]] call STC_fnc_markObjectives;
			}],"BIS_fnc_spawn",false,true] call BIS_fnc_MP;
		};

		//-- Wait for response, exit if failed
		waitUntil {sleep .5;!isNil "STCObjectives" or {player getVariable "exitOperation"}};
		if (player getVariable "exitOperation") exitWith {hint "There was an issue, please ensure ALiVE is running, their is an OPCOM module placed, and that your command has viable objectives to analyze";player setVariable ["exitOperation",false]};

		//-- create markers
		_markers = [];
		_randomNum = (count STCObjectives) * .5;	//-- Execute outside of loop so operation only runs once
		{
			//-- Extract data and create marker
			_data = _x;
			_data params ["_size","_position","_orders"];
			_marker = createMarkerLocal [(format ["%1", random _randomNum]), _position];
			_marker setMarkerType "Empty";
			_marker setMarkerShapeLocal "RECTANGLE";
			_marker setMarkerBrushLocal "BDiagonal";
			_marker setMarkerSizeLocal [_size, _size];
			_marker setMarkerAlphaLocal 0.8;


			//-- Orders
			switch (_orders) do {
				case "unassigned": {_marker setMarkerColorLocal "ColorWhite"};
				case "idle": {_marker setMarkerColorLocal "ColorYellow"};
				case "reserve": {_marker setMarkerColorLocal "ColorGreen"};
				case "defend": {_marker setMarkerColorLocal "ColorBlue"};
				case "attack": {_marker setMarkerColorLocal "ColorRed"};
				default {_marker setMarkerColorLocal "ColorWhite"};
			};
		_markers pushBack _marker;
		} forEach STCObjectives;

		//--Attach markers to player (for toggle purposes >> see top of file)
		player setVariable ["STCObjectiveMarkers", _markers];

		//-- Keep variable defined for 20 seconds to avoid spamming server when toggling repeatedly (see above for implementation)
		sleep 20;
		STCObjectives = nil;
	};

	case "server": {

		_arguments params ["_player"];
		_returnTo = owner _player;

		//-- Exit if ALiVE is not running or they're are no opcoms
		if (isNil "ALIVE_profileHandler") exitWith {_player setVariable ["exitOperation", true]};
		if (isNil "OPCOM_INSTANCES") exitWith {_player setVariable ["exitOperation", true]};

		//-- Get objectives of player faction OPCOM
		_objectiveData = [];
		{
			_opcom = _x;
			_opcomFactions = [_opcom,"factions",""] call ALiVE_fnc_HashGet;
			if (faction _player in _opcomFactions) then {
				{
					_objective = _x;
					_size = [_objective,"size",150] call CBA_fnc_HashGet;
					_position = [_objective,"center",[]] call CBA_fnc_HashGet;
					_orders = [_objective,"opcom_state","unassigned"] call ALiVE_fnc_HashGet;
					_objectiveData pushBack [_size,_position,_orders];
				} forEach ([_opcom,"objectives",[]] call ALiVE_fnc_HashGet);
			};
		} foreach OPCOM_INSTANCES;

		//-- Exit if no data
		if (count _objectiveData == 0) exitWith {_player setVariable ["exitOperation", true]};

		//-- initialize it all at once (otherwise the waitUntil will activate once array is defined as [] in SP)
		STCObjectives = _objectiveData;

		//-- Return to client if executed in multiplayer
		if (isMultiplayer) then {
			_returnTo publicVariableClient "STCObjectives";
		};

	};

};