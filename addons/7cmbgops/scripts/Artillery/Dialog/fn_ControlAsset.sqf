// Called from Asset Dialog
// Checks if the asset can be taken control of (ie. not busy/not controlled by another player)

params ["_prePlotted"];
if ((_prePlotted) AND {((count dtaSelectedPrePlotted) isEqualTo 0)}) exitWith {hint "No mission selected"};

_asset = grpNull;
_asset = dtaSelectedAsset;
if (_asset isEqualTo dtaControlledAssetLocal) then {closeDialog 0;sleep 0.3};
if (_asset isEqualTo dtaControlledAssetLocal) exitWith {[_prePlotted] spawn seven_fnc_Control};
if (_asset in dtaAssetsBusy) exitWith {
	(leader _asset) sideChat "Negative, asset is busy.";
	if NOT(dtaScriptMode) then {playSound "dtaBeep"}
};
if (_asset in dtaControlledAssets) exitWith {
	(leader _asset) sideChat "Negative, processing other orders.";
	if NOT(dtaScriptMode) then {playSound "dtaBeep"};
};

// If the local controlled asset is NOT the same as the selected asset (and both are groups), exit
if NOT(isNull (leader dtaControlledAssetLocal)) exitWith {
	(leader _asset) sideChat "Negative. You are already controlling another asset.";
	if NOT(dtaScriptMode) then {playSound "dtaBeep"};
};

dtaRounds = 3;

dtaControlledAssetLocal = _asset;
//if NOT(_asset in dtaControlledAssets) then {dtaControlledAssets pushBack _asset; publicVariable "dtaControlledAssets"};
dtaControlledAssets pushBack _asset;
publicVariable "dtaControlledAssets";
closeDialog 0;

if (_prePlotted) then {dtaPrePlotted = true};

_assetCallsign = "";
_playerCallsign = "";
_assetCallsign = [dtaSelectedAsset] call dta_fnc_TrimGroupName;
_playerCallsign = [(group player)] call dta_fnc_TrimGroupName;
//if ((dtaHaveAimpoint) OR (dtaPrePlotted)) then {
	player sideChat format ["%1 this is %2, adjust fire, over",_assetCallsign,_playerCallsign];
	sleep 1;
	[_prePlotted] spawn seven_fnc_Control;
	sleep 1;
	//(leader _asset) sideChat format ["%2 this is %1, adjust fire, out",_assetCallsign,_playerCallsign];
	_message = format ["%2 this is %1, adjust fire, out",_assetCallsign,_playerCallsign];
	[_asset,_message,"AdjustFire"] call dta_fnc_SendComms;
//}
//	else
//{
//	[_prePlotted] execVM "\7cmbgops\scripts\Artillery\Dialog\Aimpoint.sqf"
//};
