// Called from AdustSend button
private["_xAdj","_x","_yAdj","_y","_targetPos","_adjusterPos","_dir","_distance","_vx","_vy","_dx","_dy","_adjDist","_newX","_newY","_posTemp"];

// X adjustment (left/right)
_xAdj = ctrlText 204;
_x = parseNumber _xAdj;

// Y adjustment (up/down)
_yAdj = ctrlText 205;
_y = parseNumber _yAdj;

_targetPos = [(dtaX * 10),(dtaY * 10)];
if (dtaDebug) then {[_targetPos,90] call dta_fnc_PlaceMarker};

// This can be the asset or the spotter
_adjusterPos = [];
// The default setting currently is the spotter
_adjusterPos = getPos player;
// Use this for the battery instead
//_adjusterPos = getPos (vehicle leader dtaSelectedAsset);

// Direction from asset to target
_dir = 0;
_dir = [_adjusterPos,_targetPos] call dta_fnc_GetDirection;
// Find the distance from artillery to current aimpoint
_distance = 0;

// Spotter position
_vx = 0;_vy = 0;_dx = 0;_dy = 0;
_vx = (getPos player) select 0;
_vy = (getPos player) select 1;
// Firing asset position
//_vx = 0;_vy = 0;_dx = 0;_dy = 0;
//_vx = getPos (vehicle leader dtaSelectedAsset) select 0;
//_vy = getPos (vehicle leader dtaSelectedAsset) select 1;

// Distance calculation
// target coordinates - asset lead vehicle position
_dx = (dtaX * 10) - _vx;
_dy = (dtaY * 10) - _vy;
_distance = sqrt((_dx * _dx) + ( _dy * _dy));
sleep 0.5;

_adjDist = 0;
_newX = 0;
_newY = 0;

_adjDist = _distance + _y;
_newX = (_vx) + _adjDist * sin(_dir);
_newY = (_vy) + _adjdist * cos(_dir);

_dtaX = 0;
_dtaY = 0;
dtaX = (_newX) - _x * sin(_dir - 90);
dtaY = (_newY) - _x * cos(_dir - 90);
sleep 0.5;
_posTemp = [dtaX,dtaY];
//player setPos _posTemp;
if (dtaDebug) then {[_posTemp,90] call dta_fnc_PlaceMarker};

dtaX = dtaX / 10;
dtaY = dtaY / 10;

player sideChat "Adjust fire.";
[] call seven_fnc_ClearAdjust;