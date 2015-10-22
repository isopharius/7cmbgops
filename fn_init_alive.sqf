if(!isDedicated) then { //client admin menu
	["player",[SELF_INTERACTION_KEY],-9905,["call seven_fnc_adminMenuDef","main"]] call ALIVE_fnc_flexiMenu_Add;
};

// civ weapon pools
[ALIVE_civilianWeapons, "LOP_TAK_Civ", [["rhs_weap_makarov_pmm","rhs_mag_9x18_12_57N181S"],["rhs_weap_akms","rhs_30Rnd_762x39mm"],["rhs_weap_akm","rhs_30Rnd_762x39mm"]]] call ALIVE_fnc_hashSet;
[ALIVE_civilianWeapons, "LOP_AFR_Civ", [["rhs_weap_makarov_pmm","rhs_mag_9x18_12_57N181S"],["rhs_weap_akms","rhs_30Rnd_762x39mm"],["rhs_weap_akm","rhs_30Rnd_762x39mm"]]] call ALIVE_fnc_hashSet;
