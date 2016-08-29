// Called from Asset Dialog
// Releases an asset from player control

_asset = "";
_asset = format ["%1",dtaControlledAssetLocal];
dtaHaveAimpoint = false;
if (_asset == "<NULL-group>") exitWith {hint "No asset under control"};
if (_asset == "any") exitWith {hint "No asset under control"};
dtaControlledAssets = dtaControlledAssets - [dtaControlledAssetLocal];
publicVariable "dtaControlledAssets";
dtaControlledAssetLocal = grpNull;
dtaFirstRound = true;
dtaSelectedTube = objNull;
dtaSelectedTubeIndex = 0;
dtaLastWarheadType = "";
dtaRounds = 3;

player sideChat "Asset released.";
closeDialog 0.3;
[] execVM "\7cmbgops\scripts\Artillery\Dialog\Assets.sqf";