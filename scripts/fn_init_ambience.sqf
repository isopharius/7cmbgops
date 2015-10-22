//-- Only run on server
if (!isServer) exitWith {};

params [
	["_animals", true],
	["_terrorists", true],
	["_delay", 20],
	["_blacklists", []],
	["_debug", false]
];

if (isMultiplayer) then {_debug = false};

//-- Debug
if (_debug) then {
	["Spyder Ambiance: init started"] call ALIVE_fnc_dumpR;
	SpyderAmbiance_Debug = true;
};

//-- Initialize unit types
[_debug] call seven_fnc_getUnitTypes;

//-- Activate loop
[_animals,_terrorists,_delay,_blacklists,_debug] call seven_fnc_loopCheck;

//-- Debug
if (_debug) then {
	["Spyder Ambiance: init finished"] call ALIVE_fnc_dumpR;
};
