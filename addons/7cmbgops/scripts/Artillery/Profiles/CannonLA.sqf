/*
155mm Howitzer
Low Angle
*/

params ["_distance"];

// Output array
_out = [];
_charge = "";
// Minumum delay before firing a shot
_timeBetweenRounds = 5;
_minimumRange = 500;
_maximumRange = 20000;
_index = 0;
_modes = ["Single1","Single2","Single3","Single3"];

if ((_distance >= 500) AND (_distance < 2000)) then {_index = 0};
if ((_distance >= 2000) AND (_distance < 6000)) then {_index = 1};
if ((_distance >= 6000) AND (_distance < 15000)) then {_index = 2};
if ((_distance >= 15000) AND (_distance < 20001)) then {_index = 3};

_charge = _modes select _index;
_out = [_charge,_timeBetweenRounds,_minimumRange,_maximumRange];
_out