if (isdedicated || isHC) exitwith {};

	//ACE menu actions
	_arsenalbox = ["MCC_crateAmmo","B_CargoNet_01_ammo_F","B_supplyCrate_F","Land_PaperBox_closed_F","Land_PaperBox_open_full_F"];

	_satcom = ["satcom","SATCOM","\A3\ui_f\data\map\markers\military\destroy_CA.paa",{call seven_fnc_start_satellite},{!(isNull objectParent player) || ((backpack player) == "tf_rt1523g_big") || ((backpack player) == "tf_rt1523g_big_bwmod") || ((backpack player) == "tf_rt1523g_big_rhs")}] call ace_interact_menu_fnc_createAction;

	_taccom = ["taccom","TACCOM","\A3\ui_f\data\map\markers\flags\Canada_ca.paa",{CreateDialog "Spyder_TacticalCommandMain"},{!(isNull objectParent player) || ((backpack player) == "tf_rt1523g_big") || ((backpack player) == "tf_rt1523g_big_bwmod") || ((backpack player) == "tf_rt1523g_big_rhs")}] call ace_interact_menu_fnc_createAction;

	_fmradio = ["fmradio","Radio Play/Stop","\7cmbgops\pics\i_carradio.paa",{[[(_this select 0)],"seven_fnc_fmradio",false,false,true] call BIS_fnc_MP;},{isNull objectParent player}] call ace_interact_menu_fnc_createAction;
	_soultrain = ["soultrain","Soul Train","",{[] call seven_fnc_init360},{(isNull objectParent player)}] call ace_interact_menu_fnc_createAction;

	_cheston = ["cheston","Backpack to chest","\A3\ui_f\data\map\vehicleicons\iconBackpack_ca.paa",{0 spawn seven_fnc_FSFSV_CallBackpackToFront},{(((call seven_fnc_FSFSV_TestPlayerBackpackBack) > 0) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;
	_chestoff = ["chestoff","Backpack to back","\A3\ui_f\data\map\vehicleicons\iconBackpack_ca.paa",{0 spawn seven_fnc_FSFSV_CallBackpackToBack},{(((call seven_fnc_FSFSV_TestPlayerBackpackFront) > 0)  && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_arsenalcrate = ["arsenalcrate","Grab Arsenal","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{createVehicle ["B_CargoNet_01_ammo_F", (getPosworld player), [], 0, "can_collide"]},{count (nearestObjects [player, ["Land_Cargo10_military_green_F","Land_Cargo20_military_green_F","Land_Cargo40_military_green_F","B_Slingload_01_Ammo_F"], 15]) > 0}] call ace_interact_menu_fnc_createAction;

	_garage = ["garage","Requisition Vehicle","\A3\ui_f\data\map\vehicleicons\iconCrateVeh_ca.paa",{[("depot")] spawn seven_fnc_garageNew},{((isNull objectParent player) && ((player distance (getmarkerpos "depot")) < 30) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_vehservice = ["vehservice","Service vehicle","\A3\ui_f\data\map\vehicleicons\pictureRepair_ca.paa",{[] spawn seven_fnc_rearmvehicle},{(((objectParent player) isKindOf "Car" || (objectParent player) isKindOf "Tank") && (!isEngineOn (objectParent player)) && (player distance (getmarkerpos "service") < 30) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_heloservice = ["heloservice","Service chopper","\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa",{[] spawn seven_fnc_rearmchopper},{(((objectParent player) isKindOf "Air") && (!isEngineOn (objectParent player)) && (count (nearestObjects [player, ["Land_repair_center","Heli_H","HeliH","Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F"], 15]) > 0) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_veharsenal = ["veharsenal","Load Arsenal","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{["B_CargoNet_01_ammo_F", (objectParent player)] call ace_cargo_fnc_loadItem; hint "Arsenal loaded";},{(((objectParent player) isKindOf "Car" || (objectParent player) isKindOf "Tank") && (!isEngineOn (objectParent player)) && (player distance (getmarkerpos "service") < 30) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_heloarsenal = ["heloarsenal","Load Arsenal","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{["B_CargoNet_01_ammo_F", (objectParent player)] call ace_cargo_fnc_loadItem; hint "Arsenal loaded";},{(((objectParent player) isKindOf "Air") && (!isEngineOn (objectParent player)) && (count (nearestObjects [player, ["Land_repair_center","Heli_H","HeliH","Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F"], 15]) > 0) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_heloradioin = ["heloradioin","Radio Play/Stop ","\7cmbgops\pics\i_carradio.paa",{[[(objectParent player)],"seven_fnc_fmradio",false,false,true] call BIS_fnc_MP;},{typeof (objectParent player) in ["ONS_Heli_CH146_Training_401_F","ONS_Heli_CH146_Training_402_F","ONS_Heli_CH146_PAX_405_F","ONS_Heli_CH146_PAX_407_F","ONS_Heli_CH146_PAX_409_F","ONS_Heli_CH146_PAX_412_F","ONS_Heli_CH146_SF_427_F","ONS_Heli_CH146_SF_430_F","ONS_Heli_CH146_MED_444_F","ONS_Heli_CH146_CAS_455_F","ONS_Heli_CH146_CAS_457_F","ONS_Heli_CH146_CAS_459_F","ONS_Heli_CH146_RECCE_494_F","ONS_Heli_CH146_RECCE_499_F"]}] call ace_interact_menu_fnc_createAction;

	_heloradioout = ["heloradioout","Radio Play/Stop","\7cmbgops\pics\i_carradio.paa",{[[(_this select 0)],"seven_fnc_fmradio",false,false,true] call BIS_fnc_MP;},{isNull objectParent player}] call ace_interact_menu_fnc_createAction;

	{
		[_x, 0, ["ACE_MainActions"], _heloradioout] call ace_interact_menu_fnc_addActionToClass;
	} foreach ["ONS_Heli_CH146_Training_401_F","ONS_Heli_CH146_Training_402_F","ONS_Heli_CH146_PAX_405_F","ONS_Heli_CH146_PAX_407_F","ONS_Heli_CH146_PAX_409_F","ONS_Heli_CH146_PAX_412_F","ONS_Heli_CH146_SF_427_F","ONS_Heli_CH146_SF_430_F","ONS_Heli_CH146_MED_444_F","ONS_Heli_CH146_CAS_455_F","ONS_Heli_CH146_CAS_457_F","ONS_Heli_CH146_CAS_459_F","ONS_Heli_CH146_RECCE_494_F","ONS_Heli_CH146_RECCE_499_F"];

	{
		["Land_FMradio_F", 0, ["ACE_MainActions"], _x] call ace_interact_menu_fnc_addActionToClass;
	} foreach [_fmradio,_soultrain];

	{
		[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _x] call ace_interact_menu_fnc_addActionToObject;
	} foreach [_cheston,_chestoff,_satcom,_taccom];

	{
		[player, 1, ["ACE_SelfActions"], _x] call ace_interact_menu_fnc_addActionToObject;
	} foreach [_vehservice,_veharsenal,_heloservice,_heloarsenal,_garage,_arsenalcrate,_heloradioin];
