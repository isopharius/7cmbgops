// Forces a tube to load a certain magazine type by deleting all magazines and adding the desired one first
// It is a clumsy workaround, but BIS does not have a reliable command to do this
// Some code based off Smarter Tanks by Alarm9k

private [/*"_magazineRounds",_allMagazines",*/"_omitOnce","_newMagazines","_index","_add","_magazine"];

params ["_tube", "_magazineType"];

if ((currentMagazine _tube) isEqualTo _magazineType) exitWith {
		_tube setVehicleAmmo 1;
};

[
	[_tube, _magazineType],
	{
		params ["_tube", "_magazineType"];
		_tube loadMagazine [[0], (_tube weaponsTurret [0]) select 0, _magazineType];
		_tube setVehicleAmmo 1;
	}
] remoteExecCall ["bis_fnc_call", _tube, false];