// Called from DT\Artillery\Check.sqs
// Shows the artillery dialog

private["_iccCode","_assetName","_dialogName","_fireMission","_lastWarheadType","_rounds","_angle","_sheaf","_sheafSize","_fuse","_airburstHeight"];
private["_lastAngle","_lastWarheadType","_lastRounds","_lastAngle","_lastSheaf","_lastSheafSize","_lastFuse","_lastAirburstHeight"];
private["_lastWarheadTypeIndex","_lastRoundsIndex","_lastAngleIndex","_lastSheafIndex","_lastFuseIndex","_lastAirburstHeightIndex"];
private["_asset","_name","_tubes","_assetName","_tubeType","_x","_y","_pos","_xText","_yText","_dtaXtext","_dtaYtext"];
private["_list","_warheads","_warheadInfo","_roundType","_roundTypeClass","_roundsAvailable","_type","_types","_vehicle","_count"];
private["_missionTypes","_missionType","_angleTypes","_82mm","_cfgVehicles","_class","_sheafTypes","_sheafType","_fuseTypes","_fuseType","_airburstHeights"];
disableSerialization;

dtaLastDialog = "Control";
params ["_prePlotted"];

if (_prePlotted) then {dtaHaveAimpoint = true};

// Change icc code for normal (200) vs pre-plotted (300) dialogs
_iccCode = 200;

_assetName = format ["%1",dtaSelectedAsset];
if ((_asset isEqualTo "<NULL-group>") or (_asset isEqualTo "any")) exitWith {closeDialog 0; sleep 0.3; [] spawn seven_fnc_Assets;};

_dialogName = "dtaDialogControl";
createDialog _dialogName;

// Only required for pre-plotted missions
_fireMission = [];
_lastWarheadType = "";
_rounds = 0;
_angle = "";
_sheaf = "";
_sheafSize = [];
_fuse = "";
_airburstHeight = "";

_lastAngle = "";
_lastWarheadType = "";
_lastRounds = 0;
_lastAngle = "";
_lastSheaf = "";
_lastSheafSize = [];
_lastFuse = "";
_lastAirburstHeight = "";

_lastWarheadTypeIndex = 0;
_lastRoundsIndex = 0;
_lastAngleIndex = 0;
_lastSheafIndex = 0;
_lastFuseIndex = 0;
_lastAirburstHeightIndex = 0;

if (_prePlotted) then {
	_fireMission = dtaSelectedPrePlotted;
	_lastWarheadType = _fireMission select 2;
	_rounds = _fireMission select 3;
	_lastAngle = _fireMission select 6;
	_lastSheaf = _fireMission select 10;
	_lastFuse = _fireMission select 11;
	dtaSheafSize = _fireMission select 12;
	_lastAirburstHeight = _fireMission select 14;
	dtaFireMissionCurrent = [];
};

// Get current settings
if ((count dtaFireMissionCurrent) > 0) then {
	_fireMission = dtaFireMissionCurrent;
	_lastWarheadType = _fireMission select 2;
	_rounds = _fireMission select 3;
	_lastAngle = _fireMission select 6;
	_lastSheaf = _fireMission select 10;
	_lastFuse = _fireMission select 11;
	dtaSheafSize = _fireMission select 12;
	_lastAirburstHeight = _fireMission select 14;
};

_asset = dtaSelectedAsset;
_name = [(vehicle (leader _asset))] call dta_fnc_VehicleName;
_tubes = [_asset] call dta_fnc_GroupVehicles;
_assetName = [_asset] call dta_fnc_TrimGroupName;
_vehicle = vehicle (leader _asset);
_assetType = _vehicle call dta_fnc_AssetType;

// Gun-Target line
_pos = [dtaXreal,dtaYreal];
_pos2 = getPos _vehicle;
_gtl = 0;
_gtl = [_pos2,_pos] call BIS_fnc_dirTo;
_gtl = round _gtl;
//systemChat format ["GTL: %1",_gtl];hint format ["GTL: %1",_gtl];
((findDisplay _iccCode) displayCtrl (_iccCode + 17)) ctrlSetText format ["%1 deg",_gtl];
// Distance
_distance = _pos distance _pos2;
_distance = round _distance;
((findDisplay _iccCode) displayCtrl (_iccCode + 16)) ctrlSetText format ["%1 m",_distance];
dtaElevation = round dtaElevation;
((findDisplay _iccCode) displayCtrl (_iccCode + 19)) ctrlSetText format ["%1 m",dtaElevation];

_x = 0;
_y = 0;
_pos = [];
_pos = getPos (vehicle (leader dtaSelectedAsset));
_x = _pos select 0;
_y = _pos select 1;
_x = (_x / 10);
_x = floor _x;
_y = (_y / 10);
_y = floor _y;
_xText = "";
_yText = "";
_xText = [_x] call dta_fnc_FormatCoordinates;
_yText = [_y] call dta_fnc_FormatCoordinates;

_dtaXtext = "";
_dtaYtext = "";
_dtaXtext = [dtaXdisplay] call dta_fnc_FormatCoordinates;
_dtaYtext = [dtaYdisplay] call dta_fnc_FormatCoordinates;

_artyElev = getTerrainHeightASL _pos;
_artyElev = round _artyElev;
((findDisplay _iccCode) displayCtrl (_iccCode + 1)) ctrlSetText format ["%1: %2 x%3  GRID:%4-%5  ELEV: %6 m",_assetName,_name,(count _tubes),_xText,_yText,_artyElev];
((findDisplay _iccCode) displayCtrl (_iccCode + 2)) ctrlSetText format ["%1",_dtaXtext];
((findDisplay _iccCode) displayCtrl (_iccCode + 3)) ctrlSetText format ["%1",_dtaYtext];
((findDisplay _iccCode) displayCtrl (_iccCode + 4)) ctrlSetText format ["%1",0];
((findDisplay _iccCode) displayCtrl (_iccCode + 5)) ctrlSetText format ["%1",0];
if (_prePlotted) then {((findDisplay _iccCode) displayCtrl (_iccCode + 7)) ctrlSetText format ["%1",_rounds]}
	else
{((findDisplay _iccCode) displayCtrl (_iccCode + 7)) ctrlSetText format ["%1",dtaRounds]};

// Active tube
((findDisplay _iccCode) displayCtrl (_iccCode + 18)) ctrlSetText format ["Tube: %1/%2",(dtaSelectedTubeIndex + 1),(count _tubes)];

dtaSelectedTube = _tubes select dtaSelectedTubeIndex;
call seven_fnc_DisplayWarheads;

// Fire mission type
_count = 0;
_dialog = findDisplay _iccCode;
_list = _dialog displayCtrl (_iccCode + 8);
lbClear _list;
_missionTypes = ["PLOT", "SPOT", "FFE"];
if (_prePlotted) then {_missionTypes = ["FFE"]};
_missionType = "";
while {((count _missionTypes) > 0)} do {
	_missionType = _missionTypes select 0;
	_missionTypes = _missionTypes - [_missionType];
	_list lbAdd format["%1",_missionType];
	_list lbSetData [(lbSize _list)-1,_missionType];
};
lbSetCurSel [(_iccCode + 8),0];

// Angle
_dialog = findDisplay _iccCode;
_list = _dialog displayCtrl (_iccCode + 9);
lbClear _list;
_angleTypes = ["HIGH","LOW"];
if (_prePlotted) then {_angleTypes = [_lastAngle]};

_vehicle = vehicle (leader _asset);
_cfgVehicles = (configFile >> "CfgVehicles");
_class = typeOf _vehicle;
if ((_assetType isEqualTo "BM21") or (_assetType isEqualTo "Mortar") or (_assetType isEqualTo "Rockets")) then {_angleTypes = ["HIGH"]};
_count = 0;
_angle = "";
while {((count _angleTypes) > 0)} do {
	_angle = _angleTypes select 0;
	_angleTypes = _angleTypes - [_angle];
	_list lbAdd format["%1",_angle];
	_list lbSetData [(lbSize _list)-1,_angle];
	if (_angle isEqualTo _lastAngle) then {_lastAngleIndex = _count};
	_count = _count + 1;
};
lbSetCurSel [(_iccCode + 9),_lastAngleIndex];

// Sheaf type
_count = 0;
_dialog = findDisplay _iccCode;
_list = _dialog displayCtrl (_iccCode + 11);
lbClear _list;
_sheafTypes = ["POINT","CIRC","BOX"];
_sheafType = "";
while {((count _sheafTypes) > 0)} do {
	_sheafType = _sheafTypes select 0;
	_sheafTypes = _sheafTypes - [_sheafType];
	_list lbAdd format["%1",_sheafType];
	_list lbSetData [(lbSize _list)-1,_sheafType];
	if (_sheafType isEqualTo _lastSheaf) then {_lastSheafIndex = _count};
	_count = _count + 1;
};
lbSetCurSel [(_iccCode + 11),_lastSheafIndex];

// Fuse
_count = 0;
_dialog = findDisplay _iccCode;
_list = _dialog displayCtrl (_iccCode + 12);
lbClear _list;
_fuseTypes = ["IMPACT"];
if ((_assetType isEqualTo "Mortar") or (_assetType isEqualTo "Cannon")) then {_fuseTypes = ["IMPACT","AIRBURST","MIXED"]};
_fuseType = "";
while {((count _fuseTypes) > 0)} do {
	_fuseType = _fuseTypes select 0;
	_fuseTypes = _fuseTypes - [_fuseType];
	_list lbAdd format["%1",_fuseType];
	_list lbSetData [(lbSize _list)-1,_fuseType];
	if (_fuseType isEqualTo _lastFuse) then {_lastFuseIndex = _count};
	_count = _count + 1;
};
lbSetCurSel [(_iccCode + 12),_lastFuseIndex];

// Airburst Height
_count = 0;
_dialog = findDisplay _iccCode;
_list = _dialog displayCtrl (_iccCode + 15);
lbClear _list;

_airburstHeights = ["-"];
_airburstHeight = "";
while {((count _airburstHeights) > 0)} do {
	_airburstHeight = _airburstHeights select 0;
	_airburstHeights = _airburstHeights - [_airburstHeight];
	_list lbAdd format["%1",_airburstHeight];
	_list lbSetData [(lbSize _list)-1,_airburstHeight];
	if (_airburstHeight isEqualTo _lastAirburstHeight) then {_lastAirburstHeightIndex = _count};
	_count = _count + 1;
};
lbSetCurSel [(_iccCode + 15),_lastAirburstHeightIndex];