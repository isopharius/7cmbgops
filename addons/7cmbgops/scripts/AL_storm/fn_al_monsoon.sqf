// by ALIAS
// Monsoon SCRIPT
// Tutorial: https://www.youtube.com/user/aliascartoons
//null = [direction_monsoon, duration_monsoon, effect_on_objects] execvm "\7cmbgops\scripts\AL_storm\al_monsoon.sqf";

if (!isServer) exitWith {};

_direction_monsoon	= _this select 0;
_duration_monsoon	= _this select 1;
_effect_on_objects	= _this select 2;

al_monsoon_om = true;
publicVariable "al_monsoon_om";

// - memoreaza parametri actuali

al_foglevel		= fog;
al_rainlevel	= rain;
al_thundlevel	= lightnings;
al_windlevel	= wind;
publicVariable "al_foglevel";
publicVariable "al_rainlevel";
publicVariable "al_thundlevel";
publicVariable "al_windlevel";

sleep 0.1;

[_duration_monsoon] spawn {
	x_duration_monsoon = _this select 0;
	sleep x_duration_monsoon;

	al_monsoon_om = false;
	publicVariable "al_monsoon_om";

// restaureaza parametri vreme
	60 setFog al_foglevel;
	60 setRain al_rainlevel;
	60 setLightnings al_thundlevel;
	setWind [al_windlevel select 0, al_windlevel select 1, true];
};

[] spawn {
	while {al_monsoon_om} do {
		["bcg_wind","playSound"] call BIS_fnc_MP;
		sleep 60;
	};
};

// seteaza conditii vreme
0 setLightnings 1;

[] spawn {
	_irain=0;
	while {_irain <1} do {
		_irain=_irain+0.01;0 setrain _irain; sleep 0.1;
	};
};

[] spawn {
	_ifog=0;
	while {_ifog <0.5} do {
		_ifog=_ifog+0.001; 0 setFog _ifog; sleep 0.01;
	};
};


// seteaza wind storm functie de directie

raport = 360/_direction_monsoon;
raport = round (raport * (10 ^ 2)) / (10 ^ 2);
//hint str raport;

if (raport >= 4) then {fctx = 1; fcty = 1}
	else {if (raport >= 2) then {fctx = 1; fcty = -1}
						else { if (raport >=1.33) then {fctx = -1; fcty = -1}
												else {fctx = -1; fcty = 1};
						};
	};
if ((raport <= 2) and {(raport >= 1.33)}) then {fctx = -1; fcty = -1};
//hint str fcty;sleep 2;hint str fctx;

_unx	= ((_direction_monsoon - floor (_direction_monsoon/90)*90))*fctx;
//hint str _unx;
//_uny	= 90-_unx;

vx = floor (_unx * 0.6);
vy = (54 - vx)*fcty;

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
		_rand_pl = [] remoteExec ["seven_fnc_alias_hunt", 0, false];
		waitUntil {scriptDone _rand_pl};

	// interval object blow
		sleep 1;

		al_nearobjects = nearestObjects [hunt_alias,[],50];
		ar_obj_eligibl = [];

		{if((_x isKindOf "LandVehicle") or {(_x isKindOf "CAManBase")} or {(_x isKindOf "Air")} or {(_x isKindOf "Wreck")}) then
			{ar_obj_eligibl pushBack _x;};
		} foreach al_nearobjects;

		sleep 1;

		// alege obiect
		_blowobj = selectRandom ar_obj_eligibl;

		//durata_rafala = 1+random 5;	sleep 30+random 120;
		sleep 1;
		[] spawn {
			_rafale = selectRandom ["rafala_1","rafala_2","rafala_4_dr","rafala_5_st","rafala_6","rafala_7","rafala_8","rafala_9"];
			[_rafale,"playSound"] call BIS_fnc_MP;
			//hint str _rafale;
		};

		if (!isNull _blowobj) then {
			_xblow	= 0.1+random 5;
			_yblow	= 0.1+random 5;

			// creste viteza incremental
			_xx=0;
			_yy=0;

			while {(_xx< _xblow) or {(_yy< _yblow)}} do {
				_blowobj setvelocity [_xx*fctx,_yy*fcty,random 0.1];
				_xx = _xx + 0.01;
				_yy = _yy + 0.01;
				sleep 0.001;
			};

		};
	};

};