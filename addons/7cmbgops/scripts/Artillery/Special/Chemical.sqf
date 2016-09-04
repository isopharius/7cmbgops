private ["_shell","_units","_unit","_vulnerable","_time"];
disableSerialization;

params ["_inputArray", "_pos"];
_shell = _inputArray select 6;

while {alive _shell} do {
	_pos = getPosATL _shell;
	sleep 0.5;
};

//_vulnerable = ["Man", "Air", "Car", "Motorcycle", "Tank"];
_vulnerable = ["CAManBase", "Air", "Car", "Motorcycle"];
_units = [];
// Units of 5 seconds
private _time = 12;
while {(_time > 0)} do {
	_units = _pos nearEntities [_vulnerable,300];
	_unit = objNull;
	systemChat format ["%1",_units];
	while {((count _list) > 0)} do {
		_unit = _units select 0;
		_units = _units - [_unit];
		if NOT(_unit in dtaVictimsChem) then {
			dtaVictimsChem pushBack _unit;
			[_unit] call dta_fnc_ChemicalDamage;
		};
	};
	sleep 5;
};