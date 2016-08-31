// Called from \7cmbgops\scripts\Artillery\Misc\Check.sqs
// Shows the artillery dialog

dtaLastDialog = "Assets";
dtaSelectedPrePlotted = [];
if NOT(dialog) then {createDialog "dtaDialogAssets"};
disableSerialization;
_dialog = findDisplay 100;
_list = _dialog displayCtrl 101;
lbClear _list;
_assets = [];
_assets = [(side player)] call dta_fnc_ArtilleryGroupsBySide;
dtaAssets = _assets;

_asset = "";
_name = "";
_count = 0;
_tubes = [];
_status = "";
_select = false;
_pos = [];
_x = 0;
_y = 0;
_xText = "";
_yText = "";

while {((count _assets) > 0)} do {
	_select = true;
	_asset = _assets select 0;
	_assets = _assets - [_asset];
	_name = [(vehicle (leader _asset))] call dta_fnc_VehicleName;
	_status = "RDY";
	if (_asset in dtaControlledAssets) then {_status = "BSY"};
	if (_asset isEqualTo dtaControlledAssetLocal) then {_status = "CON"};
	if (_asset in dtaAssetsBusy) then {_status = "BSY"};
	_pos = getPos (vehicle (leader _asset));
	_x = _pos select 0;
	_y = _pos select 1;
	_x = (_x / 10);
	_y = (_y / 10);
	_x = round _x;
	_y = round _y;
	_xText = [_x] call dta_fnc_FormatCoordinates;
	_yText = [_y] call dta_fnc_FormatCoordinates;
	_tubes = [_asset] call dta_fnc_GroupVehicles;
	_asset = [_asset] call dta_fnc_TrimGroupName;
//	_list lbAdd format["%1: %2 x %3  (%4)",_asset,_name,(count _tubes),_status];
	_list lbAdd format["%1: %2 x %3  [%4,%5] (%6)",_asset,_name,(count _tubes),_xText,_yText,_status];
	_list lbSetValue [(lbSize _list)-1,_count];
	_count = _count + 1;
};
if (_select) then {lbSetCurSel [101,0]};

call seven_fnc_RefreshMissions;