if (!hasInterface && !isDedicated) exitwith {
  if (isnil "headlessClients") then {
  	headlessClients = [];
  };
  headlessClients pushBack player;
  publicVariable "headlessClients";
  isHC = true;
};

tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;
tf_no_auto_long_range_radio = true;

if (isserver) then {
	smallcamps = ["mediumMGCamp1","mediumMGCamp2","mediumMGCamp3","mediumMilitaryCamp1","smallMilitaryCamp1","mediumMilitaryOutpost1"];
	mediumcaps = [];
	largecamps = [];
};

if (hasInterface) then {
	["player",[SELF_INTERACTION_KEY],-9905,["call seven_fnc_adminMenuDef","main"]] call ALIVE_fnc_flexiMenu_Add;
};


// player init
/*
if (!isdedicated) exitwith {

	if (worldName in ["Altis", "Stratis", "Atlantis", "Pandora","Chernarus_Summer"]) then {
		{
			[west, _x] call BIS_fnc_addRespawnInventory;
		} foreach ["ONS_TW1","ONS_TW2","ONS_TW3","ONS_TW4","ONS_TW5","ONS_TW6","ONS_TW7"];
	} else {
		{
			[west, _x] call BIS_fnc_addRespawnInventory;
		} foreach ["ONS_AR1","ONS_AR2","ONS_AR3","ONS_AR4","ONS_AR5","ONS_AR6","ONS_AR7"];
	};
};
*/