// Returns the type of group, based upon the typeOf of the vehicle of the group leader

private["_vehicle","_vehicleType","_groupType","_baseTypes","_baseType"];
//disableSerialization;
params ["_group"];
_vehicle = vehicle (leader _group);
_vehicleType = typeOf _vehicle;
_groupType = "Vehicle";

_baseTypes = dtaArtyParents;
_baseType = "";
_parents = [(configfile >> "CfgVehicles" >> _vehicleType),true] call BIS_fnc_returnParents;

while {((count _baseTypes) > 0)} do {
	_baseType = _baseTypes select 0;
	_baseTypes = _baseTypes - [_baseType];
	if (_baseType in _parents) exitWith {_groupType = "Artillery"};
};

_groupType