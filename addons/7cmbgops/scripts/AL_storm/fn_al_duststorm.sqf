// by ALIAS
// Monsoon SCRIPT
// Tutorial: https://www.youtube.com/user/aliascartoons
//null = [direction_monsoon, duration_monsoon, effect_on_objects] execvm "\7cmbgops\scripts\AL_storm\al_duststorm.sqf"

if (!isServer) exitWith {};

params ["_direction_duststorm", "_duration_duststorm", "_effect_on_objects", "_dust_wall"];

//hint str _direction_duststorm;

al_duststorm_on = true;
publicVariable "al_duststorm_on";

al_foglevel		= fog;
al_rainlevel	= rain;
al_thundlevel	= lightnings;
al_windlevel	= wind;
publicVariable "al_foglevel";
publicVariable "al_rainlevel";
publicVariable "al_thundlevel";
publicVariable "al_windlevel";

sleep 0.1;

[_duration_duststorm] spawn {
	x_duration_storm = _this select 0;
	sleep x_duration_storm;

	al_duststorm_on = false;
	publicVariable "al_duststorm_on";

// restaureaza parametri vreme
	60 setFog al_foglevel;
	60 setRain al_rainlevel;
	60 setLightnings al_thundlevel;
	setWind [al_windlevel select 0, al_windlevel select 1, true];
};

[] spawn {
	waitUntil {
		["bcg_wind"] remoteExecCall ["playSound", 0, true];
		sleep 60;
		(!al_duststorm_on)
	};
};

//30 setrain 0;30 setLightnings 0;

[] spawn {
	_ifog=0;
	waitUntil {
		_ifog=_ifog+0.001; 0 setFog _ifog; sleep 0.01;
		!(_ifog <0.3)
	};
};

[] remoteExec ["seven_fnc_alias_duststorm_effect", 0, true];

if (_dust_wall) then {
	// perete de praf
	_rand_pl = [] spawn seven_fnc_alias_hunt;
	waitUntil {sleep 0.1; scriptDone _rand_pl};

	//_origine_storm = -1*_direction_duststorm;

	//_pozstorm = getpos hunt_alias;
	_rapoz = 360-_direction_duststorm;

	_xpoz= 0;
	_ypoz= 0;

	if (_rapoz>=315) then {_xpoz = 0; _ypoz = -800};
	if (_rapoz <45) then {_xpoz = 0; _ypoz = -800};
	if ((_rapoz <90) and (_rapoz >=45)) then {_xpoz = 800; _ypoz = 0};
	if ((315>_rapoz) and (_rapoz>=270)) then {_xpoz = -800; _ypoz = 0};
	if ((270>_rapoz) and (_rapoz>=225)) then {_xpoz = -800; _ypoz = 0};
	if ((225>_rapoz) and (_rapoz>=180)) then {_xpoz = 0; _ypoz = 800};
	if ((180>_rapoz) and (_rapoz>=135)) then {_xpoz = 0; _ypoz = 800};
	if ((135>_rapoz) and (_rapoz>=90)) then {_xpoz = 800; _ypoz = 0};

	//hint str _xpoz;sleep 1;hint str _ypoz;

	_pozobcj = [(getPos hunt_alias select 0) + _xpoz, (getPos hunt_alias select 1) + _ypoz, 0];

	_xadd = 0;
	_yadd = 0;

	if ((_ypoz == -800) or ((_ypoz == 800))) then {_yadd =0; _xadd = 160};
	if ((_xpoz == -800) or ((_xpoz == 800))) then {_yadd =160; _xadd = 0};

	_stormsource = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_stormsource setPos _pozobcj;

	_stormsource_1 = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_stormsource_1 setPos [(_pozobcj select 0)-2*_xadd,(_pozobcj select 1)-2*_yadd,0];

	_stormsource_2 = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_stormsource_2 setPos [(_pozobcj select 0)-_xadd,(_pozobcj select 1)-_yadd,0];

	_stormsource_3 = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_stormsource_3 setPos [(_pozobcj select 0)+_xadd,(_pozobcj select 1)+_yadd,0];

	_stormsource_4 = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_stormsource_4 setPos [(_pozobcj select 0)+2*_xadd,(_pozobcj select 1)+2*_yadd,0];

	_stormsource_5 = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_stormsource_5 setPos [(_pozobcj select 0)-3*_xadd,(_pozobcj select 1)-3*_yadd,0];

	_stormsource_6 = createVehicle ["Land_HelipadEmpty_F",[0,0,0], [], 0, "CAN_COLLIDE"];
	_stormsource_6 setPos [(_pozobcj select 0)+3*_xadd,(_pozobcj select 1)+3*_yadd,0];

	[_stormsource,_stormsource_1,_stormsource_2,_stormsource_3,_stormsource_4,_stormsource_5,_stormsource_6] spawn {
		_storm = _this select 0;
		_storm_1 = _this select 1;
		_storm_2 = _this select 2;
		_storm_3 = _this select 3;
		_storm_4 = _this select 4;
		_storm_5 = _this select 5;
		_storm_6 = _this select 6;

		_xadv = 0;
		_yadv =0;

		// depl vert
		if (((getPos _storm select 1)-(getPos hunt_alias select 1)) > 0) then {
		_xadv = 0;_yadv =-1;
		} else {_xadv = 0;_yadv =1;};

		// depl oriz
		if (((getPos _storm select 0)-(getPos hunt_alias select 0)) > 0) then {
		_xadv = -1;_yadv =0;
		} else {_xadv = 1;_yadv =0;};

		//hint str _xadv;
		waitUntil {
			_storm setPos [(getPos _storm select 0)+_xadv,(getPos _storm select 1)+_yadv,0];
			_storm_1 setPos [(getPos _storm_1 select 0)+_xadv,(getPos _storm_1 select 1)+_yadv,0];
			_storm_2 setPos [(getPos _storm_2 select 0)+_xadv,(getPos _storm_2 select 1)+_yadv,0];
			_storm_3 setPos [(getPos _storm_3 select 0)+_xadv,(getPos _storm_3 select 1)+_yadv,0];
			_storm_4 setPos [(getPos _storm_4 select 0)+_xadv,(getPos _storm_4 select 1)+_yadv,0];
			_storm_5 setPos [(getPos _storm_5 select 0)+_xadv,(getPos _storm_5 select 1)+_yadv,0];
			_storm_6 setPos [(getPos _storm_6 select 0)+_xadv,(getPos _storm_6 select 1)+_yadv,0];
			sleep 5;
			(!al_duststorm_on)
		};
	};

	sleep 0.1;

	[_stormsource] spawn {
		_stormsource_s = _this select 0;
		waitUntil {
			[_stormsource_s, "uragan_1"] call CBA_fnc_globalSay3d;
			sleep 60;
			(!al_duststorm_on)
		};
	};

	[_stormsource,_duration_duststorm] remoteExec ["seven_fnc_alias_dust_wall", 0, false];
	sleep 0.1;
	[_stormsource_1,_duration_duststorm] remoteExec ["seven_fnc_alias_dust_wall", 0, false];
	sleep 0.1;
	[_stormsource_2,_duration_duststorm] remoteExec ["seven_fnc_alias_dust_wall", 0, false];
	sleep 0.1;
	[_stormsource_3,_duration_duststorm] remoteExec ["seven_fnc_alias_dust_wall", 0, false];
	sleep 0.1;
	[_stormsource_4,_duration_duststorm] remoteExec ["seven_fnc_alias_dust_wall", 0, false];
	sleep 0.1;
	[_stormsource_5,_duration_duststorm] remoteExec ["seven_fnc_alias_dust_wall", 0, false];
	sleep 0.1;
	[_stormsource_6,_duration_duststorm] remoteExec ["seven_fnc_alias_dust_wall", 0, false];
};


// seteaza wind storm functie de directie
raport = 360/_direction_duststorm;
raport = round (raport * (10 ^ 2)) / (10 ^ 2);

if (raport >= 4) then {fctx = 1; fcty = 1;}
	else {if (raport >= 2) then {fctx = 1; fcty = -1;}
						else { if (raport >=1.33) then {fctx = -1; fcty = -1;}
												else {fctx = -1; fcty = 1;};
						};
	};
if ((raport <= 2) and (raport >= 1.33)) then {fctx = -1; fcty = -1;};

_unx	= ((_direction_duststorm - floor (_direction_duststorm/90)*90))*fctx;

vx = floor (_unx * 0.6);
vy = (54 - vx)*fcty;

// mareste incremental vantul
inx = 0;
iny = 0;

incr = true;
incrx = false;
incry = false;

waitUntil {
	sleep 0.01;
	if (inx < abs vx) then {inx = inx+0.1;} else {incrx = true};
	if (iny < abs vy) then {iny = iny+0.1} else {incry = true};
	if (incrx and incry) then {incr=false};
	winx = floor (inx*fctx);
	winy = floor (iny*fcty);
	setWind [winx,winy,true];
	(!incr)
};

if (_effect_on_objects) then {

	while {al_duststorm_on} do {
		_rand_pl = [] spawn seven_fnc_alias_hunt;
		waitUntil {sleep 0.1; (scriptDone _rand_pl)};

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
			_rafale = selectRandom ["rafala_1","sandstorm","rafala_4_dr","rafala_5_st","rafala_7"];
			[_rafale] remoteExecCall ["playSound", 0, false];
			//hint str _rafale;
		};

		if (!isNull _blowobj) then {
			_xblow	= 0.1+random 5;
			_yblow	= 0.1+random 5;

			// creste viteza incremental
			_xx=0;
			_yy=0;

			waitUntil {
				_blowobj setvelocity [_xx*fctx,_yy*fcty,random 0.1];
				_xx = _xx + 0.01;
				_yy = _yy + 0.01;
				sleep 0.001;
				((_xx < _xblow) or {(_yy < _yblow)})
			};
		};
	};
};

//deleteVehicle _stormsource;deleteVehicle _stormsource_1;deleteVehicle _stormsource_2;deleteVehicle _stormsource_3;deleteVehicle _stormsource_4;deleteVehicle _stormsource_5;deleteVehicle _stormsource_6;