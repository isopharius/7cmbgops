[] spawn seven_fnc_WerthlesHeadless;

if (isHC) exitwith {};

FSFSV_cacheObjet = compileFinal "(_this select 0) hideObject (_this select 1);";

if (isserver) then {
	LT_distance = 20;
	smallcamps = ["mediumMGCamp1","mediumMGCamp2","mediumMGCamp3","mediumMilitaryCamp1","smallMilitaryCamp1","mediumMilitaryOutpost1"];
	mediumcaps = [];
	largecamps = [];
};

// player/server init
if(!isDedicated) then {
/*
	player addEventHandler ["InventoryClosed", {
		_mrzr = _this select 1;
		if (((typeof _mrzr) == "ONS_MRZR_base") || ((typeof _mrzr) == "ONS_MRZR_base")) then {
			_mrzr call seven_fnc_attachmrzr;
		};
	}];
*/
	if (worldName in ["Altis", "Stratis", "Atlantis", "Pandora"]) then {
		{
			[west, _x] call BIS_fnc_addRespawnInventory;
		} foreach ["TW1","TW2","TW3","TW4","TW5","TW6","TW7"];
	} else {
		{
			[west, _x] call BIS_fnc_addRespawnInventory;
		} foreach ["AR1","AR2","AR3","AR4","AR5","AR6","AR7"];
	};

	#include "\7cmbgops\scripts\SHK_Fastrope.sqf"
};

//cargodrop
rhs_fnc_cargoAttach = compile preprocessFileLineNumbers "\7cmbgops\functions\cargo_attach.sqf";
rhs_fnc_vehPara = compile preprocessFileLineNumbers "\7cmbgops\functions\vehPara.sqf";