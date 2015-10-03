/*
a: reyhard
attached object paradrop script
whatever is attached to c130 with attachTo command may be later droped by that script
*/
_v=_this select 0;

_v animateDoor ["ramp",1];
waitUntil {_v doorPhase "ramp"==1};
_v allowdamage false;
//_v enableSimulationGlobal false;

_k= (attachedObjects _v) select 0;
_p = _v worldToModel [getPosATL _k select 0, getPosATL _k select 1,(getPosATL _k select 2)-((_k worldToModel (getposatl _k)) select 2)];

while{(_p select 1 > -12)}do
{
	_p=_p vectorDiff [0,0.05,0];
	_k attachTo [_v,_p];
	sleep 0.01;
};

_k allowdamage false;
//_k enableSimulationGlobal false;
detach _k;
sleep 0.1;
_para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, "CAN_COLLIDE"];
_para allowdamage false;
//_para enableSimulationGlobal false;
_para setpos (getPosATL _k);

_k attachTo [_para,[0,0,-.5]];

_markertype = "SmokeShellBlue";

if !((daytime < 17) && (daytime > 7)) then {
	_markertype = "NVG_TargetC";
};

_marker = createVehicle [_markertype, (position _k), [], 0, "CAN_COLLIDE"];
_marker setPosATL (getPosATL _k);
_marker attachTo [_k,[0,0,1]];

sleep 1;
{
	_x allowdamage true;
	//_x enableSimulationGlobal true;
} foreach [_v,_para,_k];

waitUntil {isTouchingGround _k || underwater _k};
detach _k;
detach _marker;
sleep 0.1;
deleteVehicle _para;
deleteVehicle _marker;