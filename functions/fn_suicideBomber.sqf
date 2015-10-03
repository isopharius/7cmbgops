_bomber = _this select 0;
_targetSide = _this select 1;
_explosiveClass = _this select 2;
_info = [_bomber,_targetSide,_explosiveClass];

_bomber setSkill 0;
_bomber allowFleeing 1;
{_bomber disableAI _x} forEach ["AUTOTARGET","TARGET","FSM"];

	_nearUnit = [];
	{
		if ((count _nearUnit < 3) && (_x != _bomber) && (alive _x) && (side _x in _targetSide)) then {_nearUnit pushback _x};
	} forEach nearestObjects [_bomber,["CAManBase","LandVehicle"],1000];
	sleep 0.1;
	if(count _nearUnit != 0) then
	{
		_rnd 	= floor (random (count(_nearUnit)));
		_victim = _nearUnit select _rnd;

		_pos = position _victim;
		_bomber doMove _pos;
		sleep 0.1;
		waitUntil {_bomber distance _pos < 25 || !alive _bomber || !alive _victim};
		if (!alive _bomber) exitwith {};
		if (!alive _victim) then {
			_nearunit deleteat _rnd;
			if (count _nearUnit == 0) exitwith {};
			_rnd 	= floor (random (count(_nearUnit)));
			_victim = _nearUnit select _rnd;
		};
		_pos = position _victim;
		if (rating _bomber > -2001) then {
			_bomber addRating -10000000;
		};
		sleep 0.1;
		_pos = position _victim;
		_bomber doMove _pos;
		waitUntil {_bomber distance _pos < 10 || !alive _bomber || !alive _victim};
		if (!alive _bomber) exitwith {};
		if (!alive _victim) then {
			_nearunit deleteat _rnd;
			if (count _nearUnit == 0) exitwith {};
			_victim = _nearUnit call BIS_fnc_selectRandom;
		};
		_pos = position _victim;
		_bomber doMove _pos;
		if (vehicle _bomber == _bomber) then {
			_shout = ["Alive_Allah","allahu_akbar1","allahu_akbar2","allahu_akbar3"] call BIS_fnc_selectRandom;
			[_bomber, _shout] spawn CBA_fnc_globalSay3d;
			sleep 0.1;
			[_bomber, "Alive_Beep"] spawn CBA_fnc_globalSay3d;
		};
		sleep 0.1;
		_pos = position _victim;
		_bomber doMove _pos;
		waitUntil {_bomber distance _pos < 5 || !alive _bomber || !alive _victim};
		if (!alive _bomber) exitwith {};
		sleep 0.1;
		_pos = position _bomber;
		if ((_explosiveClass) == "Nuke") then {
			[[_pos,200], "RHS_fnc_ss21_nuke", false, false, true] call BIS_fnc_MP;
		} else {
			createVehicle [_explosiveClass, [(_pos select 0),(_pos select 1),(_pos select 2) - 1], [], 0, "can_collide"];
		};
	};