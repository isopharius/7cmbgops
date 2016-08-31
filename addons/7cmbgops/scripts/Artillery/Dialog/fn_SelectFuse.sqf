/*
private["_prePlotted","_iccCode","_assetName","_dialogName","_fireMission","_lastWarheadType","_rounds","_angle","_sheaf","_sheafSize","_fuse","_airburstHeight"];
private["_lastAngle","_lastWarheadType","_lastRounds","_lastAngle","_lastSheaf","_lastSheafSize","_lastFuse","_lastAirburstHeight"];
private["_lastWarheadTypeIndex","_lastRoundsIndex","_lastAngleIndex","_lastSheafIndex","_lastFuseIndex","_lastAirburstHeightIndex"];
private["_asset","_name","_tubes","_assetName","_tubeType","_x","_y","_pos","_xText","_yText","_dtaXtext","_dtaYtext"];
private["_list","_warheads","_warheadInfo","_roundType","_roundTypeClass","_roundsAvailable","_type","_types","_vehicle","_count"];
private["_missionTypes","_missionType","_angleTypes","_82mm","_cfgVehicles","_class","_sheafTypes","_sheafType","_fuseTypes","_fuseType","_airburstHeights"];
*/
disableSerialization;

_iccCode = 200;
_fuse = "";
_index = lbCurSel (_iccCode + 12);
_fuse = lbData [(_iccCode + 12),_index];

if (_fuse isEqualTo "IMPACT") exitWith {
	_dialog = findDisplay _iccCode;
	_list = _dialog displayCtrl (_iccCode + 15);
	lbClear _list;
};

// Airburst Height
_count = 0;
_dialog = findDisplay _iccCode;
_list = _dialog displayCtrl (_iccCode + 15);
lbClear _list;
_airburstHeights = ["MED","HIGH","LOW"];
_airburstHeight = "";
while {((count _airburstHeights) > 0)} do {
	_airburstHeight = _airburstHeights select 0;
	_airburstHeights = _airburstHeights - [_airburstHeight];
	_list lbAdd format["%1",_airburstHeight];
	_list lbSetData [(lbSize _list)-1,_airburstHeight];
	if (_airburstHeight isEqualTo _lastAirburstHeight) then {_lastAirburstHeightIndex = _count};
	_count = _count + 1;
};