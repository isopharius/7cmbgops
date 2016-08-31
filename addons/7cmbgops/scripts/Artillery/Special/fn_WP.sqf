private["_shell","_units","_unit","_vulnerable","_time"];

params ["_inputArray", "_pos"];
_shell = _inputArray select 6;

while {alive _shell} do {
	_pos = getPosATL _shell;
	sleep 0.5;
};

//_vulnerable = ["Man", "Air", "Car", "Motorcycle", "Tank"];
_vulnerable = ["CAManBase","Motorcycle"];
_units = [];
// Units of 5 seconds
_time = 10;
while {(_time > 0)} do {
	_units = _pos nearEntities [_vulnerable,20];
	_unit = objNull;
	while {((count _units) > 0)} do {
		_unit = _units select 0;
		_units = _units - [_unit];
		//[(vehicle _unit] call dta_fnc_WPdamage;
		_unit setDamage ((getDammage _unit) + 0.1);
		_unit setFatigue ((getFatigue _unit) + 0.1);
		//systemChat format ["WP: %1",_unit];
	};
	_time = _time - 1;
	sleep 5;
};