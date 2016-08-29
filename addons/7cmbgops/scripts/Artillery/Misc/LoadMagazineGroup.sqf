private ["_tube","_tubes"];
params ["_group", "_magazineType"];

//if (dtaDebug) then {systemChat "Group loading new mags"};

_tube = objNull;
_tubes = [];
_tubes = [_group] call dta_fnc_GroupVehicles;

//_tube = _tubes select 0;
//[_tube,_magazineType] call dta_fnc_LoadMagazine;

{[_x,_magazineType] call dta_fnc_LoadMagazine} forEach _tubes;
//{[_x,_magazineType,_pos] call dta_fnc_LoadMagazine} forEach _tubes;