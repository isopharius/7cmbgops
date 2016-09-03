params ["_unit"];
private _magazines = magazines _unit;
private _result = false;
{
    if (_x isEqualTo "rhsusf_m112_mag" || {_x isEqualTo "DemoCharge_Remote_Mag"}) exitWith {
        _result = true;
    };
} count _magazines;

_result;