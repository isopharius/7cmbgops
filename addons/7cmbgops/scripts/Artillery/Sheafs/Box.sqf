// By Rydygier

private ["_target","_angle","_ct","_position","_pX","_pY","_MpX","_MpY","_trans","_angleI","_mkr","_bPos","_dX0","_dY0"];
params ["_tube", "_pos", "_sizeX", "_sizeY"];

_bPos = getPos _tube;
_ct = 0;

_dX0 = (_pos select 0) - (_bPos select 0);
_dY0 = (_pos select 1) - (_bPos select 1);
_angle = (_dX0 atan2 _dY0);

_position = [(_pos select 0) + (random (2 * _sizeX)) - _sizeX,(_pos select 1) + (random (2 * _sizeY)) - _sizeY,0];

_pX = _pos select 0;
_pY = _pos select 1;

_MpX = _position select 0;
_MpY = _position select 1;

_trans = _pos distance [_MpX,_MpY,0];
_angleI = (_MpX - _pX) atan2 (_MpY - _pY);

_dX =_trans * (sin (_angleI + _angle));
_dY = _trans * (cos (_angleI + _angle));
_MpX = _pX + _dX;
_MpY = _pY + _dY;
_position = [_MpX,_MpY];
_position