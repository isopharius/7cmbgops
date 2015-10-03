/*
  _____
  \_   \_ __  ___ _   _ _ __ __ _  ___ _ __   ___ _   _
   / /\/ '_ \/ __| | | | '__/ _` |/ _ \ '_ \ / __| | | |
/\/ /_ | | | \__ \ |_| | | | (_| |  __/ | | | (__| |_| |
\____/ |_| |_|___/\__,_|_|  \__, |\___|_| |_|\___|\__, |
                            |___/                 |___/

@filename: init.sqf

Author:

	Hazey

Special Thanks:

	Highhead
	ARJay

Last modified:

	2/11/2015

Description:

	Main Init - Starts and runs things.
______________________________________________________*/

//--- Start Init
["Insurgency INIT START..."] call ALiVE_fnc_Dump;

insurgency = true;

// ====================================================================================
	//--- DEFINES/ INCLUDES
	[] call seven_fnc_common_defines;
// ====================================================================================

if (isServer) then {
	_null = [] spawn seven_fnc_CallToPrayer;
	_null = [] spawn seven_fnc_SpawnIntel;
	_null = [] spawn seven_fnc_setupCache;
};

//--- Game Briefing
[] call seven_fnc_ins_briefing;

["Insurgency INIT END..."] call ALiVE_fnc_Dump;