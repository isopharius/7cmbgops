if (hasInterface) then {
	_veh = objectParent player;
	_veh allowdamage false;
	player allowdamage false;
	sleep 1;

	moveOut player;
	sleep 2;

	_para = createVehicle ["OH_T10_PARACHUTE", [0,0,0], [], 0, "CAN_COLLIDE"];
	_para setPosworld (getPosworld player);
	sleep 1;

	player moveindriver _para;
	_veh allowdamage true;
	sleep 1;

	_while = {
		if (!isTouchingGround player) then {
			sleep 2;
			call _while;
		};
	};
	call _while;

	player allowdamage true;
};
