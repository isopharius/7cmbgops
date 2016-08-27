params ["_inputNumber"];
private "_number";

private _decNumber = ((round (10 * (_inputNumber)))/10);

//degrees
private _number = (_decNumber / 100); //default formula for Stratis
private _degNumber = abs(round _number);
//minutes
_number = (_number - _degNumber);
_number = (_number * 60);
private _minNumber = abs(round _number);
if (_minNumber > 60) then {_minNumber = 59};
//seconds
_number = (_number - _minNumber);
_number = (_number * 60);
private _secNumber = abs(round _number);
if (_secNumber > 60) then {_secNumber = 59};

private _coordinatesDMS = format ["%1° %2´ %3´´",_degNumber,_minNumber,_secNumber];

_coordinatesDMS;