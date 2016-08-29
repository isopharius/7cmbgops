params ["_asset"];
_tubes = [];
_tube = objNull;
_tubes = [_asset] call dta_fnc_GroupVehicles;

while {((count _tubes) > 0)} do {
	_tube = _tubes select 0;
	_tubes = _tubes - [_tube];
	[_tube] execVM "\7cmbgops\scripts\Artillery\Test\MarkTube.sqf";
};