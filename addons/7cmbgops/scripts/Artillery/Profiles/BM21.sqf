/*
RHS BM21 Rockets
Low angle
*/

params ["_distance"];
// Output array
_out = [];
_charge = "";
_timeBetweenRounds = 0.1;
_minimumRange = 100;
_maximumRange = 20000;

_index = 0;
_modes = ["Close","m1","m1a","m2","m3","m4","m5","m6","m7","m8","m9","m10","m11"];

if ((_distance > 99) && {(_distance <= 1100)}) then {_index = 0};
if ((_distance > 1100) && {(_distance <= 1500)}) then {_index = 1};
if ((_distance > 1500) && {(_distance <= 2000)}) then {_index = 2};
if ((_distance > 2000) && {(_distance <= 2600)}) then {_index = 3};
if ((_distance > 2600) && {(_distance <= 3400)}) then {_index = 4};
if ((_distance > 3400) && {(_distance <= 4600)}) then {_index = 5};
if ((_distance > 4600) && {(_distance <= 5900)}) then {_index = 6};
if ((_distance > 5900) && {(_distance <= 7400)}) then {_index = 7};
if ((_distance > 7400) && {(_distance <= 9000)}) then {_index = 8};
if ((_distance > 9000) && {(_distance <= 11200)}) then {_index = 9};
if ((_distance > 11200) && {(_distance <= 13200)}) then {_index = 10};
if ((_distance > 13200) && {(_distance <= 16500)}) then {_index = 11};
if ((_distance > 16500) && {(_distance <= 20000)}) then {_index = 12};

_charge = _modes select _index;
_out = [_charge,_timeBetweenRounds,_minimumRange,_maximumRange];
_out