if (!hasInterface) exitWith {};
params ["_tsource"];

_tsourcepos = getPos _tsource;

[_tsource] spawn {
	params ["_tsource"];
	while {(!isNull _torsouce)} do {
		if ((player distance _tsourcepos) < 300) then {
			addCamShake [0.3,7,11];
			sleep 10 + random 60;
		};
		sleep 5
	};
};

enableCamShake true;

// vartej alb
_vartej_alb = "#particlesource" createVehicleLocal _tsourcepos;
_vartej_alb setParticleCircle [50, [0.2, -0.5, 0.9]];
_vartej_alb setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0.3], 0, 1, [0, 0, 0, 0.1], 0, 0];
_vartej_alb setParticleParams [["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 0.75], 15, 17, 13, 0.7, [15, 17, 19], [[0.5, 0.5, 0.5, 0.3], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 0.1, 3, "", "", _tsource];
_vartej_alb setDropInterval 0.05;

// resturi
_leaves  = "#particlesource" createVehicleLocal _tsourcepos;
_leaves setParticleCircle [35, [10, -10, 0]];
_leaves setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 2, 0.25, [0, 0, 0, 0.1], 1, 1];
_leaves setParticleParams [["\A3\data_f\ParticleEffects\Hit_Leaves\Sticks_Green", 1, 1, 1], "", "SpaceObject", 1, 15, [0, 0, 5], [0, 0, 25], 0.75, 15, 7.9, 0.085, [5, 5, 5], [[0, 0, 0, 1], [0.25, 0.25, 0.25, 0.5]], [0.08], 1, 0.25, "", "",_tsource];
_leaves setDropInterval 0.3;

// vartej mic
_vartej_mic = "#particlesource" createVehicleLocal _tsourcepos;
_vartej_mic setParticleCircle [20, [1, -1, 0]];
_vartej_mic setParticleRandom [2, [0.25, 0.25, 1], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 1, 0.5];
_vartej_mic setParticleParams [["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 7, [0, 0, 0], [0, 0, 0.75], 47, 12.5, 9.6, 0.05, [7, 11, 11], [[0.5, 0.5, 0.5, 0], [0.25, 0.25, 0.25, 1], [0.5, 0.5, 0.5, 0]], [0.08], 0.1, 0.5, "", "", _tsource];
_vartej_mic setDropInterval 0.05;

// VARTEJ INALT
_urcet = "#particlesource" createVehicleLocal _tsourcepos;
_urcet setParticleCircle [1, [9, 7, 17]];
_urcet setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0.3], 0, 1, [0, 0, 0, 0.1], 0, 0];
_urcet setParticleParams [["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 20 /*viata*/, [0, 0, 20], [-10, 10, 10 /*viteza verticala*/], 63, 5.5, 7, 0.1,[7, 8, 11, 15, 19, 17, 21, 23, 43, 83], [[0.1, 0.1, 0.1, 0], [0.25, 0.25, 0.25, 0.5], [1, 1, 1, 0.5], [0.25, 0.25, 0.25, 0.5],[0.1, 0.1, 0.1, 0.8]], [0.08], 0.2, 0.9, "", "", _tsource];
_urcet setDropInterval 0.002;

// local resturi

    _Leaves_Green = "#particlesource" createVehicleLocal [0,0,0];
    _Leaves_Green attachto [player];
    _Leaves_Green setParticleParams [["\A3\data_f\ParticleEffects\Hit_Leaves\Leaves_Green.p3d", 1, 0, 1],"","SpaceObject",1,7,[0,0,0],[0,0,0],1,0.000001,0,1.4,[1],[[0.68,0.68,0.68,1]],[0,1],0.2,1.2,"","",vehicle player];
    _Leaves_Green setParticleRandom [0, [10, 10, 7], [4, 4, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
    _Leaves_Green setParticleCircle [0.0, [0, 0, 0]];

	_Leaves_leaf = "#particlesource" createVehicleLocal [0,0,0];
    _Leaves_leaf attachto [player];
    _Leaves_leaf setParticleParams [["\A3\data_f\cl_leaf", 1, 0, 1],"","SpaceObject",1,7,[0,0,0],[0,0,0],1,0.000001,0,1.4,[1],[[0.68,0.68,0.68,1]],[0,1],0.2,1.2,"","",vehicle player];
    _Leaves_leaf setParticleRandom [0, [10, 10, 7], [4, 4, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
    _Leaves_leaf setParticleCircle [0.0, [0, 0, 0]];



	_WoodParts = "#particlesource" createVehicleLocal [0,0,0];
    _WoodParts attachto [player];
    _WoodParts setParticleParams [["\A3\data_f\ParticleEffects\Universal\WoodParts_01.p3d", 1, 0, 1],"","SpaceObject",1,7,[0,0,0],[0,0,0],1,0.000001,0,1.4,[1],[[0.68,0.68,0.68,1]],[0,1],0.2,1.2,"","",vehicle player];
    _WoodParts setParticleRandom [0, [10, 10, 7], [4, 4, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
	_WoodParts setParticleCircle [0.0, [0, 0, 0]];

	_leaves_p  = "#particlesource" createVehicleLocal [0,0,0];
	_leaves_p attachto [player];
	_leaves_p setParticleRandom [0, [10, 10, 7], [4, 4, 5], 2, 0.1, [0, 0, 0, 0.5], 1, 1];
	_leaves_p setParticleCircle [100, [0, 0, 0]];
	_leaves_p setParticleParams [["\A3\data_f\ParticleEffects\Hit_Leaves\Sticks_Green", 1, 1, 1], "", "SpaceObject", 1,27,[0,0,0],[50,50,10],2,0.000001,0.0,0.1,[0.5+random 5],[[0.68,0.68,0.68,1]],[1.5,1],13,13,"","",vehicle player,0,true,1,[[0,0,0,0]]];

	_Leaves_Green setDropInterval 0.3;
	_Leaves_leaf setDropInterval 0.3;
	_WoodParts setDropInterval 0.3;
	_leaves_p setDropInterval 3;


waitUntil {
	effect_screen = ppEffectCreate ["FilmGrain", 2000];
	effect_screen ppEffectEnable true;
	effect_screen ppEffectAdjust [0.1,0.1,0.5,0.1,0.1,true];
	effect_screen ppEffectCommit 0;
	sleep 30;
	(isNull _tsource)
};

effect_screen ppEffectEnable false;
ppEffectDestroy effect_screen;
enableCamShake false;
deletevehicle _Leaves_Green;
deletevehicle _WoodParts;
deletevehicle _Leaves_leaf;
deletevehicle _leaves_p;