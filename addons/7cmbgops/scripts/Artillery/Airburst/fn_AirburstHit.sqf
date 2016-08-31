// Called from \7cmbgops\scripts\Artillery\Airburst\AirburstFire2.sqf

params ["_airburstLocation", "_explosionSize", "_shrapnelInfo", "_concentration", "_effectiveRange", "_maxRange", "_fallOff"];

// 1 is default - no if statement required.
_airburstMunition = "HelicopterExploSmall";
if (_explosionSize isEqualTo 2) then {_airburstMunition = "HelicopterExploBig"};
_shrapnelfired = createVehicle [_airburstMunition, _airburstLocation, [], 0, "CAN_COLLIDE"];

[_airburstLocation,_concentration,_effectiveRange,_maxRange,_falloff] call seven_fnc_CallShrapnel;