// Called from DT\Artillery\Check.sqs
// Shows the artillery dialog

private["_prePlotted","_iccCode","_assetName","_dialogName","_fireMission","_lastWarheadType","_rounds","_angle","_sheaf","_sheafSize","_fuse","_airburstHeight"];
private["_lastAngle","_lastWarheadType","_lastRounds","_lastAngle","_lastSheaf","_lastSheafSize","_lastFuse","_lastAirburstHeight"];
private["_lastWarheadTypeIndex","_lastRoundsIndex","_lastAngleIndex","_lastSheafIndex","_lastFuseIndex","_lastAirburstHeightIndex"];
private["_asset","_name","_tubes","_assetName","_tubeType","_x","_y","_pos","_xText","_yText","_dtaXtext","_dtaYtext"];
private["_list","_warheads","_warheadInfo","_roundType","_roundTypeClass","_roundsAvailable","_type","_types","_vehicle","_count"];
private["_missionTypes","_missionType","_angleTypes","_82mm","_cfgVehicles","_class","_sheafTypes","_sheafType","_fuseTypes","_fuseType","_airburstHeights"];
disableSerialization;

// Change icc code for normal (200) vs pre-plotted (300) dialogs
_iccCode = 200;
// Warhead types
_dialog = findDisplay _iccCode;
_list = _dialog displayCtrl (_iccCode + 6);
lbClear _list;
_lastWarheadType = "";
_lastWarheadType = dtaLastWarheadType;
_lastWarheadTypeIndex = 0;
_warheads = [];
_warheadInfo = [];
_roundType = "";
_roundTypeClass = "";
_roundsAvailable = 0;
_type = "";
_types = [];

_vehicle = dtaSelectedTube;
_magazines = magazinesAmmo _vehicle;
_magazine = "";
_count = 0;
_index = 0;

while {(_index < (count _magazines))} do {
	_magazine = _magazines select _index;
	_roundTypeClass = _magazine select 0;
	_roundType = getText (configFile >> "CfgMagazines" >> _roundTypeClass >> "displayName");
	_roundsAvailable = _magazine select 1;
	//systemChat format ["%1 %2",_roundTypeClass,_lastWarheadType];
	if (_roundTypeClass == _lastWarheadType) then {_lastWarheadTypeIndex = _count};
	if (_roundsAvailable > 0) then {
		_list lbAdd format["%1: %2",_roundType,_roundsAvailable];
		_list lbSetData [(lbSize _list)-1,_roundTypeClass];
		_count = _count + 1;
	};
	_index = _index + 1;
};
lbSetCurSel [(_iccCode + 6),_lastWarheadTypeIndex];