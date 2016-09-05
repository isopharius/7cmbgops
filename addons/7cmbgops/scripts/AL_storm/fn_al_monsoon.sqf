// by ALIAS
// Monsoon SCRIPT
// Tutorial: https://www.youtube.com/user/aliascartoons
//null = [direction_monsoon, duration_monsoon, effect_on_objects] execvm "\7cmbgops\scripts\AL_storm\al_monsoon.sqf";

if (!isServer) exitWith {};

params ["_direction_monsoon", "_duration_monsoon", "_effect_on_objects"];

al_monsoon_om = true;
publicVariable "al_monsoon_om";

// - memoreaza parametri actuali

_foglevel	= fog;
_rainlevel	= rain;
_thundlevel	= lightnings;
_windlevel	= wind;
_overcast	= overcast;

sleep 0.1;

[_duration_monsoon, _overcast, _foglevel, _rainlevel, _thundlevel, _windlevel] spawn {
	sleep (_this select 0);

	al_monsoon_om = false;
	publicVariable "al_monsoon_om";

// restaureaza parametri vreme
	[
		[_this select 1],
		{
			skipTime -24;
			86400 setOvercast (_this select 0);
			skipTime 24;
			sleep 0.1;
			simulWeatherSync;
		}
	] remoteExec ["BIS_fnc_spawn", 0, true];
	60 setFog (_this select 2);
	60 setRain (_this select 3);
	60 setLightnings (_this select 4);
	setWind [(_this select 5) select 0, (_this select 5) select 1, true];
};

[] spawn {
	waitUntil {
		"bcg_wind" remoteExecCall ["playSound", 0, false];
		sleep 60;
		(!al_monsoon_om)
	};
};

// seteaza conditii vreme
{
	skipTime -24;
	86400 setOvercast 1;
	skipTime 24;
	sleep 0.1;
	simulWeatherSync;
} remoteExec ["BIS_fnc_spawn", 0, true];

[] spawn {
	_ifog = 0;
	waitUntil {
		_ifog = _ifog + 0.001;
		0 setFog _ifog;
		sleep 0.01;

		!(_ifog < 0.5)
	};
};

(_duration_monsoon / 30) setLightnings 1;
(_duration_monsoon / 30) setrain 1;


// seteaza wind storm functie de directie

raport = 360 / _direction_monsoon;
raport = (round (raport * 100)) / 100;
//hint str raport;

if (raport >= 4) then {
	fctx = 1;
	fcty = 1;
} else {
	if (raport >= 2) then {
		fctx = 1;
		fcty = -1;
	} else {
		if (raport >=1.33) then {
			fctx = -1;
			fcty = -1;
		} else {
			fctx = -1;
			fcty = 1;
		};
	};
};
//hint str fcty;sleep 2;hint str fctx;

_unx = (_direction_monsoon - (floor (_direction_monsoon/90)*90)) * fctx;
//hint str _unx;
//_uny	= 90-_unx;

vx = floor(_unx * 0.6);
vy = (54 - vx) * fcty;

// mareste incremental vantul

inx = 0;
iny = 0;

incr = true;
incrx = false;
incry = false;

while {incr} do {
	sleep 0.01;
	if (inx < abs vx) then {inx = inx+0.1;} else {incrx = true};
	if (iny < abs vy) then {iny = iny+0.1} else {incry = true};
	if (incrx and incry) then {incr=false};
	winx = floor (inx*fctx);
	winy = floor (iny*fcty);
	setWind [winx,winy,true];
};

[] remoteExec ["seven_fnc_alias_monsoon_effect", 0, false];

if (_effect_on_objects) then {

	while {al_monsoon_om} do {
		_rand_pl = [] spawn seven_fnc_alias_hunt;
		waitUntil {sleep 0.1; (scriptDone _rand_pl)};

	// interval object blow
		sleep 1;

		_nearobjects = nearestObjects [hunt_alias,[],50];
		_obj_eligibl = [];

		{if((_x isKindOf "LandVehicle") or {(_x isKindOf "CAManBase")} or {(_x isKindOf "Air")} or {(_x isKindOf "Wreck")}) then
			{_obj_eligibl pushBack _x;};
		} foreach _nearobjects;

		sleep 1;

		// alege obiect
		_blowobj = selectRandom _obj_eligibl;

		//durata_rafala = 1+random 5;	sleep 30+random 120;
		sleep 1;
		_rafale = selectRandom ["rafala_1","rafala_2","rafala_4_dr","rafala_5_st","rafala_6","rafala_7","rafala_8","rafala_9"];
		_rafale remoteExecCall ["playSound", 0, false];
		//hint str _rafale;

		if (!isNull _blowobj) then {
			_xblow	= 0.1+random 5;
			_yblow	= 0.1+random 5;

			// creste viteza incremental
			_xx=0;
			_yy=0;

			while {((_xx < _xblow) or {(_yy < _yblow)})} do {
				_blowobj setvelocity [_xx * fctx, _yy * fcty, random 0.1];
				_xx = _xx + 0.01;
				_yy = _yy + 0.01;
				sleep 0.001;
			};
		};
	};
};