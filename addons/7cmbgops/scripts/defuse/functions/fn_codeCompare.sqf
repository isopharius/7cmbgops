//Parameters
private _code      = [_this, 0, [], [[]]] call BIS_fnc_param;
private _inputCode = [_this, 1, [], [[]]] call BIS_fnc_param;

//compare codes
private _compare = (_code isEqualTo _inputCode);

if (_compare) then {
	cutText ["BOMB DEFUSED", "PLAIN DOWN"];
	DEFUSED = true;
	playSound "button_close";
} else {
	cutText ["BOMB ARMED", "PLAIN DOWN"];
	ARMED = true;
	playSound "button_wrong";
};

CODEINPUT = [];

//Return Value
_code
