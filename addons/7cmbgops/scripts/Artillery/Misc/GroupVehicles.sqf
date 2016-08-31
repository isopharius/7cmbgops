// Takes a group and returns an array of the vehicles in a group

private["_men","_vehicles","_man","_vehicle"];
params ["_group"];
_men = units _group;
_vehicles = [];
while {((count _men) > 0)} do {
	_man = _men select 0;
	_men = _men - [_man];
	_vehicle = objectParent _man;
	if (!isNull _vehicle) then {
		if NOT(_vehicle in _vehicles) then {_vehicles pushBack _vehicle};
	};
};
_vehicles