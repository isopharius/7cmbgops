if (hasInterface) then {
	_veh = objectParent player;
	_veh allowdamage false;
	player allowdamage false;
	sleep 1;

	moveOut player;
	sleep 2;

	_para = createVehicle ["OH_T10_PARACHUTE", [0,0,0], [], 0, "CAN_COLLIDE"];
	_para setPosworld (getPosworld player);
	sleep 0.1;
	player moveindriver _para;
	sleep 0.1;
	_veh allowdamage true;
	sleep 0.1;
	waitUntil {sleep 1; isTouchingGround player};
	player allowdamage true;
};
