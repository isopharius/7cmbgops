if (isdedicated) exitwith {};

	//ACE menu actions
	_arsenalbox = ["MCC_crateAmmo","B_CargoNet_01_ammo_F","B_supplyCrate_F","Land_PaperBox_closed_F","Land_PaperBox_open_full_F"];

	_satcom = ["satcom","SATCOM","\A3\ui_f\data\map\markers\military\destroy_CA.paa",{call seven_fnc_start_satellite},{(vehicle player != player) || ((backpack player) == "tf_rt1523g_big") || ((backpack player) == "tf_rt1523g_big_bwmod") || ((backpack player) == "tf_rt1523g_big_rhs")}] call ace_interact_menu_fnc_createAction;

	_taccom = ["taccom","TACCOM","\A3\ui_f\data\map\markers\flags\Canada_ca.paa",{CreateDialog "Spyder_TacticalCommandMain"},{(vehicle player != player) || ((backpack player) == "tf_rt1523g_big") || ((backpack player) == "tf_rt1523g_big_bwmod") || ((backpack player) == "tf_rt1523g_big_rhs")}] call ace_interact_menu_fnc_createAction;

	_halojump = ["halojump","Halo Jump","\A3\ui_f\data\map\markers\military\end_CA.paa",{call seven_fnc_halo},{(vehicle player == player) && (count (nearestObjects [player, ["Land_FieldToilet_F"], 15]) > 0)}] call ace_interact_menu_fnc_createAction;

	_fmradio = ["fmradio","Radio Play/Stop ","\7cmbgops\pics\i_carradio.paa",{[[(_this select 0)],"seven_fnc_fmradio",false,false,true] call BIS_fnc_MP;},{(vehicle player) == player}] call ace_interact_menu_fnc_createAction;
	_soultrain = ["soultrain","Soul Train","",{[] call seven_fnc_init360},{(vehicle player) == player}] call ace_interact_menu_fnc_createAction;

	_reqair = ["reqair","Request Air Mission","\a3\Modules_F_Curator\Data\portraitCASGunMissile_ca.paa",{[[],"seven_fnc_missionair",false,false,true] call BIS_fnc_MP;},{vehicle player != player}] call ace_interact_menu_fnc_createAction;
	_reqass = ["reqass","Request Assault Mission","\A3\ui_f\data\map\markers\military\objective_CA.paa",{[[],"seven_fnc_missionclear",false,false,true] call BIS_fnc_MP;},{vehicle player != player}] call ace_interact_menu_fnc_createAction;
	_reqsup = ["reqsup","Request Support Mission","\A3\ui_f\data\map\markers\military\join_CA.paa",{[[],"seven_fnc_missionsupport",false,false,true] call BIS_fnc_MP;},{vehicle player != player}] call ace_interact_menu_fnc_createAction;

	_cheston = ["cheston","Backpack to chest","\A3\ui_f\data\map\vehicleicons\iconBackpack_ca.paa",{0 spawn seven_fnc_FSFSV_CallBackpackToFront},{(((call seven_fnc_FSFSV_TestPlayerBackpackBack) > 0) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;
	_chestoff = ["chestoff","Backpack to back","\A3\ui_f\data\map\vehicleicons\iconBackpack_ca.paa",{0 spawn seven_fnc_FSFSV_CallBackpackToBack},{(((call seven_fnc_FSFSV_TestPlayerBackpackFront) > 0)  && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_arsenalcrate = ["arsenalcrate","Grab Arsenal","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{createVehicle ["B_CargoNet_01_ammo_F", (getPosworld player), [], 0, "can_collide"]},{count (nearestObjects [player, ["Land_Cargo10_military_green_F","Land_Cargo20_military_green_F","Land_Cargo40_military_green_F","B_Slingload_01_Ammo_F"], 15]) > 0}] call ace_interact_menu_fnc_createAction;

	_garage = ["garage","Requisition Vehicle","\A3\ui_f\data\map\vehicleicons\iconCrateVeh_ca.paa",{[("depot")] spawn seven_fnc_garageNew},{((vehicle player == player) && ((player distance (getmarkerpos "depot")) < 30) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_vehservice = ["vehservice","Service vehicle","\A3\ui_f\data\map\vehicleicons\pictureRepair_ca.paa",{[] spawn seven_fnc_rearmvehicle},{(((vehicle player) isKindOf "Car" || (vehicle player) isKindOf "Tank") && (!isEngineOn (vehicle player)) && (player distance (getmarkerpos "service") < 30) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_heloservice = ["heloservice","Service chopper","\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa",{[] spawn seven_fnc_rearmchopper},{(((vehicle player) isKindOf "Air") && (!isEngineOn (vehicle player)) && (count (nearestObjects [player, ["Land_repair_center","Heli_H","HeliH","Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F"], 15]) > 0) && (!visibleMap))}] call ace_interact_menu_fnc_createAction;

	_treat = ["treat","Treat yourself","\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa",{player action ["HealSoldierSelf", player]; player setDamage 0;},{(damage player)>0}] call ace_interact_menu_fnc_createAction;

	{
		["Land_FMradio_F", 0, ["ACE_MainActions"], _x] call ace_interact_menu_fnc_addActionToClass;
	} foreach [_fmradio,_soultrain];

	{
		[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _x] call ace_interact_menu_fnc_addActionToObject;
	} foreach [_cheston,_chestoff,_satcom,_taccom,_reqsup,_reqair,_reqass];

	{
		[player, 1, ["ACE_SelfActions"], _x] call ace_interact_menu_fnc_addActionToObject;
	} foreach [_vehservice,_heloservice,_garage,_arsenalcrate,_halojump];

	[player, 1, ["ACE_SelfActions", "Medical"], _treat] call ace_interact_menu_fnc_addActionToObject;
