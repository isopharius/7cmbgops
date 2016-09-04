if (!hasInterface) exitWith {};
params ["_object"];
waitUntil {
	_object say3D "uragan_1";
	sleep 150;
	(isNull _object)
};