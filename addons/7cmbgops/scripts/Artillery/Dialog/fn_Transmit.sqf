// Called from the Transmit button

if (dtaSelectedAsset in dtaAssetsBusy) exitWith {(leader dtaSelectedAsset) sideChat "Negative, processing other orders."};

_prePlotted = dtaPrePlotted;
dtaPrePlotted = false;

_iccCode = 200;

// Warhead type
_index = lbCurSel (_iccCode + 6);
_warheadType = lbData [(_iccCode + 6),_index];
dtaLastWarheadType = _warheadType;
//systemChat format ["%1 - %2",_warheadType,dtaLastWarheadType];sleep 3;

// Rounds to fire
_rounds = ctrlText (_iccCode + 7);
dtaRounds = parseNumber _rounds;
// Used so SPOT missions don't change the player setting
_rounds2 = dtaRounds;

if (_rounds2 isEqualTo 0) exitWith {hint "Error: zero rounds"};

// Mission type
_index = lbCurSel (_iccCode + 8);
_missionType = lbData [(_iccCode + 8),_index];
if (_missionType isEqualTo "SPOT") then {_rounds2 = 1};
dtaMissionType = lbData [(_iccCode + 8),_index];

// Low/high angle
_angle = "";
_index = lbCurSel (_iccCode + 9);
dtaAngle = lbData [(_iccCode + 9),_index];
_angle = dtaAngle;

// Elevation
//_elevation = ctrlText (_iccCode + 10);
//dtaElevation = parseNumber _elevation;

// Sheaf
_sheaf = "";
_index = lbCurSel (_iccCode + 11);
_sheaf = lbData [(_iccCode + 11),_index];

// Fuse
_fuse = "";
_index = lbCurSel (_iccCode + 12);
_fuse = lbData [(_iccCode + 12),_index];

_sizeX = "";
_sizeX2 = 0;
_sizeY = "";
_sizeY2 = 0;
if (_prePlotted) then {_sizeX2 = dtaSheafSize select 0; _sizeY2 = dtaSheafSize select 1}
	else
{
	// Sheaf size X
	_sizeX = ctrlText (_iccCode + 13);
	_sizeX2 = parseNumber _sizeX;
	// Sheaf size Y
	_sizeY = ctrlText (_iccCode + 14);
	_sizeY2 = parseNumber _sizeY;
};
if ((_sheaf isEqualTo "BOX") AND {(_sizeX2 isEqualTo 0)}) exitWith {hint "INVALID SHEAF SIZE X"};
if ((_sheaf isEqualTo "CIRC") AND {(_sizeX2 isEqualTo 0)}) exitWith {hint "INVALID SHEAF SIZE Y"};
if (_sizeX2 < 0) exitWith {hint "INVALID SHEAF SIZE X"};
if (_sizeY2 < 0) exitWith {hint "INVALID SHEAF SIZE Y"};
_sheafSize = [_sizeX2,_sizeY2];

// Airburst height
_airburstHeight = "";
_index = lbCurSel (_iccCode + 15);
_airburstHeight = lbData [(_iccCode + 15),_index];

_distance = 0;
_distance2 = 0;
_vx = 0;
_vy = 0;
_dx = 0;
_dy = 0;

_vx = getPos (vehicle leader dtaSelectedAsset) select 0;
_vy = getPos (vehicle leader dtaSelectedAsset) select 1;
_dx = (dtaX * 10) - _vx;
_dy = (dtaY * 10) - _vy;
_distance = sqrt((_dx*_dx)+(_dy*_dy));

_pos = [];
_pos = [dtaX,dtaY,dtaElevation];

if (dtaMissionType isEqualTo "SPOT") then {_rounds2 = 1};
_sender = player;
_missionTime = [];
_timeStamp = [(date select 3),(date select 4)];

if NOT(_warheadType in dtaAirburstRounds) then {_fuse = "IMPACT"};

_posDisplay = [dtaXdisplay,dtaYdisplay];
_firstRound = true;
_firstRound = dtaFirstRound;
dtaNewFireMission = [dtaSelectedAsset,_pos,_warheadType,_rounds2,_distance,_missionType,_angle,_sender,_timeStamp,_prePlotted,_sheaf,_fuse,_sheafSize,_posDisplay,_airburstHeight,_firstRound];

dtaFireMissionCurrent = dtaNewFireMission;
dtaNewFireMission spawn seven_fnc_ProcessFireMission;

// Subsequent rounds will be faster
dtaFirstRound = false;

_missionType = "FIRE FOR EFFECT";
if (dtaMissionType isEqualTo "SPOT") then {_missionType = "SPOTTING ROUND"; _rounds2 = 1};
if (dtaMissionType isEqualTo "PLOT") then {_missionType = "FIRE MISSION PLOT"};

_xText = "";
_yText = "";

_xText = [(_posDisplay select 0)] call dta_fnc_FormatCoordinates;
_yText = [(_posDisplay select 1)] call dta_fnc_FormatCoordinates;

player sideChat format ["Requesting %1 at grid %2,%3",_missionType,_xText,_yText];
dtaPrePlotted = false;
sleep 0.1;
closeDialog 0;
hint "";