// Determines what type of piece the parsed tube is
// Uses a few different ways to check for mod pieces
_type = "INVALID";

_82mm = [];
_155mm = [];
_230mm = [];
_82mm = dta82mm;
_155mm = dta155mm;
_230mm = dta230mm;
_cfgVehicles = (configFile >> "CfgVehicles");
_class = typeOf _this;

_displayName = "";
_displayName = (getText(_cfgVehicles >> _class >> "displayName"));
_validType = false;
if (_displayName in _82mm) then {_type = "82mmMortar";_validType = true};
if (_displayName in _155mm) then {_type = "155mmHowitzer";_validType = true};
if (_displayName in _230mm) then {_type = "230mmRockets";_validType = true};

// If type not yet detected, try to detect by ammo type instead
_magazine = "";
_magazine = (magazines _this) select 0;
if NOT(_validType) then {
	if (_magazine in dta82mmMagazines) then {_type = "82mmMortar";_validType = true};
	if (_magazine in dta155mmMagazines) then {_type = "155mmHowitzer";_validType = true};
	if (_magazine in dta230mmMagazines) then {_type = "230mmRockets";_validType = true};
	if (_magazine in dta122mmMagazines) then {_type = "122mmHowitzer";_validType = true};
};

_type