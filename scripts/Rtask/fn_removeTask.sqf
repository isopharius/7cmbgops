        _targets = [_this,0,true,[true,sideunknown,grpnull,objnull,[]]] call BIS_fnc_param;
        _taskID = [_this,1,"",[""]] call BIS_fnc_param;

        {
            _target = _x;
            if ((typeName _target) == (typeName GrpNull)) then {
                [[_taskID],"seven_fnc_removeTaskLocal",units _target,true,true] call BIS_fnc_MP;
            } else {
                [[_taskID],"seven_fnc_removeTaskLocal",_target,true,true] call BIS_fnc_MP;
            };
        } foreach [_targets];