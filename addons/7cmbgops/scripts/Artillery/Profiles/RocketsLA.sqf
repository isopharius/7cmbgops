/*
230mm Rockets
Low angle
*/

params ["_distance"];
// Output array
_out = [];
_charge = "";
// Minumum delay before firing a shot
_timeBetweenRounds = 0.1;
_minimumRange = 100;
_maximumRange = 20000;

_index = 0;
_modes = ["Close","Medium"];

if ((_distance >= 100) && {(_distance < 500)}) then {_index = 0};
if ((_distance >= 500) && {(_distance < 20000)}) then {_index = 1};

_charge = _modes select _index;
_out = [_charge,_timeBetweenRounds,_minimumRange,_maximumRange];
_out