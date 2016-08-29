/*
82mm mortar
High Angle (Low angle not possible)
*/

params ["_distance"];
// Output array
_out = [];
_charge = "";
// Minumum delay before firing a shot
_timeBetweenRounds = 5;
_minimumRange = 100;
_maximumRange = 4000;
_index = 0;
_modes = ["Single1","Single2","Single3"];

if ((_distance >= 100) AND (_distance < 500)) then {_index = 0};
if ((_distance >= 500) AND (_distance < 2000)) then {_index = 1};
if ((_distance >= 2000) AND (_distance < 4001)) then {_index = 2};

_charge = _modes select _index;
_out = [_charge,_timeBetweenRounds,_minimumRange,_maximumRange];
_out