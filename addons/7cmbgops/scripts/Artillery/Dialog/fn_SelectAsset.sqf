// Called from

disableSerialization;
_index = lbCurSel 101;
_selectedAssetIndex = lbValue [101,_index];
dtaSelectedAsset = dtaAssets select _selectedAssetIndex;
call seven_fnc_RefreshMissions;