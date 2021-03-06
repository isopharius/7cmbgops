if (!isServer) exitWith {};

params ["_tornado_start", "_tornado_dest"];

_posstart = getMarkerpos _tornado_start;
_posdest = getMarkerpos _tornado_dest;
deletemarker _tornado_start;
deletemarker _tornado_dest;

_tornadasource = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_tornadasource setPos _posstart;

// transmite la clienti
[_tornadasource] spawn {
	params ["_tornadasource"];
	waitUntil {
		[_tornadasource, "uragan_1"] remoteExecCall ["say3D", 0, false];
		sleep 150;
		(isNull _tornadasource)
	};
};

[_tornadasource] remoteExec ["seven_fnc_al_tornado_effect", 0, true];

[_tornadasource] spawn {
	params ["_tuner_tor"];
	waitUntil {
		[_tuner_tor] remoteExec ["seven_fnc_al_tunet_tornado", 0, false];
		//sleep 10 + random 60;
		sleep 3;
		(isNull _tuner_tor)
	};
};

//---------------------------------------------------

// *************************************** deplasare ********************************************
_xdest = _posdest select 0;
_ydest = _posdest select 1;
_xstart= _posstart select 0;
_ystart= _posstart select 1;

// ************* directia *****************

tornadosino = "goon";
publicvariable "tornadosino";

_foglevel	= fog;
_rainlevel	= rain;
_overcast	= overcast;
_thundlevel	= lightnings;

sleep 0.1;

[] spawn {
	_ifog=0;
	waitUntil {
		_ifog = _ifog + 0.001;
		0 setFog _ifog;
		sleep 0.01;

		!(_ifog < 0.3)
	};
};

{
	skipTime -24;
	86400 setOvercast 0.8;
	skipTime 24;
	sleep 0.1;
	simulWeatherSync;
} remoteExec ["BIS_fnc_spawn", 0, true];

10 setLightnings 0.8;
10 setrain 0.8;

while {tornadosino isEqualTo "goon"} do {

	_tornadaposworld = getPosWorld _tornadasource;
	_xmove = _tornadaposworld select 0;
	_ymove = _tornadaposworld select 1;

	_xcheck = _xmove - _xdest;
	_ycheck = _ymove - _ydest;
	if ((_xcheck > 10) or (_xcheck < -10)) then
	{
		if (_xstart < _xdest) then
		{
		_tornadasource setposWorld [_xmove + 5, _ymove, 2];
		};

		if (_xstart > _xdest) then
		{
		_tornadasource setposWorld [_xmove - 5, _ymove, 2];
		};

	};

	if ((_ycheck > 10) or (_ycheck < -10)) then
	{
		if (_ystart < _ydest) then
		{
		_tornadasource setposWorld [_xmove, _ymove + 5 + random 5, 2];
		} else {
			if (_ystart > _ydest) then
			{
			_tornadasource setposWorld [_xmove, _ymove - 5 - random 5, 2];
			};
		};
	};

	_nearobjects = nearestObjects [_tornadaposworld, [], 50];

	//avoid destroying _tornadasource

	{if(_x != _tornadasource) then {if((_x isKindOf "LandVehicle") or {(_x isKindOf "CAManBase")} or {(_x isKindOf "Air")}) then {_f = selectRandom [-1,1]; _x setvelocity [(random 10) * _f,(random 10)* _f,20+(random 10)* _f]; sleep 0.5;} else {_x setdamage 1};};} foreach _nearobjects;

//	{if((_x != _tornadasource) and (_x isKindOf "Tank")) then {sleep 1 + random 6;_x setdamage 1;};} foreach _nearobjects;

	if ((-20 < _xcheck) and {(_xcheck < 20)} and {(-20 < _ycheck)} and {(_ycheck < 20)}) then
	{

   	_source_end = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_source_end setPosWorld _tornadaposworld;
	[_source_end, "uragan_end"] remoteExecCall ["say3D", 0, false];

	sleep 0.1;
	deletevehicle _tornadasource;
	tornadosino = "goof";
	publicvariable "tornadosino";
/*
	_source_end_part = "#particlesource" createVehicle getPos _source_end;
	_source_end_part setParticleCircle [50, [0.2, 0.5, 0.9]];
	_source_end_part setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0.3], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_source_end_part setParticleParams [["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 0.75], 15, 17, 13, 0.7, [15, 17, 19], [[0.5, 0.5, 0.5, 0.3], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 0.1, 3, "", "", _source_end];
	_source_end_part setDropInterval 0.1;
*/
	sleep 17;
	deleteVehicle _source_end;
	};
	sleep 3;
};

deleteVehicle _tornadasource;
enableCamShake false;

[
	[_overcast],
	{
		skipTime -24;
		86400 setOvercast (_this select 0);
		skipTime 24;
		sleep 0.1;
		simulWeatherSync;
	}
] remoteExecCall ["BIS_fnc_spawn", 0, true];

60 setFog _foglevel;
60 setRain _rainlevel;
60 setLightnings _thundlevel;