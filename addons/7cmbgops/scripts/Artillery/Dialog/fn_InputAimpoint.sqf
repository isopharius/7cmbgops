_x = "";
_y = "";
_x1 = 0;
_y1 = 0;

// X coordinate
_x = ctrlText 402;
_x1 = parseNumber _x;
if (_x1 > 0) then {dtaX = _x1};

// Y coordinate
_y = ctrlText 403;
_y1 = parseNumber _y;
if (_y1 > 0) then {dtaY = _y1};

dtaElevation = getTerrainHeightASL [(_x1 * 10),(_y1 * 10)];

if ((dtaX isEqualTo 0) or (dtaY isEqualTo 0)) exitWith {hint "ERROR: invalid X and/or Y coordinates"};
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

/*	if (_distance > 5000) then {_errorSize = 100};
	if (_distance > 10000) then {_errorSize = 150};
	if (_distance > 15000) then {_errorSize = 200};
*/
	_errorPos = [_pos,_errorSize] call dta_fnc_CircularSheaf;
	sleep 0.3;
	dtaX = _errorPos select 0;
	dtaY = _errorPos select 1;
	dtaX = dtaX / 10;
	dtaY = dtaY / 10;
};

dtaHaveAimpoint = true;
[false] spawn seven_fnc_ControlAsset;