params ["_inputArray", "_action", "_pos"];

//hint format ["ACT: %1",_action];systemChat format ["ACT: %1",_action];
//systemChat format ["ACT: %1",_action];systemChat format ["ACT: %1",_action];
// Laser guided
if (_action isEqualTo 1) exitWith {[_inputArray,_pos] execVM "\7cmbgops\scripts\Artillery\Special\LaserGuided.sqf"};
// WP
if (_action isEqualTo 2) exitWith {[_inputArray,_pos] execVM "\7cmbgops\scripts\Artillery\Special\WP.sqf"};
// Self-guided
if (_action isEqualTo 3) exitWith {[_inputArray,_pos] execVM "\7cmbgops\scripts\Artillery\Special\SelfGuided.sqf"};