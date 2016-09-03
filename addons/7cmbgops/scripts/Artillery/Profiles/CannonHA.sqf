/*
155mm Howitzer
High Angle
*/

params ["_distance"];

// Output array
_out = [];
_charge = "";
// Minumum delay before firing a shot
_timeBetweenRounds = 5;
_minimumRange = 750;
_maximumRange = 15000;

_index = 0;
_modes = ["Single1","Single2","Single3"];

if ((_distance >= 750) && {(_distance < 2000)}) then {_index = 0};
if ((_distance >= 2000) && {(_distance < 6000)}) then {_index = 1};
if ((_distance >= 6000) && {(_distance < 15001)}) then {_index = 2};

_charge = _modes select _index;
_out = [_charge,_timeBetweenRounds,_minimumRange,_maximumRange];
_out