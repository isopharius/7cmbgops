if (hasInterface) then {

	_arsenalbox = ["B_CargoNet_01_ammo_F","B_supplyCrate_F","Land_PaperBox_closed_F","Land_PaperBox_open_full_F"];

	//ACE menu actions
	_groupname = [
		"groupname",
		"Change CallSign",
		"\7cmbgops\pics\i_carradio.paa",
		{
			_grp = group player;
			_dialogResult =
				[
					format ["Change current CallSign [%1] (for cTab)", groupId _grp],
					[
						["New CallSign", ""]
					]
				] call Ares_fnc_ShowChooseDialog;

			if ((count _dialogResult isEqualTo 0) or {((_dialogResult select 0) isEqualTo "")}) then {
				hint "CallSign not changed.";

			} else {
				_callsign = _dialogResult select 0;
				_grp = group player;
				_grp setGroupIdGlobal [_callsign];
				format["New CallSign [%1]", _callsign] remoteExecCall ["hint", _grp, false];
			};
		},
		{
			(leader player) isEqualTo player;
		}
	] call ace_interact_menu_fnc_createAction;

	_satcom = [
		"satcom",
		"SATCOM",
		"\A3\ui_f\data\map\markers\military\destroy_CA.paa",
		{
			satclick = addMissionEventHandler [
			    "MapSingleClick",
			    {
            		removeMissionEventHandler ["MapSingleClick", satclick];
            		//_pos = _this select 1;
			        //if ((player distance _pos) < 5000) then {
			            PXS_SatelliteTarget = "Logic" createVehicleLocal (_this select 1);
			            PXS_SatelliteTarget setDir 0;
			            [] spawn seven_fnc_init_satellite;
			            openMap false;
			        //} else {
			        //    hint "Satellite viewrange is limited to a 10 kilometers radius!";
			        //};
			    }
			];
			hint "Click on the map to insert default satellite coordinates.";
			openMap true;
		},
		{
			"ItemcTab" in (items player + assignedItems player);
		}
	] call ace_interact_menu_fnc_createAction;

	_arty = [
		"arty",
		"Artillery Console",
		"\A3\ui_f\data\map\markers\military\destroy_CA.paa",
		{
			if (!(dtaReady) or (time < 4)) exitWith {hint "DTA starting, please wait..."};
			if (dtaLastDialog isEqualTo "Assets") then {
				[] spawn seven_fnc_Assets;
			} else {
				if (dtaLastDialog isEqualTo "Control") then {
				[false] spawn seven_fnc_Control;
				};
			};
		},
		{
			"ItemcTab" in (items player + assignedItems player);
		}
	] call ace_interact_menu_fnc_createAction;


	//_nradio = ["nradio","WALKMAN","\7cmbgops\pics\i_carradio.paa",{call seven_fnc_start},{true}] call ace_interact_menu_fnc_createAction;

	_fmradio = ["fmradio","Radio Play/Stop","\7cmbgops\pics\i_carradio.paa",{(_this select 0) remoteExec ["seven_fnc_fmradio", 2, false]},{isNull objectParent player}] call ace_interact_menu_fnc_createAction;
	_soultrain = ["soultrain","Soul Train","",{call seven_fnc_init360},{(isNull objectParent player)}] call ace_interact_menu_fnc_createAction;

	_arsenalcrate = ["arsenalcrate","Grab Arsenal","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{createVehicle ["B_CargoNet_01_ammo_F", (getPosworld player), [], 0, "can_collide"]},{count (nearestObjects [player, ["Land_Cargo10_military_green_F","Land_Cargo20_military_green_F","Land_Cargo40_military_green_F","B_Slingload_01_Ammo_F"], 15]) > 0}] call ace_interact_menu_fnc_createAction;

	_garage = ["garage","Requisition Vehicle","\A3\ui_f\data\map\vehicleicons\iconCrateVeh_ca.paa",{[("depot")] spawn seven_fnc_garageNew},{((isNull objectParent player) and {((player distance (getmarkerpos "depot")) < 30)} and {(!visibleMap)})}] call ace_interact_menu_fnc_createAction;

	_vehservice = ["vehservice","Service vehicle","\A3\ui_f\data\map\vehicleicons\pictureRepair_ca.paa",{[] spawn seven_fnc_rearmvehicle},{(((objectParent player) isKindOf "LandVehicle") and {(!isEngineOn (objectParent player))} and {(player distance (getmarkerpos "service") < 30)} and {(!visibleMap)})}] call ace_interact_menu_fnc_createAction;

	_heloservice = ["heloservice","Service chopper","\A3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa",{[] spawn seven_fnc_rearmchopper},{(((objectParent player) isKindOf "Air") and {(!isEngineOn (objectParent player))} and {(count (nearestObjects [player, ["Land_repair_center","Heli_H","HeliH","Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F"], 15]) > 0)} and {(!visibleMap)})}] call ace_interact_menu_fnc_createAction;

	_veharsenal = ["veharsenal","Load Arsenal","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{["B_CargoNet_01_ammo_F", (objectParent player)] call ace_cargo_fnc_loadItem; hint "Arsenal loaded";},{(((objectParent player) isKindOf "LandVehicle") and {(!isEngineOn (objectParent player))} && {(player distance (getmarkerpos "service") < 30)} and {(!visibleMap)})}] call ace_interact_menu_fnc_createAction;

	_heloarsenal = ["heloarsenal","Load Arsenal","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{["B_CargoNet_01_ammo_F", (objectParent player)] call ace_cargo_fnc_loadItem; hint "Arsenal loaded";},{(((objectParent player) isKindOf "Helicopter") and {(!isEngineOn (objectParent player))} and {(count (nearestObjects [player, ["Land_repair_center","Heli_H","HeliH","Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F"], 15]) > 0)} and {(!visibleMap)})}] call ace_interact_menu_fnc_createAction;

	_heloradioin = ["heloradioin","Radio Play/Stop","\7cmbgops\pics\i_carradio.paa",{(objectParent player) remoteExec ["seven_fnc_fmradio", 2, false]},{(objectParent player) isKindOf "Helicopter"}] call ace_interact_menu_fnc_createAction;

	_heloradioout = ["heloradioout","Radio Play/Stop","\7cmbgops\pics\i_carradio.paa",{(_this select 0) remoteExec ["seven_fnc_fmradio", 2, false]},{isNull objectParent player}] call ace_interact_menu_fnc_createAction;

	{
		[_x, 0, ["ACE_MainActions"], _heloradioout] call ace_interact_menu_fnc_addActionToClass;
	} foreach ["ONS_Heli_CH146_Training_401_F","ONS_Heli_CH146_Training_402_F","ONS_Heli_CH146_PAX_405_F","ONS_Heli_CH146_PAX_407_F","ONS_Heli_CH146_PAX_409_F","ONS_Heli_CH146_PAX_412_F","ONS_Heli_CH146_SF_427_F","ONS_Heli_CH146_SF_430_F","ONS_Heli_CH146_MED_444_F","ONS_Heli_CH146_CAS_455_F","ONS_Heli_CH146_CAS_457_F","ONS_Heli_CH146_CAS_459_F","ONS_Heli_CH146_RECCE_494_F","ONS_Heli_CH146_RECCE_499_F"];

	{
		["Land_FMradio_F", 0, ["ACE_MainActions"], _x] call ace_interact_menu_fnc_addActionToClass;
	} foreach [_fmradio, _soultrain];

	{
		[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _x] call ace_interact_menu_fnc_addActionToObject;
	} foreach [_satcom, _arty/*, _nradio*/];

	[player, 1, ["ACE_SelfActions", "ACE_TeamManagement"], _groupname] call ace_interact_menu_fnc_addActionToObject;

	{
		[player, 1, ["ACE_SelfActions"], _x] call ace_interact_menu_fnc_addActionToObject;
	} foreach [_vehservice,_veharsenal,_heloservice,_heloarsenal,_garage,_arsenalcrate,_heloradioin];
};
