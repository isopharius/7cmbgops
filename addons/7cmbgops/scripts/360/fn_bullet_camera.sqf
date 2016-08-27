if !(TrainingCourse_BulletCamera) exitWith {};

params ["_unit"];
private _bullet = _this select 6;

waitUntil {(_unit distance _bullet) > 10.0};

if (vectorMagnitudeSqr (getPosworld _bullet) isEqualTo 0) exitWith {};

TrainingCourse_BulletCameraAbort = false;
waitUntil {!isNull (findDisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this select 1) isEqualTo 28) then {TrainingCourse_BulletCameraAbort = true;};"];

private _camera = "Camera" camCreate (getPosworld _bullet);
_camera camSetTarget _bullet;
_camera cameraEffect ["INTERNAL","BACK"];
_camera camSetFOV 0.7;

ShowCinemaBorder false;

cutText ["Press 'Enter' to exit the bullet camera", "PLAIN DOWN"];

while {(alive _bullet) && !TrainingCourse_BulletCameraAbort} do
{
	_camera camSetPos (getPosworld _bullet);
	_camera camCommit 0.1;
	sleep 0.001;
	if (vectorMagnitudeSqr (getPosworld _bullet) > 0) then
	{
		private _camPos = (getPosworld _bullet);
		sleep 0.009;
		private _camTgt = (getPosworld _bullet);
	};
};

cutText ["", "PLAIN DOWN"];

_camera camSetPos _camPos;
_camera camSetTarget _bullet;
_camera camCommit 2.0;
sleep 2.0;

_camera CameraEffect ["terminate", "back"];
CamDestroy _camera;
