params ["_bomb", "_time", "_yield"];

	if ((_time > 0) && (!DEFUSED)) then {
		format["Bomb Detonation in: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring] remoteExecCall ["hintSilent", 0, false];

		if (_time < 1) then {

			[bombcontainer] remoteExecCall ["removeAllActions", 0, true];

			//beeps
			for "_i" from 1 to 29 do {
				[_bomb, "alarm_prepare"] call CBA_fnc_globalSay3d;
				sleep 1;
			};
			//faster
			[_bomb, "alarm_go"] call CBA_fnc_globalSay3d;
			sleep 2;

			[position _bomb, _yield] spawn RHS_fnc_ss21_nuke;
			_bomb setdamage 1;
			BOMB = false;
			publicVariable "BOMB";

		} else {
			if (ARMED) then {
				_time = 0.1;
			} else {
				_time = _time - 30;
				sleep 30;
			};
			[_bomb, _time, _yield] call seven_fnc_bombTimer;
		};
	};

_bomb