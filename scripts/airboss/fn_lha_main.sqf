//LHD no guns
_lhd = _this select 0;
_pad = _this select 1;

//logistics
		lhd = _lhd;
		USEC_DebarkDialog="USEC_DebarkationControl";
		USEC_DebarkDisplay=50001;

		_lhdname = "USX Syed";
		LHAAlive = true;
		LHA_Bays = [[],[],[],[],[],[],[],[]];
		LHA_BayStatus = [true,true,true,true,true,true,true,true,true];
		LHA_BayRadius = 18;

		LHA_BayPositions = [[-13.5543,103.426,1],[13.5212,111.941,1],[13.5967,77.292,1],[-13.5216,61.5732,1],[-13.5376,20.1221,1],[-13.621,-21.5298,1],[-13.6259,-63.6804,1],[13.4215,-71.6892,1],[-13.5995,-100.681,1]];

		_pos = _pad modeltoworld [6.91016,-15.4805,0];
//respawn
if (isserver) then {
		[missionnamespace, [(_pos select 0), (_pos select 1), ((getposatl _lhd) select 2) + 1]] call BIS_fnc_addRespawnPosition;
};

	if (!isdedicated) then {
    	_controlroom = ["controlroom", _pos, "RECTANGLE", [5,9.5], "COLOR:", "ColorRed", "BRUSH:", "Border"] call CBA_fnc_createMarker;
    	_marker = ["lha", _pos, "ICON", [1,1], "COLOR:", "ColorBlue", "TYPE:", "respawn_naval", "TEXT:", "USX Syed"] call CBA_fnc_createMarker;
    	_marker setMarkerPos [(_pos select 0), (_pos select 1), ((getposatl _lhd) select 2) + 16.9];

    	["ship", (_pad modeltoworld [-0.662109,1.98828,0]), "RECTANGLE", [20,125], "COLOR:", "ColorBlack", "BRUSH:", "Border"] call CBA_fnc_createMarker;

    	["f", (_pad modeltoworld [1.63672,-10.0313,0]), "RECTANGLE", [0.2,30], "COLOR:", "ColorWhite"] call CBA_fnc_createMarker;

    	["f_1", (_pad modeltoworld [8.11523,-40.1367,0]), "RECTANGLE", [6.5,0.2], "COLOR:", "ColorWhite"] call CBA_fnc_createMarker;

    	["f_2", (_pad modeltoworld [14.6406,1.52344,0]), "RECTANGLE", [0.2,41.5], "COLOR:", "ColorWhite"] call CBA_fnc_createMarker;

    	["f_3", (_pad modeltoworld [6.5625,34.7734,0]), "RECTANGLE", [0.2,8], "COLOR:", "ColorWhite"] call CBA_fnc_createMarker;

    	["f_4", (_pad modeltoworld [10.6445,42.832,0]), "RECTANGLE", [4,0.2], "COLOR:", "ColorWhite"] call CBA_fnc_createMarker;

    	["f_5", (_pad modeltoworld [4.13672,23.3828,0]), "RECTANGLE", [0.2,4], "COLOR:", "ColorWhite"] call CBA_fnc_createMarker;
    	"f_5" setMarkerDir 35.7856;

    	["elevator", (_pad modeltoworld [-2.01953,10.043,0]), "RECTANGLE", [3.5,9], "COLOR:", "ColorGreen", "BRUSH:", "DiagGrid"] call CBA_fnc_createMarker;

    	["elevator_1", (_pad modeltoworld [-23.1621,-42.4648,0]), "RECTANGLE", [7,7], "COLOR:", "ColorBlack", "BRUSH:", "DiagGrid"] call CBA_fnc_createMarker;

    	["elevator_2", (_pad modeltoworld [23.2969,-90.6758,0]), "RECTANGLE", [8,8], "COLOR:", "ColorBlack", "BRUSH:", "DiagGrid"] call CBA_fnc_createMarker;

    	["in", (_pad modeltoworld [3.82031,-149.207,0]), "ICON", [0.5,0.5], "COLOR:", "ColorBlack", "TYPE:", "mil_arrow"] call CBA_fnc_createMarker;

    	["out", (_pad modeltoworld [-6.12891,-149.207,0]), "ICON", [0.5,0.5], "COLOR:", "ColorBlack", "TYPE:", "mil_arrow"] call CBA_fnc_createMarker;
    	"out" setMarkerDir 180;

    	["topstairs", (_pad modeltoworld [5.74219,34.8477,0]), "RECTANGLE", [1,7], "COLOR:", "ColorWhite"] call CBA_fnc_createMarker;

    	["topstairs_2", (_pad modeltoworld [9.43945,-6.84766,0]), "RECTANGLE", [1,1], "COLOR:", "ColorRed"] call CBA_fnc_createMarker;

    	["topstairs_3", (_pad modeltoworld [9.37305,-24.0469,0]), "RECTANGLE", [1,1], "COLOR:", "ColorRed"] call CBA_fnc_createMarker;

    	["topstairs_4", (_pad modeltoworld [4.15625,-39.3555,0]), "RECTANGLE", [2,1], "COLOR:", "ColorWhite"] call CBA_fnc_createMarker;

    	["midstairs", (_pad modeltoworld [-7.99609,18.0703,0]), "RECTANGLE", [2,1], "COLOR:", "ColorGreen"] call CBA_fnc_createMarker;

    	["midstairs_2", (_pad modeltoworld [3.85156,18,0]), "RECTANGLE", [2,1], "COLOR:", "ColorGreen"] call CBA_fnc_createMarker;

    	["midstairs_3", (_pad modeltoworld [-8.11914,-96.3594,0]), "RECTANGLE", [2,1], "COLOR:", "ColorCIV"] call CBA_fnc_createMarker;

    	["midstairs_4", (_pad modeltoworld [3.80469,-96.4297,0]), "RECTANGLE", [2,1], "COLOR:", "ColorCIV"] call CBA_fnc_createMarker;

    	["lowstairs", (_pad modeltoworld [-8.63672,-5.20703,0]), "RECTANGLE", [1,1], "COLOR:", "ColorBlue"] call CBA_fnc_createMarker;

    	["lowstairs_2", (_pad modeltoworld [9.37305,-13.7422,0]), "RECTANGLE", [1,1], "COLOR:", "ColorBlue"] call CBA_fnc_createMarker;

    	["lowstairs_3", (_pad modeltoworld [9.41211,-19.0938,0]), "RECTANGLE", [1,1], "COLOR:", "ColorBlue"] call CBA_fnc_createMarker;


	//controlroom
		_pos = getmarkerpos "controlroom";
		_crate = "B_CargoNet_01_ammo_F" createvehiclelocal [(_pos select 0) - 1, (_pos select 1) - 1];
		_crate allowdamage false;
		_cratepos = getpos _crate;
		_crate setposasl [_cratepos select 0, _cratepos select 1, 16.9];

		lhd_controlroom = createLocation ["NameLocal", _pos, 5, 9.5];
		lhd_controlroom setRectangular true;

		_lhdcontrol = ["lhdcontrol","Logistics Control","",{[] spawn seven_fnc_lha_ui_debarkationControl},{position player in lhd_controlroom}] call ace_interact_menu_fnc_createAction;

		[player, 1, ["ACE_SelfActions"], _lhdcontrol] call ace_interact_menu_fnc_addActionToObject;

	//stairs
		lhd_topstairs = createLocation ["NameLocal", [(getmarkerpos "topstairs") select 0, (getmarkerpos "topstairs") select 1], 2, 14];
		lhd_topstairs setRectangular true;

		lhd_topstairs_2 = createLocation ["NameLocal", [(getmarkerpos "topstairs_2") select 0, (getmarkerpos "topstairs_2") select 1], 2, 2];
		lhd_topstairs_2 setRectangular true;

		lhd_topstairs_3 = createLocation ["NameLocal", [(getmarkerpos "topstairs_3") select 0, (getmarkerpos "topstairs_3") select 1], 2, 2];
		lhd_topstairs_3 setRectangular true;

		lhd_topstairs_4 = createLocation ["NameLocal", [(getmarkerpos "topstairs_4") select 0, (getmarkerpos "topstairs_4") select 1], 4, 2];
		lhd_topstairs_4 setRectangular true;

		lhd_midstairs = createLocation ["NameLocal", [(getmarkerpos "midstairs") select 0, (getmarkerpos "midstairs") select 1], 4, 2];
		lhd_midstairs setRectangular true;

		lhd_midstairs_2 = createLocation ["NameLocal", [(getmarkerpos "midstairs_2") select 0, (getmarkerpos "midstairs_2") select 1], 4, 2];
		lhd_midstairs_2 setRectangular true;

		lhd_midstairs_3 = createLocation ["NameLocal", [(getmarkerpos "midstairs_3") select 0, (getmarkerpos "midstairs_3") select 1], 4, 2];
		lhd_midstairs_3 setRectangular true;

		lhd_midstairs_4 = createLocation ["NameLocal", [(getmarkerpos "midstairs_4") select 0, (getmarkerpos "midstairs_4") select 1], 4, 2];
		lhd_midstairs_4 setRectangular true;

		lhd_lowstairs = createLocation ["NameLocal", [(getmarkerpos "lowstairs") select 0, (getmarkerpos "lowstairs") select 1], 2, 2];
		lhd_lowstairs setRectangular true;

		lhd_lowstairs_2 = createLocation ["NameLocal", [(getmarkerpos "lowstairs_2") select 0, (getmarkerpos "lowstairs_2") select 1], 2, 2];
		lhd_lowstairs_2 setRectangular true;

		lhd_lowstairs_3 = createLocation ["NameLocal", [(getmarkerpos "lowstairs_3") select 0, (getmarkerpos "lowstairs_3") select 1], 2, 2];
		lhd_lowstairs_3 setRectangular true;

		_flightstairs = ["flightstairs","Stairs to Flight Deck","",{player setPosasl [(getmarkerpos "topstairs") select 0, (getmarkerpos "topstairs") select 1, 16.5]},{(position player in lhd_midstairs) or (position player in lhd_lowstairs)}] call ace_interact_menu_fnc_createAction;

		_flightstairs_2 = ["flightstairs_2","Stairs to Flight Deck","",{player setPosasl [(getmarkerpos "topstairs_2") select 0, (getmarkerpos "topstairs_2") select 1, 16.5]},{(position player in lhd_midstairs_2) or (position player in lhd_lowstairs_2)}] call ace_interact_menu_fnc_createAction;

		_flightstairs_3 = ["flightstairs_3","Stairs to Flight Deck","",{player setPosasl [(getmarkerpos "topstairs_3") select 0, (getmarkerpos "topstairs_3") select 1, 16.5]},{(position player in lhd_midstairs_3) or (position player in lhd_lowstairs_3)}] call ace_interact_menu_fnc_createAction;

		_flightstairs_4 = ["flightstairs_4","Stairs to Flight Deck","",{player setPosasl [(getmarkerpos "topstairs_4") select 0, (getmarkerpos "topstairs_4") select 1, 16.5]},{(position player in lhd_midstairs_4)}] call ace_interact_menu_fnc_createAction;

		_cargostairs = ["cargostairs","Stairs to Cargo Deck","",{player setPosasl [(getmarkerpos "midstairs") select 0, (getmarkerpos "midstairs") select 1, 9.9]},{(position player in lhd_lowstairs) or (position player in lhd_topstairs)}] call ace_interact_menu_fnc_createAction;

		_cargostairs_2 = ["cargostairs_2","Stairs to Cargo Deck","",{player setPosasl [(getmarkerpos "midstairs_2") select 0, (getmarkerpos "midstairs_2") select 1, 9.9]},{(position player in lhd_lowstairs_2) or (position player in lhd_topstairs_2)}] call ace_interact_menu_fnc_createAction;

		_cargostairs_3 = ["cargostairs_3","Stairs to Cargo Deck","",{player setPosasl [(getmarkerpos "midstairs_3") select 0, (getmarkerpos "midstairs_3") select 1, 7.8]},{(position player in lhd_lowstairs_3) or (position player in lhd_topstairs_3)}] call ace_interact_menu_fnc_createAction;

		_cargostairs_4 = ["cargostairs_4","Stairs to Cargo Deck","",{player setPosasl [(getmarkerpos "midstairs_4") select 0, (getmarkerpos "midstairs_4") select 1, 7.8]},{(position player in lhd_topstairs_4)}] call ace_interact_menu_fnc_createAction;

		_wellstairs = ["wellstairs","Stairs to Well Dock","",{player setPosasl [(getmarkerpos "lowstairs") select 0, (getmarkerpos "lowstairs") select 1, 2]},{(position player in lhd_midstairs) or (position player in lhd_topstairs)}] call ace_interact_menu_fnc_createAction;

		_wellstairs_2 = ["wellstairs_2","Stairs to Well Dock","",{player setPosasl [(getmarkerpos "lowstairs_2") select 0, (getmarkerpos "lowstairs_2") select 1, 2]},{(position player in lhd_midstairs_2) or (position player in lhd_topstairs_2)}] call ace_interact_menu_fnc_createAction;

		_wellstairs_3 = ["wellstairs_3","Stairs to Well Dock","",{player setPosasl [(getmarkerpos "lowstairs_3") select 0, (getmarkerpos "lowstairs_3") select 1, 2]},{(position player in lhd_midstairs_3) or (position player in lhd_topstairs_3) or (position player in lhd_midstairs_4) or (position player in lhd_topstairs_4)}] call ace_interact_menu_fnc_createAction;

		{
			[player, 1, ["ACE_SelfActions"], _x] call ace_interact_menu_fnc_addActionToObject;
		} foreach [_flightstairs,_flightstairs_2,_flightstairs_3,_flightstairs_4,_cargostairs,_cargostairs_2,_cargostairs_3,_cargostairs_4,_wellstairs,_wellstairs_2,_wellstairs_3];
	};

	//supplies
		LHA_SelectedBay = 1;
		_vh_air = [
			"ons_cv122_transport",
			"ONS_AIR_CH147_307",
			"RHS_CH_47F",
			"ONS_CH148_TW_810",
			"ONS_Heli_CH146_CAS_455_F",
			"ONS_Heli_CH146_CAS_457_F",
			"ONS_Heli_CH146_CAS_459_F",
			"ONS_Heli_CH146_MED_444_F",
			"ONS_Heli_CH146_PAX_405_F",
			"ONS_Heli_CH146_PAX_407_F",
			"ONS_Heli_CH146_PAX_409_F",
			"ONS_Heli_CH146_PAX_412_F",
			"ONS_Heli_CH146_RECCE_494_F",
			"ONS_Heli_CH146_RECCE_499_F",
			"ONS_Heli_CH146_SF_430_F",
			"ONS_Heli_CH146_SF_427_F",
			"ONS_Heli_CH146_Training_401_F",
			"ONS_Heli_CH146_Training_402_F",
			"B_Heli_Light_01_F",
			"B_Heli_Light_01_armed_F"
		];
		_vh_land = [
			"B_Truck_01_transport_F",
			"B_Truck_01_medical_F",
			"B_MRAP_01_F",
			"rhsusf_m113_usarmy",
			"rhsusf_m1025_w_s",
			"rhsusf_m1025_w_s_m2",
			"rhsusf_m1025_w_s_mk19",
			"ons_apc_wheeled_01",
			"ons_apc_wheeled_01_TW",
			"rhsusf_rg33_m2_d",
			"rhsusf_rg33_m2_usmc_d",
			"ONS_LAV2_Coyote_DFS_F",
			"ONS_lav3_isc_F"
		];
		_vh_crates = [
			"B_Slingload_01_Ammo_F",
			"B_Slingload_01_Repair_F",
			"B_Slingload_01_Fuel_F",
			"Box_NATO_AmmoVeh_F",
			"B_supplyCrate_F",
			"B_CargoNet_01_ammo_F",
			"CargoNet_01_box_F",
			"CargoNet_01_barrels_F",
			"Land_Pod_Heli_Transport_04_bench_F",
			"Land_Cargo10_military_green_F",
			"Land_Cargo20_military_green_F",
			"Land_Cargo40_military_green_F"
		];
		LHA_SpawnableVehicles = _vh_air + _vh_land + _vh_crates;

	LHA_SelectedBay = 0;
	LHA_ActiveObject = player;