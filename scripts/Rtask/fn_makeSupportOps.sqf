//////////////////////////////////////
//----ALiVE NATOFOR Random Tasks----//
//---By Valixx, Kylania & M4RT14L---//
//---------------v2.4---------------//
//////////////////////////////////////

_mrkSpawnPos = [_this, 0, ""] call BIS_fnc_param;
_missionType = [_this, 1, ""] call BIS_fnc_param;

_myHint ="Incoming Support Mission";
GlobalHint = _myHint;
publicVariable "GlobalHint";
hintsilent parseText _myHint;

sleep 5;

switch (_missionType) do {
	case "ied": {

		hint "UPDATED SUPPORT OPS";
		//creating the marker

		_markerSO = ["mob_ied", _mrkSpawnPos, "ICON", [1,1], "COLOR:", "ColorOrange", "TEXT:", "Clear IED", "TYPE:", "Minefield", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerSO;

		sleep 0.3;

		//creating the vehicle

		_ied = ["ModuleExplosive_IEDLandSmall_F","ModuleExplosive_IEDLandBig_F"] call BIS_fnc_selectRandom;

		_explo = createVehicle [_ied,[(_markerpos select 0) + 3, _markerpos select 1,0],[], 0, "NONE"];

		_pole = createVehicle ["Pole_F", getPos _explo, [], 0, "NONE"];
		[_pole,"iedblow",true,true] call BIS_fnc_MP;

		_grp1S = [_markerpos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		{_x allowdamage false} foreach units _grp1S;
		_null = [_grp1S,getPos _pole, 150] call CBA_fnc_taskPatrol;

		_null = [west, "mob_ied", ["Must neutralize the IED.", "Clear IED", "Clear IED"], getMarkerPos "mob_ied", false] call BIS_fnc_taskSetState;
		_null = ["mob_ied", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { !alive _explo };

		_null = ["mob_ied", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerSO;
		{deleteVehicle _x} forEach units _grp1S;
		deleteGroup _grp1S;

	    ["SUPPORT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_ied"] call seven_fnc_removeTask;
	};

	case "roadrepair": {

		hint "UPDATED SUPPORT OPS";
		//creating the marker

		_markerSO = ["mob_rrep", _mrkSpawnPos, "ICON", [1,1], "COLOR:", "ColorRed", "TEXT:", "Repair MSR", "TYPE:", "waypoint", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerSO;

		sleep 0.3;

		//creating the vehicle

		_crater = ["CraterLong","CraterLong_small","Dirthump_3_F","Dirthump_2_F","Dirthump_1_F"] call BIS_fnc_selectRandom;

		_eng = createVehicle ["B_APC_Tracked_01_CRV_F",[(getMarkerpos "respawn_west" select 0) + 10, getMarkerpos "respawn_west" select 1,0],[], 0, "NONE"];
		_eng setFuel 1;
		_eng allowDammage false;
		_sign = createVehicle ["Sign_Sphere25cm_F",getPos _eng, [], 0, "NONE"];
		_sign attachTo [_eng,[0,0,+5]];

		_cra = createVehicle [_crater,[(_markerpos select 0), _markerpos select 1,0],[], 0, "NONE"];

		_grp1S = [_markerpos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		{_x allowdamage false} foreach units _grp1S;
		_null = [_grp1S,getPos _cra, 150] call CBA_fnc_taskPatrol;

		_null = [west, "mob_rrep", ["Take the CRV and repair the MSR.", "Road Repair", "Road Repair"], getMarkerPos "mob_rrep", false] call BIS_fnc_taskSetState;
		_null = ["mob_rrep", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { _eng distance _markerpos < 20 OR !alive _eng };

		if (!alive _eng) exitWith {_null = ["mob_rrep", "FAILED"] call BIS_fnc_taskSetState; deleteMarker _markerSO; {deleteVehicle _x} forEach units _grp1S; deleteGroup _grp1S; deleteVehicle _eng; deleteVehicle _sign; deleteVehicle _cra; [west, "mob_rrep"] call seven_fnc_removeTask;};

		hint "REPAIRING ROAD";
		sleep 60;
		deleteVehicle _cra;

		_null = ["mob_rrep", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerSO;
		deletevehicle _eng;
		deleteVehicle _sign;
		{deleteVehicle _x} forEach units _grp1S;
		deleteGroup _grp1S;

	    ["SUPPORT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_rrep"] call seven_fnc_removeTask;
	};

	case "hqbuild": {

		hint "UPDATED SUPPORT OPS";
		//creating the marker

		_markerSO = ["mob_build", _mrkSpawnPos, "ICON", [1,1], "COLOR:", "ColorBlue", "TEXT:", "Checkpoint", "TYPE:", "mil_box", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerSO;

		sleep 0.3;

		//creating the vehicle

		_newPos = [_markerpos, 15, 30, 10, 0, 20, 0] call BIS_fnc_findSafePos;

		_eng = createVehicle ["B_Truck_01_box_F",[(getMarkerpos "respawn_west" select 0) + 10, getMarkerpos "respawn_west" select 1,0],[], 0, "NONE"];
		_eng setFuel 1;
		_eng allowDammage false;
		_sign = createVehicle ["Sign_Sphere25cm_F",getPos _eng, [], 0, "NONE"];
		_sign attachTo [_eng,[0,0,+5]];

		_mhq = ["mediumCheckpoint1"] call ALIVE_fnc_findComposition;
		_direction = random 360;
		if(count _mhq > 0) then {
            [_mhq, _markerpos, _direction] call ALIVE_fnc_spawnComposition;
        };

		_grp1S = [_markerpos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		{_x allowdamage false} foreach units _grp1S;
		_null = [_grp1S,_markerpos, 200] call CBA_fnc_taskDefend;

		_null = [west, "mob_build", ["Take the supply truck and escort to the checkpoint to deploy the HQ.", "Deploy HQ", "Deploy HQ"], getMarkerPos "mob_build", false] call BIS_fnc_taskSetState;
		_null = ["mob_build", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { _eng distance _markerpos < 50 OR !alive _eng };

		if (!alive _eng) exitWith {_null = ["mob_build", "FAILED"] call BIS_fnc_taskSetState; deleteMarker _markerSO; {deleteVehicle _x} forEach units _grp1S; deleteGroup _grp1S; deleteVehicle _eng; deleteVehicle _sign; [west, "mob_rrep"] call seven_fnc_removeTask;};

		hint "BUILDING POST, WAIT 2MIN";
		sleep 120;
		_post = createVehicle ["Land_Jbad_Mil_Barracks", _newPos,[], 0, "NONE"];

		_null = ["mob_build", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerSO;
		deletevehicle _eng;
		deleteVehicle _sign;
		deleteVehicle _post;
		{deleteVehicle _x} forEach units _grp1S;
		deleteGroup _grp1S;

	    ["SUPPORT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_build"] call seven_fnc_removeTask;
	};

	case "towrepair": {

		hint "UPDATED SUPPORT OPS";
		//creating the marker

		_markerSO = ["mob_trepair", _mrkSpawnPos, "ICON", [1,1], "COLOR:", "ColorBlue", "TEXT:", "C.O.P.", "TYPE:", "b_installation", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerSO;

		sleep 0.3;

		//creating the vehicle

		_eng = createVehicle ["B_Truck_01_box_F",[(getMarkerpos "respawn_west" select 0) + 10, getMarkerpos "respawn_west" select 1,0],[], 0, "NONE"];
		_eng setFuel 1;
		_eng allowDammage false;
		_sign = createVehicle ["Sign_Sphere25cm_F",getPos _eng, [], 0, "NONE"];
		_sign attachTo [_eng,[0,0,+5]];

		_grp1S = [_markerpos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		{_x allowdamage false} foreach units _grp1S;
		_null = [_grp1S, _newPos, 250] call CBA_fnc_taskDefend;

		_grp2S = [_markerpos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		{_x allowdamage false} foreach units _grp2S;
		_null = [_grp2S,_markerpos, 300] call CBA_fnc_taskPatrol;

		sleep 0.3;

		_newPos = [_markerpos, 50, 70, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_mhq = ["largeMilitaryOutpost1"] call ALIVE_fnc_findComposition;
		_direction = random 360;
		if(count _mhq > 0) then {
            [_mhq, _newPos, _direction] call ALIVE_fnc_spawnComposition;
        };

		_null = [west, "mob_trepair", ["Take the supply truck and escort to the Main Camp.", "Deliver Supplies", "Deliver Supplies"], getMarkerPos "mob_trepair", false] call BIS_fnc_taskSetState;
		_null = ["mob_trepair", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { _eng distance _markerpos < 100 OR !alive _eng };

		if (!alive _eng) exitWith {_null = ["mob_trepair", "FAILED"] call BIS_fnc_taskSetState; deleteMarker _markerSO; {deleteVehicle _x} forEach units _grp1S; {deleteVehicle _x} forEach units _grp2S; deleteGroup _grp1S; deleteGroup _grp2S; deleteVehicle _eng; deleteVehicle _sign; [west, "mob_trepair"] call seven_fnc_removeTask;};

		sleep 10;

		_null = ["mob_trepair", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerSO;
		deletevehicle _eng;
		deleteVehicle _sign;
		{deleteVehicle _x} forEach units _grp1S;
		{deleteVehicle _x} forEach units _grp2S;
		deleteGroup _grp1S;
		deleteGroup _grp2S;

	    ["SUPPORT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_trepair"] call seven_fnc_removeTask;
	};

	case "vehrepair": {

		hint "UPDATED SUPPORT OPS";
		//creating the marker

		_markerSO = ["mob_vrepair", _mrkSpawnPos, "ICON", [1,1], "COLOR:", "ColorBlue", "TEXT:", "Damaged Vehicle", "TYPE:", "b_armor", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerSO;

		sleep 0.3;

		//creating the vehicle

		_dveh = ["B_APC_Tracked_01_rcws_F","B_APC_Tracked_01_AA_F","B_MBT_01_cannon_F"] call BIS_fnc_selectRandom;

		_eng = createVehicle ["B_APC_Tracked_01_CRV_F",[(getMarkerpos "respawn_west" select 0) + 10, getMarkerpos "respawn_west" select 1,0],[], 0, "NONE"];
		_eng setFuel 1;
		_eng allowDammage false;
		_sign = createVehicle ["Sign_Sphere25cm_F",getPos _eng, [], 0, "NONE"];
		_sign attachTo [_eng,[0,0,+5]];

		_damve = createVehicle [_dveh,[(_markerpos select 0) + 10, _markerpos select 1,0],[], 0, "NONE"];
		_damve setDammage 0.8;
		_damve setFuel 0;
		_damve allowDammage false;
		[_damve,"towvehicle",true,true] call BIS_fnc_MP;
		[_damve,"untowvehicle",true,true] call BIS_fnc_MP;

		_grp1S = [_markerpos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		{_x allowdamage false} foreach units _grp1S;
		_null = [_grp1S,getPos _damve, 150] call CBA_fnc_taskPatrol;

		_null = [west, "mob_vrepair", ["Take the CRV to tow damaged vehicle to Service area in Main Camp", "Repair vehicle", "Repair Vehicle"], getMarkerPos "mob_vrepair", false] call BIS_fnc_taskSetState;
		_null = ["mob_vrepair", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil {_damve distance getMarkerPos "service" < 20 OR !alive _damve};

		if (!alive _damve) exitWith {_null = ["mob_vrepair", "FAILED"] call BIS_fnc_taskSetState; deleteMarker _markerSO; {deleteVehicle _x} forEach units _grp1S; deleteGroup _grp1S; deleteVehicle _eng; deleteVehicle _sign; deleteVehicle _damve; [west, "mob_vrepair"] call seven_fnc_removeTask;};

		_null = ["mob_vrepair", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerSO;
		{deleteVehicle _x} forEach units _grp1S;
		deleteGroup _grp1S;
		deletevehicle _eng;
		deleteVehicle _sign;
		deleteVehicle _damve;

	    ["SUPPORT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_vrepair"] call seven_fnc_removeTask;
	};

	case "rescue": {

		hint "UPDATED SUPPORT OPS";
		//creating the marker

		_markerSO = ["mob_rescue", _mrkSpawnPos, "ICON", [1,1], "COLOR:", "ColorRed", "TEXT:", "MEDEVAC", "TYPE:", "b_med", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerSO;

		sleep 0.3;

		//creating the vehicle

		_veh = ["B_MRAP_01_gmg_F","B_MRAP_01_F","B_Truck_01_transport_F"] call BIS_fnc_selectRandom;

		_truck = createVehicle [_veh,[(_markerpos select 0) + 3, _markerpos select 1,0],[], 0, "NONE"];
		_truck setDammage 0.8;
		_truck allowDamage false;
		_truck setFuel 0;

		_grp = createGroup WEST;
		_men1 = _grp createUnit ["B_Soldier_F", [(_markerpos select 0) + 10, _markerpos select 1,0], [], 0, "none"];
		_men1 allowDamage false;
		_men1 setCaptive true;
		_men1 playMoveNow "AinjPpneMstpSnonWrflDnon";
		_men1 setSkill 0;
		_men1 allowFleeing 1;
		{_men1 disableAI _x} forEach ["MOVE","ANIM","AUTOTARGET","TARGET","FSM"];
		{[_men1,_x,true,true] call BIS_fnc_MP;} foreach ["dragmat","dropmat","loadmat"];

		_camilla = createVehicle ["Land_Ground_sheet_khaki_F", getPos _men1, [], 0, "NONE"];
		_camilla attachTo [_men1,[0,0,0]];

		_grp1S = [_markerpos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		{_x allowdamage false} foreach units _grp1S;
		_null = [_grp1S,getPos _truck, 150] call CBA_fnc_taskPatrol;

		_null = [west, "mob_rescue", ["Evac wounded personnel from the AO and bring them to MASH in Main Camp, you can only do it with MEDEVAC Chopper.", "MEDEVAC", "MEDEVAC"], getMarkerPos "mob_rescue", false] call BIS_fnc_taskSetState;
		_null = ["mob_rescue", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { _men1 distance getMarkerPos "mash" < 50 OR !alive _men1 };

		if (!alive _men1) exitWith {_null = ["mob_rescue", "FAILED"] call BIS_fnc_taskSetState; deleteMarker _markerSO; {deleteVehicle _x} forEach units _grp1S; deleteGroup _grp1S; deleteVehicle _truck; deleteVehicle _camilla; deleteVehicle _men1; deleteGroup _grp; [west, "mob_rescue"] call seven_fnc_removeTask;};

		_null = ["mob_rescue", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerSO;
		{deleteVehicle _x} forEach units _grp1S;
		deleteGroup _grp1S;
		deleteVehicle _truck;
		deleteVehicle _camilla;
		deleteVehicle _men1;
		deleteGroup _grp;

	    ["SUPPORT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_rescue"] call seven_fnc_removeTask;
	};

	case "uavrec": {

		hint "UPDATED SUPPORT OPS";
		//creating the marker

		_markerSO = createMarker ["mob_uav", _mrkSpawnPos];
		_markerSO setMarkerShape "Empty";
		_markerpos = getMarkerPos _markerSO;

		sleep 0.3;

		//creating the vehicle

		_newPos = [_markerpos, 200, 400, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_uav = createVehicle ["O_UAV_02_F", _newPos, [], 0, "none"];
		_uav setDammage 0.8;
		[_uav,"uavdata",true,true] call BIS_fnc_MP;

		_device = createVehicle ["Land_SurvivalRadio_F", getPos _uav, [], 0, "none"];
		_device attachTo [_uav,[0,0,-0.3]];

		_markeruav = ["uavmarker", getPos _uav, "ICON", [0.7,0.7], "COLOR:", "ColorRed", "TEXT:", "Downed UAV", "TYPE:", "o_uav", "PERSIST"] call CBA_fnc_createMarker;

		_grp1S = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Support_section")] call BIS_fnc_spawnGroup;
		_null = [_grp1S,getPos _uav, 150] call CBA_fnc_taskDefend;

		_grp2S = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Support_section")] call BIS_fnc_spawnGroup;
		_null = [_grp2S,getPos _uav, 200] call CBA_fnc_taskPatrol;

		_cars2 = createGroup INDEPENDENT;
		[_markerpos, 10, "LOP_ISTS_Landrover_M2", _cars2] call BIS_fnc_spawnvehicle;
		_null = [_cars2,getPos _uav, 700] call CBA_fnc_taskPatrol;
		sleep 10;
		[_markerpos, 10, "LOP_ISTS_Landrover_M2", _cars2] call BIS_fnc_spawnvehicle;

		_null = [west, "mob_uav", ["One of our drones has been shot down, retrieve its Intel and destroy the wreckage.", "Recover UAV", "Recover UAV"], getMarkerPos "uavmarker", false] call BIS_fnc_taskSetState;
		_null = ["mob_uav", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { !alive _device };

		_null = ["mob_uav", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerSO;
		deleteMarker _markeruav;
		{deleteVehicle _x} forEach units _grp1S;
		{deleteVehicle _x} forEach units _grp2S;
		{deleteVehicle _x} forEach units _cars2;
		deleteGroup _grp1S;
		deleteGroup _grp2S;
		deleteGroup _cars2;

	    ["SUPPORT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_uav"] call seven_fnc_removeTask;
	};

	case "pilotrescue": {

		hint "UPDATED SUPPORT OPS";
		//creating the marker

		_markerSO = createMarker ["mob_pilotrescue", _mrkSpawnPos];
		_markerSO setMarkerShape "Empty";
		_markerpos = getMarkerPos _markerSO;

		sleep 0.3;

		//creating the vehicle

		_helo = ["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Transport_01_camo_F"] call BIS_fnc_selectRandom;

		_newPos = [_markerpos, 0, 150, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_wreck = createVehicle [_helo, _newPos, [], 0, "none"];
		_wreck setDammage 1;
		_wreckpos = getPos _wreck;

		sleep 0.3;

		_newPos2 = [_markerpos, 300, 500, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_pilotgrp = createGroup WEST;
		_pilot1 = _pilotgrp createUnit ["B_helicrew_F", _newPos2, [], 0, "NONE"];
		_pilot1 setCaptive true;
		_pilot1 allowDamage false;
		_pilot1 setSkill 0;
		_pilot1 allowFleeing 1;
		{_pilot1 disableAI _x} forEach ["MOVE","ANIM","AUTOTARGET","TARGET","FSM"];
		[_pilot1,"escolta",true,true] call BIS_fnc_MP;

		_IRgren = createVehicle ["B_IRStrobe", _newPos2, [], 0, "NONE"];

		_signpl = createVehicle ["Sign_Sphere25cm_F",getPos _pilot1, [], 0, "NONE"];
		_signpl attachTo [_pilot1,[0,0,+5]];

		_markerpilot = ["pilotmarker", getPos _pilot1, "ICON", [0.7,0.7], "COLOR:", "ColorBlue", "TEXT:", "Pilot CSAR", "TYPE:", "hd_join", "PERSIST"] call CBA_fnc_createMarker;

		sleep 0.3;

		_grp1S = [_wreckpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Support_section")] call BIS_fnc_spawnGroup;
		_null = [_grp1S,_wreckpos, 150] call CBA_fnc_taskDefend;

		_grp2S = [_wreckpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Support_section")] call BIS_fnc_spawnGroup;
		_null = [_grp2S,_wreckpos, 250] call CBA_fnc_taskPatrol;

		_cars3 = createGroup INDEPENDENT;
		[_markerpos, 10, "LOP_ISTS_Landrover_M2", _cars3] call BIS_fnc_spawnvehicle;
		_null = [_cars3,_wreckpos, 500] call CBA_fnc_taskPatrol;
		sleep 10;
		[_markerpos, 10, "LOP_ISTS_Landrover_M2", _cars3] call BIS_fnc_spawnvehicle;

		_null = [west, "mob_pilotrescue", ["One of our choppers has been shot down, find the pilot and bring it to MASH in Main Camp.", "Pilot CSAR", "Pilot CSAR"], getMarkerPos "pilotmarker", false] call BIS_fnc_taskSetState;
		_null = ["mob_pilotrescue", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { _pilot1 distance getMarkerPos "mash" < 50 OR !alive _pilot1 };

		if (!alive _men1) exitWith {_null = ["mob_pilotrescue", "FAILED"] call BIS_fnc_taskSetState; deleteMarker _markerSO; deleteMarker _markerpilot; {deleteVehicle _x} forEach units _grp1S; {deleteVehicle _x} forEach units _grp2S; {deleteVehicle _x} forEach units _cars3; deleteGroup _grp1S; deleteGroup _grp2S; deleteGroup _cars3; deleteVehicle _wreck; deleteVehicle _camilla; deleteVehicle _pilot1; deleteGroup _pilotgrp; deleteVehicle _signpl; deleteVehicle  (nearestobject [_newPos2,"nvg_targetC"]); [west, "mob_pilotrescue"] call seven_fnc_removeTask;};

		[_pilot1] join grpNull;

		_null = ["mob_pilotrescue", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerSO;
		deleteMarker _markerpilot;
		{deleteVehicle _x} forEach units _grp1S;
		{deleteVehicle _x} forEach units _grp2S;
		{deleteVehicle _x} forEach units _cars3;
		deleteGroup _grp1S;
		deleteGroup _grp2S;
		deleteGroup _cars3;
		deleteVehicle _wreck;
		deleteVehicle _pilot1;
		deleteVehicle _signpl;
		deleteGroup _pilotgrp;
		deleteVehicle  (nearestobject [_newPos2,"nvg_targetC"]);

	    ["SUPPORT OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_pilotrescue"] call seven_fnc_removeTask;
	};
};