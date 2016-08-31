// Called from Asset Dialog
// Releases an asset from player control

_asset = "";
_asset = format ["%1",dtaControlledAssetLocal];
dtaHaveAimpoint = false;
if ((_asset isEqualTo "<NULL-group>") or (_asset isEqualTo "any")) exitWith {hint "No asset under control"; closeDialog 0.3; [] spawn seven_fnc_Assets;};
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
[] spawn seven_fnc_Assets;