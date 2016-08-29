params ["_unit"];
_ammo = _this select 4;
_round = nearestobject [_unit,_ammo];
//player sideChat "FIRED";
dtaTestShots = dtaTestShots + 1;
[_unit,_round] execVM "\7cmbgops\scripts\Artillery\Test\Track.sqf";
//player sideChat format ["Round velocity:  %1",((velocity _round) select 2)];