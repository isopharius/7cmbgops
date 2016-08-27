private "_color";

TrainingCourse_ShotsFired = TrainingCourse_ShotsFired + 1;

if !(TrainingCourse_BulletPathTracing) exitWith {};

params ["_unit"];
private _bullet = _this select 6;

while {alive _bullet} do {
	private _bulletVelocity = velocity _bullet;
	private _v = _bulletVelocity call BIS_fnc_magnitude;
	if (isNil ("_mv")) then {private _mv = _v;};

	call {
		if (_v / _mv >= .75) exitWith {_color = [1,0,0,1]};
		if (_v / _mv >= .50) exitWith {_color = [1,1,0,1]};
		if (_v / _mv >= .25) exitWith {_color = [0,1,0,1]};
		if (_v / _mv >= .10) exitWith {_color = [0,0,1,1]};
		if (_v / _mv >= 0.0) then {_color = [1,1,1,1]};
	};

	drop ["\A3\data_f\missileSmoke","","Billboard",0.1,8,getPosworld _bullet,[0,0,0],0,1.275,1,0,[0.1 + 0.001*(_unit distance _bullet),0.1],[_color,_color],[1,0],0,0,"","",""];
	sleep 0.01;
};
