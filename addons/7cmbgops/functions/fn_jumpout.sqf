if (isdedicated || isHC) exitwith {};

_veh = objectParent player;
_veh allowdamage false;
player allowdamage false;
sleep 1;

moveOut player;
sleep 2;

_para = "OH_T10_PARACHUTE" createVehicle (getPosworld player);
_para setPosworld (getPosworld player);
sleep 1;

player moveindriver _para;
_veh allowdamage true;
sleep 1;

waitUntil {isTouchingGround player};
player allowdamage true;