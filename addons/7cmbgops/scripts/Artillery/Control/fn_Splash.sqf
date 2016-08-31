params ["_flightTime", "_asset"];

_flightTime = _flightTime - 5;
if (_flightTime < 1) then {_flightTime = 1};
sleep _flightTime;
[_asset,"Splash, out.","Splash"] call dta_fnc_SendComms;
