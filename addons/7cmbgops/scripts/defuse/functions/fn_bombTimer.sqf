params [["_bomb", objNull, [objNull]], ["_time", 0, [0]]];

//Validate parameters
if (isNull _bomb) exitWith {};

_while = {
	if (_time > 0 && !DEFUSED) then {
		_time = _time - 2;
		hintSilent format["Bomb Detonation: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];

		if (_time < 1) then {
			_blast = createVehicle ["HelicopterExploSmall", position _bomb, [], 0, "NONE"];
		};
		if (ARMED) then {
			_time = 5;
			ARMED = false;
		};

		sleep 2;
		call _while;
	};
};
call _while;

//Return Value
_bomb
