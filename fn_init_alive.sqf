if (isHC) exitwith {};

if(!isDedicated) then { //client admin menu
	["player",[SELF_INTERACTION_KEY],-9905,["call seven_fnc_adminMenuDef","main"]] call ALIVE_fnc_flexiMenu_Add;
};

/*
if (!isserver) exitwith {};

if (count (allMissionObjects "ALiVE_amb_civ_population") > 0) then {

	// civ weapon pools
	[ALIVE_civilianWeapons, "LOP_TAK_Civ", [["rhs_weap_makarov_pmm","rhs_mag_9x18_12_57N181S"],["rhs_weap_akms","rhs_30Rnd_762x39mm"],["rhs_weap_akm","rhs_30Rnd_762x39mm"]]] call ALIVE_fnc_hashSet;
	[ALIVE_civilianWeapons, "LOP_AFR_Civ", [["rhs_weap_makarov_pmm","rhs_mag_9x18_12_57N181S"],["rhs_weap_akms","rhs_30Rnd_762x39mm"],["rhs_weap_akm","rhs_30Rnd_762x39mm"]]] call ALIVE_fnc_hashSet;

	//-- Initialize Spyder Ambiance
	[true, true, 30, []] call seven_fnc_init_ambience;
};
*/

/* ---------------------------
SpyderAmbiance
Script Parameters:
	BOOL - Enable Animal Herds - Default: True
	BOOL - Enable Vehicles - Default: True
	SCALAR - Delay between checking to see if a zone should be activated/deactivated - Default: 20
	ARRAY - Blacklists of (rectangle or ellipse) markers that animal herds and vehicles shouldn't spawn in - Default: []
	BOOL - Enable Debug - Default: False
Example init.sqf lines
[] execVM "SpyderAmbiance\init.sqf";
[true, true, 30, []] execVM "SpyderAmbiance\init.sqf";
[true, false, 10, []] execVM "SpyderAmbiance\init.sqf";
[true, true, 15, ["BlacklistMarkerName"]] execVM "SpyderAmbiance\init.sqf";
[true, true, 25, [], true] execVM "SpyderAmbiance\init.sqf";
--------------------------- */
