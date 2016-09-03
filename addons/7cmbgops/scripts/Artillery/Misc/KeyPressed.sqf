// Checks if the artillery dialog can be shown

if (!(dtaReady) or {(time < 4)}) exitWith {hint "DTA starting, please wait..."};

if (!alive player) exitWith {hint "You are dead..."};
_haveRadio = false;
_haveRadio = [] call dta_fnc_HasRadio;

_authorized = false;
if (dtaRestrictUsers) then {
	if ((typeOf (vehicle player)) in dtaAuthorizedClasses) then {_authorized = true};
	if ((typeOf player) in dtaAuthorizedClasses) then {_authorized = true};
	if (player in dtaAuthorizedUnits) then {_authorized = true};
};

if ((dtaRestrictUsers) && {(NOT _authorized)}) exitWith {hint "You are not an authorized artillery user."};

// Use vehicle radio
if (!isNull (objectParent player)) then {_haveRadio = true};

//_haveRadio = [] call dta_fnc_HasRadio;
if (_haveRadio) exitWith {
//	if (dtaDebug) then {systemChat format ["dtaX: %1  dtaY: %2",dtaX,dtaY]; systemChat format ["player pos: %1",(getPos player)]};
	closeDialog 0;
	if (dtaLastDialog isEqualTo "Assets") then {
		[] spawn seven_fnc_Assets;
	} else {
		if (dtaLastDialog isEqualTo "Control") then {
			[false] spawn seven_fnc_Control;
		};
	};
};

hint "No suitable radio.";