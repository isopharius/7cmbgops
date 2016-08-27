private ["_impactDeviation", "_targetScore"];

if (TrainingCourse_ShotsFired isEqualTo 0) exitWith {};

TrainingCourse_TargetsHit = (TrainingCourse_TargetsHit + 1) min TrainingCourse_ShotsFired;

params ["_target", "_unit", "_bullet", "_position", "_velocity", "_ammo"];

private _vectorToTarget = (getPosworld _unit) vectorDiff _position;
private _distance = vectorMagnitude _vectorToTarget;

TrainingCourse_AverageDistance = TrainingCourse_AverageDistance + (_distance - TrainingCourse_AverageDistance) / TrainingCourse_TargetsHit;

private _accuracy = TrainingCourse_TargetsHit / TrainingCourse_ShotsFired;
private _score = (_accuracy * TrainingCourse_AverageDistance / 25) min 100;

if ((typeOf _target) in ["TargetP_Inf_Acc2_F", "TargetP_Inf2_Acc2_F", "TargetP_Inf_Acc2_NoPop_F", "TargetP_Inf2_Acc2_NoPop_F"]) then
{
	private _targetDir = getDir _target;
	_impactDeviation = _position vectorDiff (getPosworld _target);
	_impactDeviation = _impactDeviation vectorDiff [sin(_targetDir) * 0.16, cos(_targetDir) * 0.16, 0.85];
	_impactDeviation = vectorMagnitude _impactDeviation;

	TrainingCourse_AverageImpactDeviation = TrainingCourse_AverageImpactDeviation + (_impactDeviation - TrainingCourse_AverageImpactDeviation) / TrainingCourse_TargetsHit;

	_targetScore = 0;

	if (_impactDeviation < 0.0575 * 4.0) then
	{
		_targetScore = 1;
	};
	if (_impactDeviation < 0.0575 * 3.0) then
	{
		_targetScore = 2;
	};
	if (_impactDeviation < 0.0575 * 2.0) then
	{
		_targetScore = 3;
	};
	if (_impactDeviation < 0.0575 * 1.0) then
	{
		_targetScore = 4;
	};
	if (_impactDeviation < 0.0575 * 0.5) then
	{
		_targetScore = 5;
	};

	TrainingCourse_AverageTargetScore = TrainingCourse_AverageTargetScore + (_targetScore - TrainingCourse_AverageTargetScore) / TrainingCourse_TargetsHit;

	hintSilent format["RemV: %1 m/s\nDistance: %2 m\nTarget score: %3/5\n\n---- Average ----\nTarget score: %4/5\nAccuracy: %5/100\nScore: %6/100",
	Round(_velocity call BIS_fnc_magnitude), Round(_distance * 10) / 10, _targetScore, Round(TrainingCourse_AverageTargetScore * 100) / 100, Round(_accuracy * 10000) / 100, Round(_score * 100) / 100];
} else
{
	hintSilent format["RemV: %1 m/s\nDistance: %2 m\n\n---- Average ----\nAccuracy: %3/100\nScore: %4/100",
	Round(_velocity call BIS_fnc_magnitude), Round(_distance * 10) / 10, Round(_accuracy * 10000) / 100, Round(_score * 100) / 100];
};

Projectile_Impact_Aux setposworld _position;

PlaySound "Hit";
