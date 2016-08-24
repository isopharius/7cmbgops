disableSerialization;
private _doorArr = [cursorTarget] call seven_fnc_breachGetTargetDoors;
private _actStatus = false;
private _state = animationState player;
private _stance = stance player;

call {
	if (_stance isEqualTo "PRONE") exitWith {
		_stance  = "Dwon";
	};
	if (_stance isEqualTo "CROUCH") exitWith {
		_stance  = "Crouch";
	};
	if (_stance isEqualTo "STAND") then {
		_stance  = "Up";
	};
};

if(count _doorArr > 0) then {

	player playMove "Acts_carFixingWheel";
	sleep 1.5;
	[player,"Acts_carFixingWheel"] remoteExecCall ["switchMove"];
	_actStatus = [SAF_STR_BREACH_LOCKPICKING,20,player,[getPos player,5]] call seven_fnc_showStatus;
	[player,_state] remoteExecCall ["switchMove"];

	if (_actStatus) then {
		private _d = _doorArr select 0;
		private _s = _doorArr select 1;
		{
			_d setVariable [format ["bis_disabled_%1", _x], 0,true];
		} foreach _s;
		hint SAF_STR_BREACH_STATUS_OPEN;
	};
};