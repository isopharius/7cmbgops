private ["_tube","_tubes"];
params ["_group", "_magazineType"];

_tube = objNull;
_tubes = [];
_tubes = [_group] call dta_fnc_GroupVehicles;

{[_x,_magazineType] call dta_fnc_LoadMagazine} forEach _tubes;