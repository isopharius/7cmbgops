        _taskID = [_this,0,"",[""]] call BIS_fnc_param;
        _taskVar = [_taskID] call BIS_fnc_taskVar;
        missionNamespace setVariable [_taskVar,nil];
        player removeSimpleTask ([_taskID,player] call BIS_fnc_taskReal);
        _playerTasks = player getVariable ["BIS_fnc_setTaskLocal_tasks",[]];
        _playerTasks = _playerTasks - [_taskID];
        player setVariable ["BIS_fnc_setTaskLocal_tasks", _playerTasks];
        _playerTaskVar = "BIS_fnc_taskvar_" + _taskID;
        player setVariable [_playerTaskVar,nil];