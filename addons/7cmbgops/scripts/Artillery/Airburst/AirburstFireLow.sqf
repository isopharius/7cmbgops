private["_projectile","_pos","_height"];
disableSerialization;
params ["_tube"];
_projectile = _this select 6;
_height = "LOW";
[_tube,_projectile,_height] execVM "\7cmbgops\scripts\Artillery\Airburst\AirburstFire2.sqf";