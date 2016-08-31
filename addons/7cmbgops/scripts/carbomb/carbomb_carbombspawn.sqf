/* *****************************************************************************************************
ARMA 3 Script
Author: I34dKarma
Description: Karma Carbomb Spawn Script
******************************************************************************************************* */
private ["_namevar","_position","_vehicletype",
	"_name","_targetunit","_location"];
_locationlist = _this select 0;
_location = [_locationlist] call karma_cb_location_scan;
_vehicletype = ["C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F"] call BIS_fnc_SelectRandom;
_carbomb = createVehicle [_vehicletype, [0,0,0], [], 0, "NONE"];
createVehicleCrew _carbomb;
_carbom setPos _location;
_cbombdriver = driver _carbomb;
//Switch Side
_cbombergroup = createGroup EAST;
[_cbombdriver] joinSilent _cbombergroup;
//Cbomb Name And Debug
_namevar = 2000 - (round (random 1000));
_name = "karma_cbomb_" + str (_namevar);
missionNamespace setVariable ["karma_cbomb_" + str (_namevar), _carbomb];
//hint format ["%1",_name];
sleep 1;
_cbombname = missionNamespace getVariable _name;
//hint format ["%1",_cbombname];
sleep 1;
karma_cb_carbomblist set [count karma_cb_carbomblist, _cbombname];
_carbomb setVariable ["markername", _name, false];
if (karma_cb_debug isEqualTo 1) then {
_markerstr = createMarker[_name,getPosATL _carbomb];
_name setMarkerShape "ICON";
_name setMarkerType "mil_dot";
_name setMarkerText _name;
};
_carbomb setVariable ["TargetScan", 0, false];
_carbomb setVariable ["EntityScan", 0, false];
_carbomb setVariable ["Target", 0, false];
_carbomb setVariable ["TargetState", 0, false];
_carbomb setVariable ["Explosive", 0, false];
_carbomb setVariable ["IdleState", 0, false];
_carbomb setVariable ["IdleCount", 0, false];
_carbomb setVariable ["TargetPos", 0, false];
_carbomb setVariable ["TargetDis", 0, false];
_carbomb setVariable ["Driver", _cbombdriver, false];
_cbombdriver setVariable ["Vehicle", _carbomb, false];
//Skill Setup
_cbombdriver disableAI "ANIM";
_carbomb setBehaviour "CARELESS";
_cbombdriver setSkill ["general",1];
_cbombdriver setSkill ["aimingAccuracy",0];
_cbombdriver setSkill ["aimingShake",0];
_cbombdriver setSkill ["aimingSpeed",0];
_cbombdriver setSkill ["reloadSpeed",0];
_cbombdriver setSkill ["courage",0];
_cbombdriver setSkill ["commanding",0];
_cbombdriver setSkill ["spotDistance",1];
_cbombdriver setSkill ["spotTime",1];
[_carbomb] call karma_cb_target_select;
_driverkilled = _cbombdriver addEventHandler ["Killed",{
_driver = _this select 0;
[_driver] spawn karma_cb_driver_killed;
}];
_driverOut = _cbombdriver addEventHandler ["GetOut",{
_driver = _this select 2;
_vehicle = _this select 0;
_idleState = _vehicle getVariable "IdleState";
if (_idleState isEqualTo 0) then {_vehicle setVariable ["IdleState", 2, false]};
	karma_cb_wrecklist set [count karma_cb_wrecklist, _vehicle];
	karma_cb_wrecklist set [count karma_cb_wrecklist, _driver];
}];
