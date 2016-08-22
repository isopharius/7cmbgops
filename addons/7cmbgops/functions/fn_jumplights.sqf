	_heli = _this select 0;
	_lightsPositions = _this select 1;

	_lights = [];
	{
		_light = createVehicle ["#lightpoint", [0,0,0], [], 0, "CAN_COLLIDE"];
		_lights pushBack _light;
		_light lightAttachObject [_heli, _x];
		_light setLightBrightness 0;
		_light setLightColor [0, 0, 0];
		_light setLightAttenuation [1, 0, 0, 7.5];
	} forEach _lightsPositions;

if (isServer) then {
	_heli setVariable ["lights", [_lights, "none"], true];
};
