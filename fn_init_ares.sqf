if (isHC) exitwith {};

MCC_fn_loadZones =
{
	private ["_zonesArray","_zonesNumber","_zonesPos","_zonesSize","_zonesDir","_zonesLocation","_size"];
	_zonesArray 	= _this select 0;
	_zonesNumber	= _zonesArray select 0;
	_zonesPos		= _zonesArray select 1;
	_zonesSize		= _zonesArray select 2;
	_zonesDir		= _zonesArray select 3;
	_zonesLocation	= _zonesArray select 4;

	//Create the Zones
	{
		mcc_zone_markposition 	= _zonesPos select _x;
		mcc_zone_number			= _x;
		mcc_zone_marker_X		= (_zonesSize select _x) select 0;
		mcc_zone_marker_Y		= (_zonesSize select _x) select 1;
		mcc_zone_markername		= str _x;
		mcc_hc					= _zonesLocation select _x;
		MCC_Marker_dir 			= _zonesDir select _x;

		diag_log format["Zone Created: %1 - %2",_x, mcc_zone_markposition];
		script_handler = [0] execVM MCC_path +"mcc\general_scripts\mcc_make_the_marker.sqf";
		waitUntil {str(getMarkerPos mcc_zone_markername) != "[0,0,0]"};

		sleep 1;
		mcc_zone_markername setMarkerColorLocal "colorBlack";
		mcc_zone_markername setMarkerAlphalocal 0.4;

	} foreach _zonesNumber;
};

if (isserver) then { //server

//grab map missions from server
	_servermishlist = format ["servermishlist%1", worldname];
	_servermishfiles = format ["servermishfiles%1", worldname];
	mishlist = profileNamespace getVariable [_servermishlist, []];
	mishfiles = profileNamespace getVariable [_servermishfiles, []];


//publish mission list
	publicVariable "mishlist";
	publicVariable "mishfiles";

//update server missions
	"mishlist" addPublicVariableEventHandler {
		profileNamespace setVariable [_servermishlist,mishlist];
	};

	"mishfiles" addPublicVariableEventHandler {
		profileNamespace setVariable [_servermishfiles,mishfiles];
	};

	if (isdedicated) then { //save server profile when all players gone
		["saveprofile", "onPlayerDisconnected", {
			if ( ({isPlayer _x} count playableUnits) == 0 ) then { saveprofileNamespace };
		}] call BIS_fnc_addStackedEventHandler;
	};

} else { //clients

	//Mish save
	[
		"Save/Load",
		"Transfer MCC mission to server",
		{
			_mish = profileNamespace getVariable "MCC_save";
			_dialogResult =
				[
					"Transfer MCC mission to server",
					[
						["Choose mission", _mish]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			mishlist pushback (_mish select (_dialogResult select 0));
			mishfiles pushback ((profileNamespace getVariable "MCC_saveFiles") select (_dialogResult select 0));
			publicVariable "mishlist";
			publicVariable "mishfiles";
		}
	] call Ares_fnc_RegisterCustomModule;

	//Mish load
	[
		"Save/Load",
		"Load MCC mission from server",
		{
			_dialogResult =
				[
					"Load MCC mission from server",
					[
						["Choose mission", mishlist]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_array = ((mishfiles select (_dialogResult select 0)) select 1);
			_string = _array select 7;
			if (isnil "_string") then {_string = ""};

			//Do we have saved objects?
			if ((count (_array select 0))>0 || (count (_array select 1))>0 || (count (_array select 2))>0 || (count (_array select 3))>0 || (count (_array select 4))>0 || (count (_array select 5))>0 || (count (_array select 6))>0 || _string != "") then
			{
				sleep 0.5;
				closeDialog 0;
				sleep 0.3;
				[[_array select 0, _array select 1, _array select 2, _array select 3, _array select 4, _array select 5], "MCC_fnc_loadFromMCC", false, false] spawn BIS_fnc_MP;
				[(_array select 6)] spawn MCC_fn_loadZones;

				_command = 'mcc_isloading=true;closedialog 0;titleText ["Loading Mission","BLACK FADED",5];' + _string + 'mcc_isloading=false;titleText ["Mission Loaded","BLACK IN",5];';

				[] spawn compile _command;
			}
			else
			{
				hint "Mission load failed! : No MCC Mission configuration pasted from namespace";
			};
		}
	] call Ares_fnc_RegisterCustomModule;

	//Mish delete
	[
		"Save/Load",
		"Delete MCC mission from server",
		{
			_dialogResult =
				[
					"Delete MCC mission from server",
					[
						["Choose mission", mishlist]
					]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			mishlist deleteAt (_dialogResult select 0);
			mishfiles deleteAt (_dialogResult select 0);
			publicVariable "mishlist";
			publicVariable "mishfiles";
		}
	] call Ares_fnc_RegisterCustomModule;
};

if (!isdedicated) then { //players

	[
		"AI Behaviours",
		"AI Sweep",
		{
			_unit = _this select 1;
			_grp = group _unit;
			if (_grp == grpNull) exitwith {"ERROR: NO GROUP SELECTED.";};

			_dialogResult =
				["Begin Sweep",
						[
							["Sweep Mode:", ["Basic", "Advanced"]],
							["Waypoints max spacing:", ["50m", "100m", "200m", "300m", "500m", "750m", "1000m"],3]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_radius = 50;
			switch (_dialogResult select 1) do
			{
				case 0: { _radius = 50; };
				case 1: { _radius = 100; };
				case 2: { _radius = 200; };
				case 3: { _radius = 300; };
				case 4: { _radius = 500; };
				case 5: { _radius = 750; };
				default { _radius = 1000; };
			};

			_mode = "bis_fnc_taskPatrol";
			switch (_dialogResult select 0) do
			{
				case 0: { _mode = "bis_fnc_taskPatrol"; };
				default { _mode = "CBA_fnc_taskPatrol"; };
			};

			_pos = _this select 0;
			[[_grp, _pos, _radius], _mode, _unit, false, true] call BIS_fnc_MP;

			["SWEEP STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"AI Behaviours",
		"AI Defend",
		{
			_unit = _this select 1;
			_grp = group _unit;
			if (_grp == grpNull) exitwith {"ERROR: NO GROUP SELECTED.";};

			_dialogResult =
				["Begin Defence",
						[
							["Defence Mode:", ["Hold", "Fortify"]],
							["Defend Radius (Fortify only):", ["50m", "100m", "200m", "300m", "500m", "750m", "1000m"],3]
						]
				] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			if ((_dialogResult select 0) == 1) then {
				 _mode = "bis_fnc_taskDefend";
			} else {
				 _mode = "CBA_fnc_taskDefend";
			};

			_pos = _this select 0;
			if (_mode == "CBA_fnc_taskDefend") then {
				_radius = 50;
				switch (_dialogResult select 1) do
				{
					case 0: { _radius = 50; };
					case 1: { _radius = 100; };
					case 2: { _radius = 200; };
					case 3: { _radius = 300; };
					case 4: { _radius = 500; };
					case 5: { _radius = 750; };
					default { _radius = 1000; };
				};
				[[_grp, _pos, _radius], _mode, _unit, false, true] call BIS_fnc_MP;
			} else {
				[[_grp, _pos], _mode, _unit, false, true] call BIS_fnc_MP;
			};

			["DEFENCE STARTED."] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set High Commander",
		{
			_unit = (_this select 0) nearestObject "Man";
			if ((_unit == objNull) || (group _unit == grpNull) || (!alive _unit) || !(_unit == player) || (!isplayer _unit)) exitwith {"NO PLAYER SELECTED.";};

			{
				if (side _x == west) then {
					_unit hcsetgroup [_x,""];
				};
			} foreach allgroups;

			["%1 SET TO HIGH COMMANDER.", _unit] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set Medic (TCCC)",
		{
			_unit = (_this select 0) nearestObject "Man";
			if ((_unit == objNull) || (group _unit == grpNull) || (!alive _unit) || !(_unit == player) || (!isplayer _unit)) exitwith {"NO PLAYER SELECTED.";};
			_unit setvariable ["ace_medical_medicClass", 1, true];

			["%1 SET AS MEDIC.", _unit] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Detonate Nuke",
		{
			_dialogResult =
				["Bomb settings",
						[
							["Explosive yield:", ["Small", "Medium", "Big", "Huge"]]
						]
				] call Ares_fnc_ShowChooseDialog;

			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_yield = "grenadeHand";
			switch (_dialogResult select 0) do
			{
				case 0: { _yield = 500; };
				case 1: { _yield = 1000; };
				case 2: { _yield = 2000; };
				default { _yield = 5000; };
			};

			_pos = _this select 0;
			[[_pos,_yield], "RHS_fnc_ss21_nuke", false, false, true] call BIS_fnc_MP;

			["TAKE COVER!"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Helipad lights (Add)",
		{
			_pads = ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"];
			_pad = _this select 1;
			if !((typeof _pad) in _pads) then {
				_npad = nearestObjects [(_this select 0), _pads, 15];
				_badpad = false;
				if ((isnil "_npad") || ((count _npad) == 0)) exitwith {_badpad = true};
				_pad = _npad select 0;
			};

			if (_badpad) exitwith {["NO HELIPAD SELECTED"] call Ares_fnc_ShowZeusMessage};

			_dialogResult =
				["Colors",
						[
							["Inner Lights:", ["Red", "Green", "Yellow", "IR"], 2],
							["Outer Lights:", ["Red", "Green", "Yellow", "Blue", "White", "IR"], 1]
						]
				] call Ares_fnc_ShowChooseDialog;

			if (count _dialogResult == 0) exitWith { "User cancelled dialog."; };

			_inner = "Yellow";
			switch (_dialogResult select 0) do
			{
				case 0: { _inner = "Red"; };
				case 1: { _inner = "Green"; };
				case 2: { _inner = "Yellow"; };
				default { _inner = "IR"; };
			};

			_outer = "Green";
			switch (_dialogResult select 0) do
			{
				case 0: { _outer = "Red"; };
				case 1: { _outer = "Green"; };
				case 2: { _outer = "Yellow"; };
				case 3: { _outer = "Blue"; };
				case 4: { _outer = "White"; };
				default { _outer = "IR"; };
			};

			[_pad, _inner, _outer, false] spawn seven_fnc_helipad_light;

			["HELIPAD LIGHTS ADDED"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Helipad lights (Remove)",
		{
			_pads = ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"];
			_pad = _this select 1;
			if !((typeof _pad) in _pads) then {
				_npad = nearestObjects [(_this select 0), _pads, 15];
				_badpad = false;
				if ((isnil "_npad") || ((count _npad) == 0)) exitwith {_badpad = true};
				_pad = _npad select 0;
			};

			if (_badpad) exitwith {["NO HELIPAD SELECTED"] call Ares_fnc_ShowZeusMessage};

			[_pad] call seven_fnc_helipad_light_remove;

			["HELIPAD LIGHTS DELETED"] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;

	[
		"7CMBG",
		"Set Medical Vehicle",
		{
			_veh = _this select 1;
			if (!alive _veh) exitwith {"NO SUITABLE VEHICLE SELECTED.";};
			_veh setvariable ["ace_medical_medicClass", 1, true];
			_veh addBackpackCargoGlobal ['B_ons_Carryall_TCCC_TW',1];
			_veh addBackpackCargoGlobal ['B_ons_Carryall_Paramedic',1];

			["%1 SET AS MEDICAL VEHICLE.", _veh] call Ares_fnc_ShowZeusMessage;
		}
	] call Ares_fnc_RegisterCustomModule;
};

waituntil {!isnil "Ares_EditableObjectBlacklist"};

Ares_EditableObjectBlacklist = Ares_EditableObjectBlacklist + [
	"ALiVE_mil_placement_custom",
	"ALiVE_mil_OPCOM",
	"ALiVE_mil_logistics",
	"ALiVE_amb_civ_placement",
	"ALiVE_amb_civ_population",
	"ALiVE_MIL_C2ISTAR",
	"ALiVE_sys_data",
	"ALiVE_SUP_PLAYER_RESUPPLY",
	"ALiVE_sys_profile",
	"ALiVE_require",
	"ALiVE_SYS_LOGISTICSDISABLE",
	"mcc_sandbox_moduleGAIASettings",
	"mcc_sandbox_moduleCover",
	"mcc_sandbox_moduleMissionSettings",
	"HeadlessClient_F",
	"ALiVE_civ_placement",
	"ALiVE_mil_placement",
	"tfar_ModuleTaskForceRadioFrequencies"
];