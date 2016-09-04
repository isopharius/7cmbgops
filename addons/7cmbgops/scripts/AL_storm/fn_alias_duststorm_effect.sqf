// by ALIAS
// Tutorial: https://www.youtube.com/user/aliascartoons
// [[[],"\7cmbgops\scripts\AL_storm\alias_duststorm_effect.sqf"],"BIS_fnc_execVM",true,false] spawn BIS_fnc_MP;

if (!hasInterface) exitWith {};

enableCamShake true;

[] spawn {
	waitUntil {
		ddCamShake [0.3,7,11];
		sleep 15+random 120;
		(!al_duststorm_on)
	};
};

waitUntil {
	effect_screen = ppEffectCreate ["FilmGrain", 2000];
	effect_screen ppEffectEnable true;
	effect_screen ppEffectAdjust [0.1,0.1,0.5,0.1,0.1,true];
	effect_screen ppEffectCommit 0;

	"colorCorrections" ppEffectAdjust[ 0.87, 1, 0.01, [-0.27, 0.17, 0.33, -0.26],[0.76, -0.4, 0.86, 0.86],[-0.57, 0.81, -1.2, 0.88]];
	"colorCorrections" ppEffectCommit 0;
	"colorCorrections" ppEffectEnable true;

	// particule in aer
	_leaves_p  = "#particlesource" createVehicleLocal [0,0,0];
	_leaves_p attachto [player];
	_leaves_p setParticleRandom [0, [10, 10, 7], [4, 4, 5], 2, 0.1, [0, 0, 0, 0.5], 1, 1];
	_leaves_p setParticleCircle [100, [0, 0, 0]];
	_leaves_p setParticleParams [["\A3\data_f\ParticleEffects\Hit_Leaves\Sticks_Green", 1, 1, 1], "", "SpaceObject", 1,27,[0,0,0],[50,50,10],2,0.000001,0.0,0.1,[0.5+random 5],[[0.68,0.68,0.68,1]],[1.5,1],13,13,"","",vehicle player,0,true,1,[[0,0,0,0]]];

	_alias_local_fog = "#particlesource" createVehicleLocal [0,0,0];
	_alias_local_fog attachto [player];
	_alias_local_fog setParticleCircle [10, [3, 3, 0]];
	_alias_local_fog setParticleRandom [10, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0];
	_alias_local_fog setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 12, [0, 0, 0], [-1, -1, 0], 3, 10.15, 7.9, 0.01, [10, 10, 20], [[0.65, 0.5, 0.5, 0], [0.65, 0.6, 0.5, 0.3], [1, 0.95, 0.8, 0]], [0.08], 1, 0, "", "", vehicle player];

	_leaves_p_drop			= 0.1+random 0.1;
	_alias_drop_fog_factor	= 0.01+random 0.1;

	_leaves_p setDropInterval _leaves_p_drop;
	_alias_local_fog setDropInterval _alias_drop_fog_factor;

	sleep 5 + random 10;
	deletevehicle _leaves_p;
	deletevehicle _alias_local_fog;
	(!al_duststorm_on)
};

effect_screen ppEffectEnable false;
"colorCorrections" ppEffectEnable false;
ppEffectDestroy effect_screen;
enableCamShake false;