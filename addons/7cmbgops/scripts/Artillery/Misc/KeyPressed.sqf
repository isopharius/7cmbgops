// Checks if the artillery dialog can be shown

if (!(dtaReady) or (time < 4)) exitWith {hint "DTA starting, please wait..."};

if (!alive player) exitWith {hint "You are dead..."};
_haveRadio = false;
_haveRadio = [] call dta_fnc_HasRadio;

_authorized = false;
if (dtaRestrictUsers) then {
	if ((typeOf (vehicle player)) in dtaAuthorizedClasses) then {_authorized = true};
	if ((typeOf player) in dtaAuthorizedClasses) then {_authorized = true};
	if (player in dtaAuthorizedUnits) then {_authorized = true};
};

if ((dtaRestrictUsers) AND (NOT _authorized)) exitWith {hint "You are not an authorized artillery user."};

// Use vehicle radio
if (!isNull (objectParent player)) then {_haveRadio = true};

//_haveRadio = [] call dta_fnc_HasRadio;
if (_haveRadio) exitWith {
//	if (dtaDebug) then {systemChat format ["dtaX: %1  dtaY: %2",dtaX,dtaY]; systemChat format ["player pos: %1",(getPos player)]};
	closeDialog 0;
	if (dtaLastDialog isEqualTo "Assets") then {[] execVM "\7cmbgops\scripts\Artillery\Dialog\Assets.sqf"};
	if (dtaLastDialog isEqualTo "Aimpoint") then {[] execVM "\7cmbgops\scripts\Artillery\Dialog\Aimpoint.sqf"};
	if (dtaLastDialog isEqualTo "Control") then {[false] execVM "\7cmbgops\scripts\Artillery\Dialog\Control.sqf"};
};

hint "No suitable radio.";