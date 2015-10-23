private "_tpvar";

{
	call {
		if ((_x find "respawn" > -1) || (_x find "tp" > -1)) exitWith { //all tp flags

			if (!isdedicated) then { //clientside arsenal box and flag at tp marker with name
				private ["_markerpos","_markerposx","_markerposy","_tpname","_crate","_tpflag"];

				_markerpos = getmarkerpos _x;
				_markerposx = _markerpos select 0;
				_markerposy = _markerpos select 1;
				_tpname = markertext _x;

				_crate = "B_CargoNet_01_ammo_F" createvehiclelocal [_markerposx - 1, _markerposy - 1];
				_crate allowdamage false;
				_tpflag = "Land_FieldToilet_F" createvehiclelocal _markerpos;
				_tpflag allowdamage false;

				if isnil("_tpvar") then { //first flag, create array
					_tpvar = [[_tpflag, _tpname]];

				} else { //not first flag, add to array

					_tpvar pushback [_tpflag, _tpname];
				};
			};

			if ((isserver) && !(_x find "respawn" > -1)) then { //add tp respawn
				[missionnamespace, _x] call BIS_fnc_addRespawnPosition;
			};
		};

		if ((isserver) && (_x find "mash" > -1)) exitWith { //create med facility at mash marker
			private ["_mashpos","_mashdir","_mash"];

			_mashpos = getmarkerpos _x;
			_mashdir = markerdir _x;
			_mash = createVehicle ["Land_Medevac_house_V1_F", _mashpos, [], 0, "none"];
			_mash allowdamage false;
			_mash setdir _mashdir;
		};
	};
} foreach allmapmarkers;

//tp actions

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