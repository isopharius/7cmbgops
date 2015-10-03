//////////////////////////////////////
//----ALiVE NATOFOR Random Tasks----//
//---By Valixx, Kylania & M4RT14L---//
//---------------v2.4---------------//
//////////////////////////////////////

_mrkSpawnTown = [_this, 0, ""] call BIS_fnc_param;
_missionType = [_this, 1, ""] call BIS_fnc_param;

_myHint ="Incoming Combat Mission";
GlobalHint = _myHint;
publicVariable "GlobalHint";
hintsilent parseText _myHint;

sleep 5;

switch (_missionType) do {
	case "clear": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerCO = ["mob_clear", _mrkSpawnTown, "ELLIPSE", [400,400], "COLOR:", "ColorRed", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerpos _markerCO;

		sleep 0.3;

		//creating the vehicle
		_newPos = [_markerpos, 300, 500, 10, 0, 0, 0] call BIS_fnc_findSafePos;
		_newPos2 = [_markerpos, 300, 500, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_camp = smallcamps call BIS_fnc_selectRandom;
		_mhq = [_camp] call ALIVE_fnc_findComposition;
		_direction = random 360;
		if(count _mhq > 0) then {
            [_mhq, _markerpos, _direction] call ALIVE_fnc_spawnComposition;
        };

		_camp = smallcamps call BIS_fnc_selectRandom;
		_mhq = [_camp] call ALIVE_fnc_findComposition;
		_direction = random 360;
		if(count _mhq > 0) then {
            [_mhq, _newPos2, _direction] call ALIVE_fnc_spawnComposition;
        };

		_ifv1 = createGroup INDEPENDENT;
		[_newPos, 10, "LOP_ISTS_Landrover_M2", _ifv1] call BIS_fnc_spawnvehicle;
		_null = [_ifv1,_markerpos, 250] call CBA_fnc_taskPatrol;
		sleep 10;
		[_newPos, 10, "LOP_ISTS_Landrover_M2", _ifv1] call BIS_fnc_spawnvehicle;
		sleep 10;
		[_newPos, 10, "LOP_ISTS_Landrover_M2", _ifv1] call BIS_fnc_spawnvehicle;

		_grp1C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,_markerpos, 150] call CBA_fnc_taskDefend;

		_grp2C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp2C,_markerpos, 200] call CBA_fnc_taskPatrol;

		_grp3C = [_markerpos, INDEPENDENT, (configfile >>"CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Support_section")] call BIS_fnc_spawnGroup;
		_null = [_grp3C,_newPos2, 250] call CBA_fnc_taskDefend;

		_trg = createTrigger ["EmptyDetector", _markerpos, false];
		_trg setTriggerArea [300, 300, 0, false];
		_trg setTriggerActivation ["GUER", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];

		_null = [west, "mob_clear", ["Take control of the town and drive out terrorist forces.", "Area Clear", "Area Clear"], getMarkerPos "mob_clear", false] call BIS_fnc_taskCreate;
		_null = ["mob_clear", "CREATED"] call BIS_fnc_taskSetState;

		enemyDead = false;
		waitUntil {triggerActivated _trg};

		_null = ["mob_clear", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerCO;
		{deleteVehicle _x} forEach units _grp1C;
		{deleteVehicle _x} forEach units _grp2C;
		{deleteVehicle _x} forEach units _grp3C;
		{deleteVehicle _x} forEach units _ifv1;
		deleteGroup _ifv1;
		deleteGroup _grp1C;
		deleteGroup _grp2C;
		deleteGroup _grp3C;

	    ["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_clear"] call seven_fnc_removeTask;
	};

	case "kill": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerCO = ["mob_kill", _mrkSpawnTown, "ELLIPSE", [100,100], "COLOR:", "ColorRed", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerpos _markerCO;

		sleep 0.3;

		//creating the vehicle
		_newPos = [_markerpos, 400, 500, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_mrap = createVehicle ["LOP_AM_Landrover",[(_markerpos select 0) + 1,_markerpos select 1,0],[], 0, "NONE"];

		_off = createGroup RESISTANCE;
		_officer1 = _off createUnit ["LOP_AM_Infantry_TL",[(_markerpos select 0) + 3, _markerpos select 1,0], [], 0, "NONE"];
		_officer1 setSkill 0;
		_officer1 allowFleeing 1;
		{_officer1 disableAI _x} forEach ["MOVE","ANIM","AUTOTARGET","TARGET","FSM"];

		_grp1C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,getpos _mrap, 250] call CBA_fnc_taskPatrol;

		_mrap1 = createGroup INDEPENDENT;
		[_newPos, 10, "LOP_AM_Landrover_M2", _mrap1] call BIS_fnc_spawnvehicle;
		_null = [_mrap1,getPos _officer1, 300] call CBA_fnc_taskPatrol;
		sleep 10;
		[_newPos, 10, "LOP_AM_Landrover_M2", _mrap1] call BIS_fnc_spawnvehicle;

		_null = [west, "mob_kill", ["Kill the insurgent officer", "Kill Officer", "Kill Officer"], getMarkerPos "mob_kill", false] call BIS_fnc_taskSetState;
		_null = ["mob_kill", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil {!alive _officer1};

		_null = ["mob_kill", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerCO;
		{deleteVehicle _x} forEach units _grp1C;
		{deleteVehicle _x} forEach units _mrap1;
		deleteGroup _grp1C;
		deleteGroup _mrap1;
		deleteGroup _off;
		deleteVehicle _mrap;

	    ["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_kill"] call seven_fnc_removeTask;
	};

	case "ammo": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerCO = ["mob_ammo", _mrkSpawnTown, "ELLIPSE", [150,150], "COLOR:", "ColorRed", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerCO;

		sleep 0.3;

		//creating the vehicle
		_newPos = [_markerpos, 100, 150, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_inteltype = ["Land_SatellitePhone_F","Land_SurvivalRadio_F","Land_Suitcase_F"] call BIS_fnc_selectRandom;

		_intel = createVehicle [_inteltype, _markerpos, [], 0, "none"];
		[_intel,"getintel",true,true] call BIS_fnc_MP;

		_houses2 = [_markerpos,150] call ALIVE_fnc_getEnterableHouses;

		if((count _houses2) > 0) then {

			_house2 = _houses2 call BIS_fnc_selectRandom;

			_buildingpos = 1 max (round random (_house2 select 1));
			_house2 = _house2 select 0;

			_intel setPos (_house2 buildingPos _buildingpos);
		};

		sleep 0.3;

		//creating the suspect

		_civiliantype = ["LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_04"] call BIS_fnc_selectRandom;

		_civgrp = createGroup CIVILIAN;
		_suspect = _civgrp createUnit [_civiliantype, [(getpos _intel select 0) + 0.2, getpos _intel select 1,0], [], 0, "none"];
		_suspect setSkill 0;
		_suspect allowFleeing 1;
		{_suspect disableAI _x} forEach ["MOVE","ANIM","AUTOTARGET","TARGET","FSM"];
		_suspect allowDamage false;
		_suspect addMagazine "MiniGrenade";
		[_suspect,"getintel",true,true] call BIS_fnc_MP;

		_null = [west, "mob_ammo", ["We have humint about one civilian cooperating with terrorist forces, search in the marked area and find evidences.", "Find Evidence", "Find Evidence"], getMarkerPos "mob_ammo", false] call BIS_fnc_taskSetState;
		_null = ["mob_ammo", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil {!alive _intel};

		sleep 3;

		_grp1C = [_newPos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,getpos _suspect, 50] call CBA_fnc_taskPatrol;

	    ["Now arrest suspect and escort to Main Base", "sideChat", true] call BIS_fnc_MP;

		waitUntil {_suspect distance getMarkerPos "respawn_west" < 100 OR !alive _suspect};

		if (!alive _suspect) exitWith {_null = ["mob_ammo", "FAILED"] call BIS_fnc_taskSetState; deleteMarker _markerCO; {deleteVehicle _x} forEach units _grp1C; deleteGroup _grp1C; deleteVehicle _suspect; deleteGroup _civgrp; [west, "mob_ammo"] call seven_fnc_removeTask;};

		_null = ["mob_ammo", "SUCCEEDED"] call BIS_fnc_taskSetState;

		[_suspect] join grpNull;

		sleep 10;

		deleteMarker _markerCO;
		{deleteVehicle _x} forEach units _grp1C;
		deleteGroup _grp1C;
		deleteVehicle _suspect;
		deleteGroup _civgrp;

	    ["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_ammo"] call seven_fnc_removeTask;
	};

	case "ammo2": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerSO = ["mob_ammo2", _mrkSpawnTown, "ELLIPSE", [100,100], "COLOR:", "ColorRed", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerCO;

		sleep 0.3;

		//creating the vehicle
		_stashtype = ["Box_NATO_Ammo_F","Box_NATO_WpsLaunch_F","Box_East_WpsSpecial_F"] call BIS_fnc_selectRandom;

		_cache1 = createVehicle [_stashtype, _markerpos, [], 0, "none"];

		_houses1 = [_markerpos,100] call ALIVE_fnc_getEnterableHouses;

		if((count _houses1) > 0) then {

			_house1 = _houses1 call BIS_fnc_selectRandom;

			_buildingpos = 1 max (round random (_house1 select 1));
			_house1 = _house1 select 0;

			_cache1 setPos (_house1 buildingPos _buildingpos);
		} else {
			_cache1 setPos [(_markerpos select 0) + random 100,(_markerpos select 1) + random 100,0];
		};

		_cache2 = createVehicle [_stashtype, _markerpos, [], 0, "none"];

		_houses2 = [_markerpos,100] call ALIVE_fnc_getEnterableHouses;

		if((count _houses2) > 0) then {

			_house2 = _houses2 call BIS_fnc_selectRandom;

			_buildingpos = 1 max (round random (_house2 select 1));
			_house2 = _house2 select 0;

			_cache2 setPos (_house2 buildingPos _buildingpos);
		} else {
			_cache2 setPos [(_pos select 0) - random 100,(_markerpos select 1) - random 100,0];
		};

		_cache3 = createVehicle [_stashtype, _markerpos, [], 0, "none"];

		_houses3 = [_markerpos,100] call ALIVE_fnc_getEnterableHouses;

		if((count _houses3) > 0) then {

			_house3 = _houses3 call BIS_fnc_selectRandom;

			_buildingpos = 1 max (round random (_house3 select 1));
			_house3 = _house3 select 0;

			_cache3 setPos (_house3 buildingPos _buildingpos);
		} else {
			_cache3 setPos [(_pos select 0) + random 100,(_pos select 1) - random 100,0];
		};

		sleep 0.3;

		_grp1C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,getPos _cache1, 150] call BIS_fnc_taskPatrol;

		_null = [west, "mob_ammo2", ["We have information that terrorist forces they have several ammo stashes in this marked area, you must find and blow them.", "Destroy Stash", "Destroy Stash"], getMarkerPos "mob_ammo2", false] call BIS_fnc_taskSetState;
		_null = ["mob_ammo2", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil {!alive _cache1 && !alive _cache2 && !alive _cache3};

		_null = ["mob_ammo2", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 30;

		deleteMarker _markerCO;
		{deleteVehicle _x} forEach units _grp1C;
		deleteGroup _grp1C;
		deleteVehicle _cache1;
		deleteVehicle _cache2;
		deleteVehicle _cache3;

	    ["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_ammo2"] call seven_fnc_removeTask;
	};

	case "comms": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerCO = createMarker ["mob_comms", _mrkSpawnTown];
		_markerCO setMarkerShape "Empty";
		_markerpos = getMarkerPos _markerCO;

		sleep 0.3;

		//creating the vehicle

		_newPos = [_markerpos, 200, 400, 15, 0, 0, 0] call BIS_fnc_findSafePos;

		_movilhq = createVehicle ["rhs_gaz66_r142_msv", _newPos, [], 0, "NONE"];
		_mhqpos = getPos _movilhq;

		_isFlat_comms = [_markerpos,600] call ALiVE_fnc_findFlatArea;
		_movilhq setPos _isFlat_comms;

		_camonet = createVehicle ["CamoNet_OPFOR_big_F", _mhqpos, [], 0, "none"];

		_markercomms = ["commsmarker", _mhqpos, "ICON", [0.7,0.7], "COLOR:", "ColorRed", "TEXT:", "Comms Module", "TYPE:", "o_support", "PERSIST"] call CBA_fnc_createMarker;

		_grp1C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Patrol_section")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,_mhqpos, 100] call CBA_fnc_taskPatrol;

		_grp2C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Patrol_section")] call BIS_fnc_spawnGroup;
		_null = [_grp2C,_mhqpos, 200] call CBA_fnc_taskPatrol;

		_null = [west, "mob_comms", ["Find and destroy OPFOR mobile comms", "Destroy Comms", "Destroy Comms"], getMarkerPos "commsmarker", false] call BIS_fnc_taskSetState;
		_null = ["mob_comms", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil {!alive _movilhq};

		_null = ["mob_comms", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerCO;
		deleteMarker _markercomms;
		deleteVehicle _movilhq;
		deleteVehicle _camonet;
		{deleteVehicle _x} forEach units _grp1C;
		{deleteVehicle _x} forEach units _grp2C;
		deleteGroup _grp1C;
		deleteGroup _grp2C;

	    ["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_comms"] call seven_fnc_removeTask;
	};

	case "clear2": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerCO = ["mob_clear2", _mrkSpawnTown, "ELLIPSE", [500,500], "COLOR:", "ColorRed", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerCO;

		sleep 0.3;

		//creating the vehicle

		_newPos = [_markerpos, 300, 500, 10, 0, 0, 0] call BIS_fnc_findSafePos;
		_newPos2 = [_markerpos, 300, 500, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_camp = smallcamps call BIS_fnc_selectRandom;
		_mhq = [_camp] call ALIVE_fnc_findComposition;
		_direction = random 360;
		if(count _mhq > 0) then {
            [_mhq, _markerpos, _direction] call ALIVE_fnc_spawnComposition;
        };

		_camp = smallcamps call BIS_fnc_selectRandom;
		_mhq = [_camp] call ALIVE_fnc_findComposition;
		_direction = random 360;
		if(count _mhq > 0) then {
            [_mhq, _newPos2, _direction] call ALIVE_fnc_spawnComposition;
        };

		_grp1C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,_markerpos, 100] call CBA_fnc_taskDefend;

		_grp2C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp2C,_markerpos, 150] call CBA_fnc_taskPatrol;

		_grp2C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_ISTS_Support_section")] call BIS_fnc_spawnGroup;
		_null = [_grp2C,_newPos2, 250] call CBA_fnc_taskDefend;

		_car1 = createGroup INDEPENDENT;
		[_newPos, 10, "LOP_AM_Landrover_M2", _car1] call BIS_fnc_spawnvehicle;
		_null = [_car1,_mhqpos, 200] call BIS_fnc_taskPatrol;
		sleep 10;
		[_newPos, 10, "LOP_AM_Landrover_M2", _car1] call BIS_fnc_spawnvehicle;
		sleep 10;
		[_newPos, 10, "LOP_AM_Landrover_M2", _car1] call BIS_fnc_spawnvehicle;

		_trg = createTrigger ["EmptyDetector", _markerpos, false];
		_trg setTriggerArea [300, 300, 0, false];
		_trg setTriggerActivation ["GUER", "NOT PRESENT", false];
		_trg setTriggerStatements ["this", "", ""];

		_null = [west, "mob_clear2", ["Take control of the town and drive out Militia forces.", "Area Clear", "Area Clear"], getMarkerPos "mob_clear2", false] call BIS_fnc_taskSetState;
		_null = ["mob_clear2", "CREATED"] call BIS_fnc_taskSetState;

		enemyDead = false;
		waitUntil {triggerActivated _trg};

		_null = ["mob_clear2", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerCO;
		{deleteVehicle _x} forEach units _grp1C;
		deleteGroup _grp1C;
		{deleteVehicle _x} forEach units _grp2C;
		deleteGroup _grp2C;
		{deleteVehicle _x} forEach units _car1;
		deleteGroup _car1;

	    ["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_clear2"] call seven_fnc_removeTask;
	};

	case "antiair": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerCO = createMarker ["mob_aaa", _mrkSpawnTown];
		_markerCO setMarkerShape "Empty";
		_markerpos = getMarkerPos _markerCO;

		sleep 0.3;

		//creating the vehicle

		_artyaa = createVehicle ["rhs_zsu234_aa", _markerpos, [], 0, "none"];
		_artyaa setFuel 0;

		_isFlat_AA = [_markerpos,600] call ALiVE_fnc_findFlatArea;
		_artyaa setPos _isFlat_AA;
		_artypos = getpos _artyaa;

		_atrezzo = createVehicle ["Land_Jbad_Ind_Shed_02",[(_artypos select 0) + 15, _artypos select 1,0], [], 0, "NONE"];
		_atpos = getpos _atrezzo;
		_camonet = createVehicle ["CamoNet_OPFOR_big_F", _atpos, [], 0, "none"];

		_aacrew = createGroup INDEPENDENT;
		_crew1 = _aacrew createUnit ["LOP_ISTS_Infantry_Engineer", [0,0,1], [], 0, "none"];
		_crew1 moveInCommander _artyaa;
		_crew2 = _aacrew createUnit ["LOP_ISTS_Infantry_Engineer", [0,0,1], [], 0, "none"];
		_crew2 moveInGunner _artyaa;

		_markerAA = ["AAmarker", _artypos, "ICON", [0.7,0.7], "COLOR:", "ColorRed", "TEXT:", "Terrorist SPAA", "TYPE:", "o_art", "PERSIST"] call CBA_fnc_createMarker;

		_grp1C = [_atpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_AT_section")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,_atpos] call CBA_fnc_taskDefend;

		_grp2C = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp2C,_artypos, 250] call CBA_fnc_taskPatrol;

		_null = [west, "mob_aaa", ["Find and destroy the AA.", "Destroy AA", "Destroy AA"], getMarkerPos "AAmarker", false] call BIS_fnc_taskSetState;
		_null = ["mob_aaa", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil {!alive _artyaa};

		_null = ["mob_aaa", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerCO;
		deleteMarker _markerAA;
		deleteVehicle _artyaa;
		deleteVehicle _camonet;
		deleteVehicle _atrezzo;
		{deleteVehicle _x} forEach units _aacrew;
		deleteGroup _aacrew;
		{deleteVehicle _x} forEach units _grp1C;
		deleteGroup _grp1C;

	    ["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_aaa"] call seven_fnc_removeTask;
	};

	case "capture": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerCO = createMarker ["mob_capture", _mrkSpawnTown];
		_markerCO setMarkerShape "Empty";
		_markerpos = getMarkerPos _markerCO;

		sleep 0.3;

		//creating the vehicle

		_newPos = [_markerpos, 100, 150, 15, 0, 0, 0] call BIS_fnc_findSafePos;

		_wlordgrp = createGroup CIVILIAN;
		_warlord = _wlordgrp createUnit ["LOP_ISTS_Infantry_SL", _markerpos, [], 0, "NONE"];
		removeAllWeapons _warlord;
		_warlord setSkill 0;
		_warlord allowFleeing 1;
		{_warlord disableAI _x} forEach ["MOVE","ANIM","AUTOTARGET","TARGET","FSM"];
		_warlord allowDamage false;
		_warlord setCaptive true;
		[_warlord,"grab",true,true] call BIS_fnc_MP;

		_houses = [_markerpos,300] call ALIVE_fnc_getEnterableHouses;

		if((count _houses) > 0) then {

			_house = _houses call BIS_fnc_selectRandom;

			_buildingpos = 1 max (round random (_house select 1));
			_house = _house select 0;

			_warlord setPos (_house buildingPos _buildingpos);
		};
		_warlordpos = getpos _warlord;

		_markerwlord = ["wlordmarker", _warlordpos, "ICON", [0.7,0.7], "COLOR:", "ColorRed", "TEXT:", "Terrorist Leader", "TYPE:", "o_hq", "PERSIST"] call CBA_fnc_createMarker;

		sleep 0.3;

		_grp1C = [_newPos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Patrol_section")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,_warlordpos,300] call CBA_fnc_taskDefend;

		_grp2C = [_newPos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Patrol_section")] call BIS_fnc_spawnGroup;
		_null = [_grp2C,_warlordpos,100] call CBA_fnc_taskDefend;

		_grp3C = [_newPos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp3C,_warlordpos, 300] call CBA_fnc_taskPatrol;

		_null = [west, "mob_capture", ["Find and arrest the insurgent leader and escort him to Main Camp.", "Capture Warlord", "Capture Warlord"], getMarkerPos "wlordmarker", false] call BIS_fnc_taskSetState;
		_null = ["mob_capture", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { _warlord distance getMarkerPos "respawn_west" < 100 OR !alive _warlord };

		if (!alive _warlord) exitWith {_null = ["mob_capture", "FAILED"] call BIS_fnc_taskSetState; deleteMarker _markerCO; deleteMarker _markerwlord; {deleteVehicle _x} forEach units _grp1C; {deleteVehicle _x} forEach units _grp2C; {deleteVehicle _x} forEach units _grp3C; deleteGroup _grp1C; deleteGroup _grp2C; deleteGroup _grp3C; deleteVehicle _warlord; deleteGroup _wlordgrp; [west, "mob_capture"] call seven_fnc_removeTask;};

		_null = ["mob_capture", "SUCCEEDED"] call BIS_fnc_taskSetState;

		[_warlord] join grpNull;

		sleep 10;

		deleteMarker _markerCO;
		deleteMarker _markerwlord;
		{deleteVehicle _x} forEach units _grp1C;
		deleteGroup _grp1C;
		{deleteVehicle _x} forEach units _grp2C;
		deleteGroup _grp2C;
		{deleteVehicle _x} forEach units _grp3C;
		deleteGroup _grp3C;
		deleteGroup _wlordgrp;
		deleteVehicle _warlord;

	    ["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_capture"] call seven_fnc_removeTask;
	};

	case "nuke": {

		hint "COMBAT OPS UPDATED";
		//creating the marker

		_markerCO = ["mob_nuke", _mrkSpawnTown, "ELLIPSE", [150,150], "COLOR:", "ColorRed", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerCO;
		sleep 0.3;

		_newPos = [_markerpos, 100, 150, 10, 0, 0, 0] call BIS_fnc_findSafePos;
		_nuke = createVehicle ["Land_Device_assembled_F", _newPos, [], 0, "none"];
		[_nuke,"disarmaction",true,true] call BIS_fnc_MP;

		_houses2 = [_markerpos,150] call ALIVE_fnc_getEnterableHouses;

		if((count _houses2) > 0) then {

			_house2 = _houses2 call BIS_fnc_selectRandom;

			_buildingpos = 1 max (round random (_house2 select 1));
			_house2 = _house2 select 0;

			_nuke setPos (_house2 buildingPos _buildingpos);
		};

		_grp1C = [(getpos _nuke), INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_AM" >> "Infantry" >> "LOP_AM_Patrol_section")] call BIS_fnc_spawnGroup;
		_null = [_grp1C,_newPos,100] call CBA_fnc_taskDefend;

		sleep 0.1;

		_null = [west, "mob_nuke", ["PAPA BEAR has uncovered intelligence about a nuclear device that could go boom within the hour. Find the assembled bomb and disarm it before the countdown starts.", "Prevent Nuclear Meltdown", "Prevent Nuclear Meltdown"], getMarkerPos "mob_nuke", false] call BIS_fnc_taskSetState;
		_null = ["mob_nuke", "CREATED"] call BIS_fnc_taskSetState;

		DISARMNUKE = false;
		_nuketime = 0;
		while {(alive _nuke) && (_nuketime < 1800) && !(DISARMNUKE)} do {_nuketime = _nuketime + 10; sleep 10};

		if (DISARMNUKE) exitwith {
			["mob_nuke", "SUCCEEDED"] call BIS_fnc_taskSetState;

	    	["COMBAT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

			sleep 10;

			deleteMarker _markerCO;
			deleteVehicle _nuke;

			[west, "mob_nuke"] call seven_fnc_removeTask;

			sleep 60;

			{deleteVehicle _x} forEach units _grp1C;
			deleteGroup _grp1C;
		};

		["mob_nuke", "FAILED"] call BIS_fnc_taskSetState;

		if (!alive _nuke) then {

	    	[format ["This is PAPA BEAR. Device is damaged and unstable, 30 seconds to nuclear meltdown!", floor(_sleep / 60)], "sideChat", true, false, true] call BIS_fnc_MP;

		} else {

		    _sleep = 120 + floor(random 200);

		    [format ["This is PAPA BEAR. Nuke countdown started! You have about %1 minutes to evacuate before the bomb goes off.", floor(_sleep / 60)], "sideChat", true, false, true] call BIS_fnc_MP;

		    sleep 30;
		    _sleep = _sleep - 30;
		    [format ["This is PAPA BEAR. I say again! You have %1 minutes to clear the area!", floor(_sleep / 60)], "sideChat", true, false, true] call BIS_fnc_MP;

			sleep _sleep;
		    [format ["This is PAPA BEAR. 30 seconds to nuclear meltdown!", floor(_sleep / 60)], "sideChat", true, false, true] call BIS_fnc_MP;
		};

		sleep 20;
		[_nuke, "Alive_Beep"] call CBA_fnc_globalSay3d;
		sleep 5;
	    [(position _nuke), (random 1000) + 1000] call RHS_fnc_ss21_nuke;

		sleep 10;
		deleteMarker _markerCO;

		[west, "mob_nuke"] call seven_fnc_removeTask;

		sleep 60;

		{deleteVehicle _x} forEach units _grp1C;
		deleteGroup _grp1C;
	};
};