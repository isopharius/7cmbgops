// Forces a tube to load a certain magazine type by deleting all magazines and adding the desired one first
// It is a clumsy workaround, but BIS does not have a reliable command to do this
// Some code based off Smarter Tanks by Alarm9k

private ["_magazineRounds","_allMagazines","_omitOnce","_newMagazines","_index","_add","_magazine"];

//if (dtaDebug) then {systemChat "Tube loading new mag"};

params ["_tube", "_magazineType"];

if ((currentMagazine _tube) isEqualTo _magazineType) exitWith {};

_magazineRounds = 0;
_allMagazines = [];
_allMagazines = magazinesAmmo _tube;

{if (_magazineType == _x select 0) exitWith {_magazineRounds = _x select 1}} forEach _allMagazines;
{_tube removeMagazine (_x select 0)} forEach _allMagazines;
_tube addMagazine [_magazineType,_magazineRounds];

//systemChat format ["%1 %2",_magazineType,_magazineRounds];

_omitOnce = true;
_newMagazines = [];
_index = 0;
_add = true;
_magazine = [];

while {(_index < (count _allMagazines))} do {
	_add = true;
	_magazine = _allMagazines select _index;
	if ((_magazineType == (_magazine select 0)) AND (_magazineRounds == (_magazine select 1)) AND (_omitOnce)) then {
		_omitOnce = false;
		_add = false;
	};
	if (_add) then {_newMagazines pushBack _magazine};
	_index = _index + 1;
};

{_tube addMagazine _x} forEach _newMagazines;