private ["_groups","_add","_out","_group","_type","_vehicle","_typeOf","_isArtillery"];
params ["_side"];
_group = grpNull;
_groups = allGroups;
_add = false;
_out = [];
_type = "";
_vehicle = objNull;
_typeOf = "";
_isArtillery = 0;
while {((count _groups) > 0)} do {
	_add = true;
	_group = _groups select 0;
	_groups = _groups - [_group];
	_vehicle = vehicle (leader _group);
	_typeOf = typeOf _vehicle;
	_isArtillery = 0;
	if (_group in dtaExclude) then {_add = false};
	if (_vehicle in dtaExclude) then {_add = false};
	if (_typeOf in dtaExclude) then {_add = false};
	if (_add) then {
		//_type = [_group] call dta_fnc_GroupType;
		//if ((_type == "Artillery") AND (_side == (side _group))) then {_out pushBack _group};
		_isArtillery = getNumber (configFile >> "CfgVehicles" >> _typeOf >> "artilleryScanner");
//		systemChat format ["IA: %1",_isArtillery];
		if ((_isArtillery isEqualTo 1) AND (_side isEqualTo (side _group))) then {_out pushBack _group};
	};
};
_out