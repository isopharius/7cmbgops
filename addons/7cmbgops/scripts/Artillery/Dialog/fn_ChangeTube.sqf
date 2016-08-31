params ["_action"];
_asset = dtaSelectedAsset;
_tubes = [_asset] call dta_fnc_GroupVehicles;
_max = count _tubes;
_iccCode = 200;
_lastWarheadType = "";
if (_action isEqualTo "Previous") exitWith {
	if (dtaSelectedTubeIndex isEqualTo 0) exitWith {};
	dtaSelectedTubeIndex = dtaSelectedTubeIndex - 1;
	dtaSelectedTube = _tubes select dtaSelectedTubeIndex;
	if (dtaDebug) then {systemChat format ["A: %1",(currentMagazine dtaSelectedTube)]};
	((findDisplay _iccCode) displayCtrl (_iccCode + 18)) ctrlSetText format ["Tube: %1/%2",(dtaSelectedTubeIndex + 1),(count _tubes)];
	[_lastWarheadType] call seven_fnc_DisplayWarheads;
};

if (_action isEqualTo "Next") exitWith {
	if (dtaSelectedTubeIndex isEqualTo (_max - 1)) exitWith {};
	dtaSelectedTubeIndex = dtaSelectedTubeIndex + 1;
	dtaSelectedTube = _tubes select dtaSelectedTubeIndex;
	if (dtaDebug) then {systemChat format ["A: %1",(currentMagazine dtaSelectedTube)]};
	((findDisplay _iccCode) displayCtrl (_iccCode + 18)) ctrlSetText format ["Tube: %1/%2",(dtaSelectedTubeIndex + 1),(count _tubes)];
	[_lastWarheadType] call seven_fnc_DisplayWarheads;
};