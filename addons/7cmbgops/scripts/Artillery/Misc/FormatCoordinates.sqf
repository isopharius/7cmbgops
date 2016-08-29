// Changes an integer into a 3-digit text value (eg. 23 becomes "023")

private["_output","_prefix"];
params ["_number"];
_output = "";
_prefix = "";
if (_number < 1000) then {_prefix = "0"};
if (_number < 100) then {_prefix = "00"};
if (_number < 10) then {_prefix = "000"};
_output = format ["%1%2",_prefix,_number];
//player sideChat format ["output: %1",_output];
_output