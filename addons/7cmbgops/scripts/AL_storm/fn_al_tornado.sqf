if (!isServer) exitWith {};

params ["_tornado_start", "_tornado_dest"];

_posstart = getMarkerpos _tornado_start;
_tornadasource = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
_tornadosource setPos _posstart;

// transmite la clienti
[_tornadasource] remoteExec ["seven_fnc_tornadoSound", 0, true];
[_tornadasource] remoteExec ["seven_fnc_al_tornado_effect", 0, true];

[_tornadasource] spawn {
	_tuner_tor = _this select 0;
	while {!isNull _tuner_tor} do {
	[_tuner_tor] remoteExec ["seven_fnc_al_tunet_tornado", 0, true];
	//sleep 10 + random 60;
	sleep 3;
	};
};

//---------------------------------------------------

// *************************************** deplasare ********************************************

_posdest = getMarkerpos _tornado_dest;
_xdest = _posdest select 0;
_ydest = _posdest select 1;
_xstart= _posstart select 0;
_ystart= _posstart select 1;

// ************* directia *****************

tornadosino = "goon";
publicvariable "tornadosino";

al_foglevel		= fog;
al_rainlevel	= rain;
al_thundlevel	= lightnings;
al_windlevel	= wind;
publicVariable "al_foglevel";
publicVariable "al_rainlevel";
publicVariable "al_thundlevel";
publicVariable "al_windlevel";

sleep 0.1;

[] spawn {
	_ifog=0;
	while {_ifog <0.3} do {
		_ifog=_ifog+0.001; 0 setFog _ifog; sleep 0.01;
	};
};

[] spawn {
	_irain=0;
	while {_irain <1} do {
		_irain=_irain+0.01;0 setrain _irain; sleep 0.1;
	};
};
/*
[tornadosino] spawn {
	_tornadodur = _this select 0;
	waitUntil {_tornadodur == "goof"};

// restaureaza parametri vreme
	60 setFog al_foglevel;
	60 setRain al_rainlevel;
	60 setLightnings al_thundlevel;
	setWind [al_windlevel select 0, al_windlevel select 1, true];
};
*/
while {tornadosino isEqualTo "goon"} do
{

	_xmove = getpos _tornadasource select 0;
	_ymove = getpos _tornadasource select 1;

	_xcheck = _xmove-_xdest;
	_ycheck = _ymove-_ydest;

	if ((_xcheck > 10) or (_xcheck < -10)) then
	{
		if (_xstart < _xdest) then
		{
		_tornadasource setpos [(getpos _tornadasource select 0) + 5, getpos _tornadasource select 1, 2];
		};

		if (_xstart > _xdest) then
		{
		_tornadasource setpos [(getpos _tornadasource select 0) -5, getpos _tornadasource select 1, 2];
		};

	};

	if ((_ycheck > 10) or (_ycheck < -10)) then
	{
		if (_ystart < _ydest) then
		{
		_tornadasource setpos [(getpos _tornadasource select 0),(getpos _tornadasource select 1) + 5 + random 5, 2];
		} else {
			if (_ystart > _ydest) then
			{
			_tornadasource setpos [(getpos _tornadasource select 0),(getpos _tornadasource select 1) - 5 - random 5, 2];
			};
		};
	};

	_nearobjects = nearestObjects[_tornadasource,[],50];

	//avoid destroying _tornadasource

	{if(_x != _tornadasource) then {if((_x isKindOf "LandVehicle") or {(_x isKindOf "CAManBase")} or {(_x isKindOf "Air")}) then {_f = selectRandom [-1,1]; _x setvelocity [(random 10) * _f,(random 10)* _f,20+(random 10)* _f]; sleep 0.5;} else {_x setdamage 1};};} foreach _nearobjects;

//	{if((_x != _tornadasource) and (_x isKindOf "Tank")) then {sleep 1 + random 6;_x setdamage 1;};} foreach _nearobjects;

	if ((-20 < _xcheck) and {(_xcheck < 20)} and {(-20 < _ycheck)} and {(_ycheck < 20)}) then
	{

   	_source_end = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_tornadasource setPos (position _tornadasource);
	[_source_end, "uragan_end"] call CBA_fnc_globalSay3d;

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

	60 setFog al_foglevel;
	60 setRain al_rainlevel;
	60 setLightnings al_thundlevel;
	setWind [al_windlevel select 0, al_windlevel select 1, true];