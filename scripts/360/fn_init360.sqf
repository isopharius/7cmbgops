if ((!isnil "stoptrain") && (stoptrain == 0)) exitwith {};

createCenter east;
createCenter west;

TrainingCourse_TargetList = [];
TrainingCourse_BulletPathTracing = false;
TrainingCourse_BulletCamera = false;
TrainingCourse_BulletCameraAbort = false;

TrainingCourse_ShotsFired = 0;
TrainingCourse_TargetsHit = 0;
TrainingCourse_AverageDistance = 0;
TrainingCourse_AverageTargetScore = 0;
TrainingCourse_AverageImpactDeviation = 0;

setWind [random 4, random 4, true];

stoptrain = 0;

_reset = player addaction [("<t color=""#BBBBBB"">" + "Reset Stats" + "</t>"), seven_fnc_reset_stats, "", 0, false, false];
_clear = player addaction [("<t color=""#BBBBBB"">" + "Clear Targets" + "</t>"), seven_fnc_generate_targets, ["", 0, true, 50, 1500], 0, false, false];
_check = player addaction [("<t color=""#BBBBBB"">" + "Check Impact" + "</t>"), seven_fnc_check_impact, "", 0, false, false];

//_soldier = player addaction [("<t color=""#995599"">" + "Add Soldier" + "</t>"), seven_fnc_create_soldier, ["O_G_Soldier_F", false, false, false], 0, false, false];
//_patrol = player addaction [("<t color=""#995599"">" + "Add Soldier Patrol" + "</t>"), seven_fnc_create_soldier, ["I_G_Soldier_F", false, true, true], 0, false, false];
_skeet = player addaction [("<t color=""#559999"">" + "Launch skeet" + "</t>"), seven_fnc_create_skeet, "", 0, false, false];
_targ = player addaction [("<t color=""#559999"">" + "Add Steel Target" + "</t>"), seven_fnc_create_target, ["TargetP_Inf2_Acc2_NoPop_F", false, false], 0, false, false];
_popup = player addaction [("<t color=""#559999"">" + "Add Steel Popup Target" + "</t>"), seven_fnc_create_target, ["TargetP_Inf2_Acc2_F", false, false], 0, false, false];
_mover = player addaction [("<t color=""#559999"">" + "Add Steel Popup Mover" + "</t>"), seven_fnc_create_target, ["TargetP_Inf2_Acc2_F", false, true], 0, false, false];

_plate = player addaction [("<t color=""#55CC66"">" + "Add Steel Plate" + "</t>"), seven_fnc_create_target, ["Land_Target_Oval_F", false, false], 0, false, false];
_ball = player addaction [("<t color=""#55CC66"">" + "Add balloon target" + "</t>"), seven_fnc_create_balloon_target, ["Land_Balloon_01_water_F", false, false], 0, false, false];

_trace = player addaction [("<t color=""#CCAA44"">" + "Toggle Bullet Path Tracing" + "</t>"), seven_fnc_toggle_path_tracing, "", 0, false, false];
_cam = player addaction [("<t color=""#CCAA44"">" + "Toggle Bullet Camera" + "</t>"), seven_fnc_toggle_bullet_camera, "", 0, false, false];

//player addaction [("<t color=""#AA9977"">" + "King of the hill" + "</t>"), "fnc_king_of_the_hill.sqf", "", 0, false, false];

//_tank = player addaction [("<t color=""#559999"">" + "Add Tank Target" + "</t>"), seven_fnc_create_target, ["O_MBT_02_cannon_F", true, false], 0, false, false];
//player addaction [("<t color=""#559999"">" + "Tank Targets" + "</t>"), "fnc_generate_targets.sqf", ["O_MBT_02_cannon_F", 50, true, 50, 1500], 0, false, false];

_short = player addaction [("<t color=""#999999"">" + "Steel Popup Targets (Short Range)" + "</t>"), seven_fnc_generate_targets, ["TargetP_Inf2_Acc2_F", 100, false, 15, 500], 0, false, false];
_med = player addaction [("<t color=""#999999"">" + "Steel Popup Targets (Medium Range)" + "</t>"), seven_fnc_generate_targets, ["TargetP_Inf2_Acc2_F", 250, false, 50, 1500], 0, false, false];
_long = player addaction [("<t color=""#999999"">" + "Steel Popup Targets (Long Range)" + "</t>"), seven_fnc_generate_targets, ["TargetP_Inf2_Acc2_F", 500, false, 100, 2500], 0, false, false];

_stop = player addaction [("<t color=""#FFFF00"">" + "Stop Training" + "</t>"), {stoptrain = 1;}, "", 0, false, false];

_traceeh = player addEventHandler ["fired", {_this spawn seven_fnc_bullet_trace}];
_cameh = player addEventHandler ["fired", {_this spawn seven_fnc_bullet_camera}];
Projectile_Impact_Aux = "Sign_Sphere10cm_F" createVehiclelocal [0,0,0];


[[_reset,_clear,_check,_skeet,_targ,_popup,_mover,_plate,_ball,_trace,_cam,_short,_med,_long,_stop],[_traceeh,_cameh]] spawn {
	waituntil {!(alive player) || (stoptrain == 1)};

	{
		player removeAction _x;
	} foreach (_this select 0);

	{
		player removeEventHandler ["fired", _x];
	} foreach (_this select 1);

	{
		deletevehicle _x;
	} foreach TrainingCourse_TargetList;

	deletevehicle Projectile_Impact_Aux;
};