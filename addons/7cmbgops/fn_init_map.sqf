if (isHC) exitwith {};

{
		if ((_x find "respawn" > -1) || (_x find "tp" > -1)) then { //all tp flags

			if (!isdedicated) then { //clientside arsenal box and flag at tp marker with name
				_markerpos = getmarkerpos _x;
				_tpname = markertext _x;

				_crate = "B_CargoNet_01_ammo_F" createvehiclelocal [0,0,0];
				_crate allowdamage false;
				_crate setPos [(_markerpos select 0) - 2.5, (_markerpos select 1) - 2.5];
				_tpflag = "Land_FieldToilet_F" createvehiclelocal [0,0,0];
				_tpflag allowdamage false;
				_tpflag setPos _markerpos;

				if isnil("_tpvar") then { //first flag, create array
					_tpvar = [[_tpflag, _tpname]];

				} else { //not first flag, add to array

					_tpvar pushback [_tpflag, _tpname];
				};
			};

			if ((isserver) && !(_x find "respawn" > -1)) then { //add tp respawn
				[missionnamespace, _x] call BIS_fnc_addRespawnPosition;
			};

		} else {
			if ((isserver) && (_x find "mash" > -1)) then { //create med facility at mash marker
				_mash = createVehicle ["Land_Medevac_house_V1_F", [0,0,0], [], 0, "none"];
				_mash allowdamage false;
				_mash setPos (getmarkerpos _x);
				_mash setdir (markerdir _x);
			};
		};
} foreach allmapmarkers;

//tp actions
/*
if (!isdedicated) then { //clientside teleport actions
	{
		private ["_tpactions","_y"];

		//add action for every other flag
		_tpactions = _tpvar - [_x];
		_y = _x select 0;
		{
			_y addaction [format ["Teleport - %1", (_x select 1)],seven_fnc_Teleport,[(_x select 0)],1,true,true,'','_this distance _target < 6'];
		} foreach _tpactions;
	} foreach _tpvar;
};
*/
