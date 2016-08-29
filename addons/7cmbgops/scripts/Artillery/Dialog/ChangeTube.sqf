params ["_action"];
_asset = dtaSelectedAsset;
_tubes = [_asset] call dta_fnc_GroupVehicles;
_max = count _tubes;
_iccCode = 200;
_lastWarheadType = "";
if (_action isEqualTo "Previous") exitWith {
	if (dtaSelectedTubeIndex == 0) exitWith {};
	dtaSelectedTubeIndex = dtaSelectedTubeIndex - 1;
	dtaSelectedTube = _tubes select dtaSelectedTubeIndex;
	if (dtaDebug) then {systemChat format ["A: %1",(currentMagazine dtaSelectedTube)]};
	((findDisplay _iccCode) displayCtrl (_iccCode + 18)) ctrlSetText format ["Tube: %1/%2",(dtaSelectedTubeIndex + 1),(count _tubes)];
	[_lastWarheadType] execVM "\7cmbgops\scripts\Artillery\Dialog\DisplayWarheads.sqf";
};

if (_action isEqualTo "Next") exitWith {
	if (dtaSelectedTubeIndex == (_max - 1)) exitWith {};
	dtaSelectedTubeIndex = dtaSelectedTubeIndex + 1;
	dtaSelectedTube = _tubes select dtaSelectedTubeIndex;
	if (dtaDebug) then {systemChat format ["A: %1",(currentMagazine dtaSelectedTube)]};
	((findDisplay _iccCode) displayCtrl (_iccCode + 18)) ctrlSetText format ["Tube: %1/%2",(dtaSelectedTubeIndex + 1),(count _tubes)];
	[_lastWarheadType] execVM "\7cmbgops\scripts\Artillery\Dialog\DisplayWarheads.sqf";
};