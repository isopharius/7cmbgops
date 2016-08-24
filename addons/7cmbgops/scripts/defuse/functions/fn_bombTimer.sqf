params [["_bomb", _bomb], ["_time", _time], ["_yield", _yield]];

	if (_time > 0 && !DEFUSED) then {
		hintSilent format["Bomb Detonation in: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];

		if (_time < 1) then {
			if (isServer) then {
				removeAllActions _bomb;

				for "_i" from 0 to 9 do {
					[_bomb, "alarm_prepare"] call CBA_fnc_globalSay3d;
					sleep 1;
				};

				[position bombcontainer, _yield] spawn RHS_fnc_ss21_nuke;
				_bomb setdamage 1;
				BOMB = false;
				publicVariable "BOMB";
			};
		} else {
			if (ARMED) then {
				_time = 0.1;
			} else {
				_time = _time - 30;
				sleep 30;
			};
			call seven_fnc_bombTimer;
		};
	};

//Return Value
_bomb