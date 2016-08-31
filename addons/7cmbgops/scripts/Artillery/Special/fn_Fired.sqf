params ["_inputArray", "_action", "_pos"];

// Laser guided
if (_action isEqualTo 1) exitWith {[_inputArray,_pos] spawn seven_fnc_LaserGuided};
// WP
if (_action isEqualTo 2) exitWith {[_inputArray,_pos] spawn seven_fnc_WP};
// Self-guided
if (_action isEqualTo 3) then {[_inputArray,_pos] spawn seven_fnc_SelfGuided};