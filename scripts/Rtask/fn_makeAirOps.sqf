//////////////////////////////////////
//----ALiVE NATOFOR Random Tasks----//
//---By Valixx, Kylania & M4RT14L---//
//---------------v2.4---------------//
//////////////////////////////////////

_mrkSpawnSite = [_this, 0, ""] call BIS_fnc_param;
_missionType = [_this, 1, ""] call BIS_fnc_param;

_myHint ="Incoming Air Mission";
GlobalHint = _myHint;
publicVariable "GlobalHint";
hintsilent parseText _myHint;

sleep 5;

switch (_missionType) do {
	case "arty": {

		hint "UPDATED AIR OPS";
		//creating the marker

		_markerAO = createMarker ["mob_arty", _mrkSpawnSite];
		_markerAO setMarkerType "Empty";
		_markerpos = getMarkerPos _markerAO;

		sleep 0.3;

		//creating the vehicle

		_isFlat_arty = [_markerpos,500] call ALiVE_fnc_findFlatArea;

		_newPos3 = [_markerpos, 400, 500, 10, 0, 10, 0] call BIS_fnc_findSafePos;

		_radiohq = createVehicle ["Land_Jbad_hangar_2",[(_markerpos select 0) + 1, _markerpos select 1,0],[], 0, "NONE"];
		_radiohq setPos _isFlat_arty;
		_radiopos = getPos _radiohq;

		_markerarty = ["artymarker", _radiopos, "ICON", [1,1], "COLOR:", "ColorRed", "TEXT:", "Mobile Artillery", "TYPE:", "o_art", "PERSIST"] call CBA_fnc_createMarker;

		_arty1 = createVehicle ["RHS_BM21_MSV_01",[(_radiopos select 0) + 25, _radiopos select 1,0],[], 0, "NONE"];
		_arty1 setFuel 0;
		_arty1 setDamage 0;

		_arty2 = createVehicle ["RHS_BM21_MSV_01",[(_radiopos select 0) - 25, _radiopos select 1,0],[], 0, "NONE"];
		_arty2 setFuel 0;
		_arty2 setDamage 0;

		_camonet1 = createVehicle ["CamoNet_OPFOR_big_F", getPos _arty1, [], 0, "can_collide"];
		_camonet2 = createVehicle ["CamoNet_OPFOR_big_F", getPos _arty2, [], 0, "can_collide"];

		_armor = createGroup INDEPENDENT;
		_crew1 = _armor createUnit ["LOP_ISTS_Infantry_Engineer", [0,0,1], [], 0, "none"];
		_crew1 moveInDriver _arty1;
		_crew2 = _armor createUnit ["LOP_ISTS_Infantry_Engineer", [0,0,1], [], 0, "none"];
		_crew2 moveInDriver _arty2;

		_grp1A = [_markerpos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_ISTS" >> "Infantry" >> "LOP_ISTS_Patrol_section")] call BIS_fnc_spawnGroup;
		_null = [_grp1A,_radiopos] call CBA_fnc_taskDefend;

		_cars1 = createGroup INDEPENDENT;
		[_newPos3, 10, "LOP_ISTS_Offroad_M2", _cars1] call BIS_fnc_spawnvehicle;
		_null = [_cars1,getPos _arty1, 300] call CBA_fnc_taskPatrol;
		sleep 10;
		[_newPos3, 10, "LOP_ISTS_Offroad_M2", _cars1] call BIS_fnc_spawnvehicle;

		_null = [west, "mob_arty", ["Must destroy two opfor MAT", "Destroy Artillery", "Destroy Artillery"], getMarkerPos "artymarker", false] call BIS_fnc_taskSetState;
		_null = ["mob_arty", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { !alive _arty1 && !alive _arty2 };

		_null = ["mob_arty", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerAO;
		deleteMarker _markerarty;
		{deleteVehicle _x} forEach units _grp1A;
		{deleteVehicle _x} forEach units _cars1;
		deleteGroup _grp1A;
		deleteGroup _cars1;
		deleteGroup _armor;
		deleteVehicle _radiohq;
		deleteVehicle _camonet1;
		deleteVehicle _camonet2;

	    ["AIR OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_arty"] call seven_fnc_removeTask;
	};

	case "cas": {

		hint "AIR OPS UPDATED";
		//creating the marker

		_markerAO = ["mob_cas", _mrkSpawnSite, "ICON", [1,1], "COLOR:", "ColorRed", "TEXT:", "OPFOR Armor Ptn", "TYPE:", "o_armor", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerAO;

		sleep 0.3;

		//creating the vehicle

		_newPos = [_markerpos, 300, 700, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_camp = smallcamps call BIS_fnc_selectRandom;
		_mhq = [_camp] call ALIVE_fnc_findComposition;
		_direction = random 360;
		if(count _mhq > 0) then {
            [_mhq, _markerpos, _direction] call ALIVE_fnc_spawnComposition;
        };

		_tanques1 = createGroup INDEPENDENT;
		[_newPos, 10, "LOP_ISTS_T72BA", _tanques1] call BIS_fnc_spawnvehicle;
		_null = [_tanques1, _markerpos, 150] call CBA_fnc_taskPatrol;
		sleep 10;
		[_newPos, 10, "LOP_ISTS_T72BA", _tanques1] call BIS_fnc_spawnvehicle;
		sleep 10;
		[_newPos, 10, "LOP_ISTS_BTR60", _tanques1] call BIS_fnc_spawnvehicle;
		sleep 10;
		[_newPos, 10, "LOP_ISTS_BTR60", _tanques1] call BIS_fnc_spawnvehicle;
		sleep 10;
		[_newPos, 10, "LOP_ISTS_BTR60", _tanques1] call BIS_fnc_spawnvehicle;

		_null = [west, "mob_cas", ["Destroy the OPFOR armor platoon", "Destroy Armor", "Destroy Armor"], getMarkerPos "mob_cas", false] call BIS_fnc_taskSetState;
		_null = ["mob_cas", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil {{ alive _x } count units _tanques1 <= 5};

		_null = ["mob_cas", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerAO;
		{deleteVehicle _x} forEach units _tanques1;
		deleteGroup _tanques1;

	    ["AIR OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_cas"] call seven_fnc_removeTask;
	};

	case "convoy": {

		hint "UPDATED AIR OPS";
		//creating the marker

		_markerAO = ["mob_convoy", _mrkSpawnSite, "ICON", [1,1], "COLOR:", "ColorRed", "TEXT:", "Supply Convoy", "TYPE:", "o_support", "PERSIST"] call CBA_fnc_createMarker;
		_markerpos = getMarkerPos _markerAO;

		sleep 0.3;

		//creating the vehicle

		_newPos = [_markerpos, 500, 700, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_shed2 = createVehicle ["Land_Jbad_hangar_2",[(_markerpos select 0) + 10, _markerpos select 1,0],[], 0, "NONE"];

		_convoy1 = createGroup INDEPENDENT;
		[_newPos, 10, "LOP_ISTS_BTR60", _convoy1] call BIS_fnc_spawnvehicle;
		_null = [_convoy1,getPos _shed2, 300] call CBA_fnc_taskPatrol;
		sleep 15;
		[_newPos, 10, "LOP_AM_Landrover", _convoy1] call BIS_fnc_spawnvehicle;
		sleep 15;
		[_newPos, 10, "LOP_AM_Landrover", _convoy1] call BIS_fnc_spawnvehicle;
		sleep 15;
		[_newPos, 10, "LOP_AM_Landrover", _convoy1] call BIS_fnc_spawnvehicle;
		sleep 15;
		[_newPos, 10, "LOP_AM_Landrover", _convoy1] call BIS_fnc_spawnvehicle;
		sleep 15;
		[_newPos, 10, "LOP_AM_Landrover_M2", _convoy1] call BIS_fnc_spawnvehicle;

		_null = [west, "mob_convoy", ["Attack and destroy the supply convoy", "Eliminate Convoy", "Eliminate Convoy"], getMarkerPos "mob_convoy", false] call BIS_fnc_taskSetState;
		_null = ["mob_convoy", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil {{ alive _x } count units _convoy1 <= 3};

		_null = ["mob_convoy", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 10;

		deleteMarker _markerAO;
		deleteGroup _convoy1;
		deleteVehicle _shed2;

	    ["AIR OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_convoy"] call seven_fnc_removeTask;
	};

	case "warehouse": {

		hint "UPDATED AIR OPS";
		//creating the marker

		_markerAO = createMarker ["mob_placement", _mrkSpawnSite];
		_markerAO setMarkerType "Empty";
		_markerpos = getMarkerPos _markerAO;

		sleep 0.3;

		//creating the vehicle

		_newPos = [_markerpos, 200, 300, 10, 0, 0, 0] call BIS_fnc_findSafePos;

		_isFlat_warehouse = [_markerpos,200] call ALiVE_fnc_findFlatArea;

		_warehouse = createVehicle ["Land_Ind_Quarry",[(_markerpos select 0) + 1, _markerpos select 1,0],[], 0, "NONE"];
		_warehouse setDamage 0.9;
		_warehouse setPos _isFlat_warehouse;
		_warehousepos = getPos _warehouse;

		_markerwarehouse = ["warehousemarker", _warehousepos, "ICON", [1,1], "COLOR:", "ColorRed", "TEXT:", "Insurgent Depot", "TYPE:", "o_support", "PERSIST"] call CBA_fnc_createMarker;

		_truck1 = createVehicle ["LOP_AM_Landrover",[(_warehousepos select 0) + 15, _warehousepos select 1,0],[], 0, "NONE"];

		_grp1A = [_warehousepos, INDEPENDENT, (configfile >> "CfgGroups" >> "INDEP" >> "LOP_IT" >> "Infantry" >> "LOP_ISTS_Rifle_squad")] call BIS_fnc_spawnGroup;
		_null = [_grp1A,_warehousepos] call CBA_fnc_taskDefend;

		_AA2 = createGroup INDEPENDENT;
		[_newPos, 10, "LOP_ISTS_Offroad_M2", _AA2] call BIS_fnc_spawnvehicle;
		_null = [_AA2,_warehousepos, 150] call CBA_fnc_taskPatrol;
		sleep 15;
		[_newPos, 10, "LOP_ISTS_Offroad_M2", _AA2] call BIS_fnc_spawnvehicle;

		_null = [west, "mob_placement", ["Eliminate the OPFOR Depot.", "Eliminate Depot", "Eliminate Depot"], getMarkerPos "warehousemarker", false] call BIS_fnc_taskSetState;
		_null = ["mob_placement", "CREATED"] call BIS_fnc_taskSetState;

		waitUntil { !alive _warehouse };

		_null = ["mob_placement", "SUCCEEDED"] call BIS_fnc_taskSetState;

		sleep 3;

		_sbomb1 = createVehicle ["R_60mm_HE", (getPos _truck1), [], 0, "can_collide"];
		_truck1 setDammage 1;

		sleep 10;

		deleteMarker _markerAO;
		deleteMarker _markerwarehouse;
		{deleteVehicle _x} forEach units _grp1A;
		{deleteVehicle _x} forEach units _AA2;
		deleteGroup _grp1A;
		deleteGroup _AA2;

	    ["AIR OBJECTIVE COMPLETED", "sideChat", true, false, true] call BIS_fnc_MP;

		[west, "mob_placement"] call seven_fnc_removeTask;
	};
};