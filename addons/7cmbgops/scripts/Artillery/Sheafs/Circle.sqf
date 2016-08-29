// By Muzzleflash
// I use this to get a random point in an ellipse. First it picks an uniform random point in a circle. Then it shrinks or enlarges it to get an uniform distribution in an ellipse. (shrinking or enlarging on one axis! will, maybe surprisingly, not ruin the uniform distribution.). It was based on markers and trigger areas. _a and _b are the axis. _angle is the angle of the marker or trigger.:

private["_x","_y","_a","_b","_dir","_mag","_nx","_ny","_temp","_result"];

params ["_pos", "_size"];

_x = _pos select 0;
_y = _pos select 1;

_a = 0;
_b = 0;
_dir = 0;
_mag = 0;
_nx = 0;
_ny = 0;
_temp = 0;
_result = [];

_a = _size;
_b = _size;
_dir = random 360;
//Uniform distribution
_mag = sqrt((random _a)*_a);
_nX = _mag * (sin _dir);
//Shrink or enlarge it along the y-axis/minor axis.
_nY = _mag * (cos _dir) * _b / _a;
//Rotate point
_temp = _nX * cos(-_dir) - _nY * sin(-_dir);
_nY = _nX * sin(-_dir) + _nY * cos(-_dir);
_nX = _temp;
_x = _x + _nX;
_y = _y + _nY;
_result = [_x,_y];
//_result = [_x + _nX, _y + _nY];
_result