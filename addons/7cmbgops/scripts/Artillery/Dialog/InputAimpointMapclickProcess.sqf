// Called from DCE\Scripts\Command\.sqf
// Processes a map click for selecting units, issuing move orders or showing the dialog

params ["_pos"];

[_pos] execVM "\7cmbgops\scripts\Artillery\Dialog\InputAimpointMapclickEffect.sqf";

_x = 0;
_y = 0;

_x = _pos select 0;
_y = _pos select 1;

dtaElevation = getTerrainHeightASL [_x,_y];

dtaXreal = _x;
dtaYreal = _y;

_x = _x / 10;
_y = _y / 10;

// X coordinate
if (_x > 0) then {dtaX = _x};
// Y coordinate
if (_y > 0) then {dtaY = _y};

if ((dtaX == 0) or (dtaY == 0)) exitWith {hint "ERROR: invalid X and/or Y coordinates"};
if (dtaX > 9999.999) exitWith {hint "ERROR: X must be between 000 and 999"};
if (dtaY > 9999.999) exitWith {hint "ERROR: Y must be between 000 and 999"};

dtaXdisplay = dtaX;
dtaYdisplay = dtaY;

// Add some initial error to the target pos to simulate natural errors
_distance = 0;
_vx = 0;
_vy = 0;
_dx = 0;
_dy = 0;
_vx = getPos (vehicle leader dtaSelectedAsset) select 0;
_vy = getPos (vehicle leader dtaSelectedAsset) select 1;
_dx = (dtaX * 10) - _vx;
_dy = (dtaY * 10) - _vy;
_distance = sqrt((_dx*_dx)+(_dy*_dy));

_errorSize = 25;
_pos = [(dtaX * 10),(dtaY * 10)];
_errorPos = [];

_initialError = true;
if (_distance < 1000) then {_initialError = false};
if (dtaNoInitialInaccuracy) then {_initialError = false};
if (_initialError) then {
	if (_distance > 5000) then {_errorSize = 50};
	if (_distance > 10000) then {_errorSize = 75};
	if (_distance > 15000) then {_errorSize = 100};
	_errorPos = [_pos,_errorSize] call dta_fnc_CircularSheaf;
	sleep 0.3;
	dtaX = _errorPos select 0;
	dtaY = _errorPos select 1;
	dtaX = dtaX / 10;
	dtaY = dtaY / 10;
};

dtaHaveAimpoint = true;
_prePlotted = false;
[_prePlotted] execVM "\7cmbgops\scripts\Artillery\Dialog\ControlAsset.sqf";