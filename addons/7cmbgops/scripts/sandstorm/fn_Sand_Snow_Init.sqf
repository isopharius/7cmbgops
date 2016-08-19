/*
	m0nkey sand and snow EFX script
	v003 - 1/19/16

	to use:
	in init.sqf, on your condition of whether to use the sand EFX or not,
	define a global variable with parameters for the sand and snow EFX
	(see respective client scripts for syntax)

	examples:
	MKY_arSandEFX = [0,"",true,false,true,true,true,1];
	MKY_arSnowEFX = [[0.23,0.047,15],0.8,true];

	then, execute this script, like this
	nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";

	dedicated servers do not need MKY_arSandEFX/MKY_arSnowEFX arrays

	do NOT place in the initServer or initPlayerLocal files please

	here is a working example

	if (someVariable != 4) then {
		// define the global sand and snow parameter arrays
		MKY_arSandEFX = [0,"",true,false,true,true,true,1];
		MKY_arSnowEFX = [[0.23,0.047,15],0.8,true];
		// init the EFX scripts
		nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";
	};

*/

if (isHC) exitWith {};

// does the global data array exist?

if (isNil "arInfoWorld_MKY") then {
	call seven_fnc_getInfoWorld;
};

// only servers execute this
if (isServer) exitWith {
	if ((arInfoWorld_MKY select 0) isEqualTo "sand") then {call seven_fnc_Sand_Server;};
};

// any machine with an interface executes this
if (hasInterface) then {
	if ((arInfoWorld_MKY select 0) isEqualTo "sand") then {
		sleep 1;
		[_this] call seven_fnc_Sand_Client;
	};
};
