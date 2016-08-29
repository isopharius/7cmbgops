/*
230mm Rockets
High Angle
*/

params ["_distance"];
// Output array
_out = [];
_charge = "";
// Minumum delay before firing a shot
_timeBetweenRounds = 0.1;
_minimumRange = 500;
_maximumRange = 18000;

_index = 0;
_modes = ["Close","Medium"];

if ((_distance >= 500) AND (_distance < 4500)) then {_index = 0};
if ((_distance >= 4500) AND (_distance < 18000)) then {_index = 1};

_charge = _modes select _index;
_out = [_charge,_timeBetweenRounds,_minimumRange,_maximumRange];
_out