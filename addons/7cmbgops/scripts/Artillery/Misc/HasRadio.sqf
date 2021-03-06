// Checks if the artillery dialog can be shown

_haveRadio = false;
_gear = [];
_gear = assignedItems player;
_radios = [];
_radios = dtaRadioTypes;
_radio = "";

if (dtaDebug) then {hint format ["Your gear: %1\n\nAccepted radio types: %2",_gear,_radios]};

while {((count _radios) > 0)} do {
	_radio = _radios select 0;
	_radios = _radios - [_radio];
	if (_radio in _gear) then {_haveRadio = true;_radios = []};
};

if NOT(_haveRadio) then {_radio = "Unknown"};

// TFAR
_haveSW = false;
_haveLR = false;
_haveDD = false;
if (isClass (configFile >> "CfgVehicles" >> "tf_rt1523g")) then {
	if (dtaDebug) then {player globalChat "Checking TFAR radios."};
	_haveSW	= call TFAR_fnc_haveSWRadio;
	_haveLR	= call TFAR_fnc_haveLRRadio;
	_haveDD	= call TFAR_fnc_haveDDRadio;
	if (_haveSW) then {_haveRadio = true};
	if (_haveLR) then {_haveRadio = true};
	if (_haveDD) then {_haveRadio = true};
	if (_haveRadio) then {_radio = "TFAR"};
	if ((dtaDebug) AND (_haveRadio)) then {player globalChat "TFAR radio used."};
};

// ACRE
_ret = false;
if (isClass (configFile >> "CfgWeapons" >> "ACRE_BaseRadio")) then {
	if (dtaDebug) then {player globalChat "Checking ACRE radios"};
	_ret = [player] call acre_api_fnc_hasRadio;
	if (_ret) then {_haveRadio = true};
	if (_haveRadio) then {_radio = "ACRE"};
	if ((dtaDebug) AND (_ret)) then {player globalChat "ACRE radio used."};
};

_haveRadio