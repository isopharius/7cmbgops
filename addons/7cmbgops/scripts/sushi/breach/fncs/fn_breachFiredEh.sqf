if(!isNull cursorTarget) then {
	private _weap = _this select 1;
	if (_weap in saf_mission_setting_breach_gunClasses) then {
	//if (true) then {
		private _doorArr = [cursorTarget] call seven_fnc_breachGetTargetDoors;
		if(count _doorArr > 0) then {
			_doorArr call seven_fnc_breachOpenDoor;
		};
	};
};
