/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Civ Spawn Script
******************************************************************************************************* */
private ["_civtraffic","_civdriver","_namevar","_position","_vehicletype",
	"_name","_location"];
params ["_locationlist"];
_location = [_locationlist] call karma_cb_location_scan;
_vehicletype = selectRandom ["C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F"];
_civtraffic = createVehicle [_vehicletype, [0,0,0], [], 0, "CAN_COLLIDE"];
createVehicleCrew _civtraffic;
_civtraffic setPos _location;
_civdriver = driver _civtraffic;
_location = [_locationlist] call karma_cb_location_scan;
_civtraffic setSpeedMode "NORMAL";
_civtraffic doMove _location;
_civtraffic setSpeedMode "NORMAL";
karma_cb_civlist set [count karma_cb_civlist, _civtraffic];
_civtraffic setVariable ["IdleState", 0, false];
_civtraffic setVariable ["TargetPos", _location, false];
_civtraffic setVariable ["Driver", _civdriver, false];
_driverOut = _civdriver addEventHandler ["GetOut",{
	_driver = _this select 2;
	_vehicle = _this select 0;
	_idleState = _vehicle getVariable "IdleState";
	if (_idleState isEqualTo 0) then {_vehicle setVariable ["IdleState", 2, false]};
		karma_cb_civlist = karma_cb_civlist - [_vehicle];
		karma_cb_wrecklist set [count karma_cb_wrecklist, _vehicle];
		karma_cb_wrecklist set [count karma_cb_wrecklist, _driver];
	}];
//Marker Debug
_namevar = 2000 - (round (random 1000));
_name = "karma_civ_" + str (_namevar);
missionNamespace setVariable ["karma_civ_" + str (_namevar), _civtraffic];
//hint format ["%1",_name];
sleep 1;
_civname = missionNamespace getVariable _name;
//hint format ["%1",_civname];
sleep 1;
_civtraffic setVariable ["markername", _name, false];
_driverkilled = _civdriver addEventHandler [
	"Killed",
	{
		params ["_driver", "_killer"];
		_killername = name _killer;
		_vehicle = vehicle _driver;
		if (isPlayer _killer) then {
			[_killername] remoteExecCall ["karma_cb_civtraffic_killed", 0, false];
		};
		karma_cb_civlist = karma_cb_civlist - [_vehicle];
		karma_cb_wrecklist set [count karma_cb_wrecklist, _vehicle];
		karma_cb_wrecklist set [count karma_cb_wrecklist, _driver];
	}
];
_civdriver disableAI "TARGET";
_civdriver disableAI "AUTOTARGET";
_civdriver setSkill ["general",.5];
_civdriver setSkill ["aimingAccuracy",0];
_civdriver setSkill ["aimingShake",0];
_civdriver setSkill ["aimingSpeed",0];
_civdriver setSkill ["reloadSpeed",0];
