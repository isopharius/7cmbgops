params ["_code", "_inputCode"];

//compare codes
private _compare = _code isEqualTo _inputCode;

if (_compare) then {
	cutText ["BOMB DEFUSED!", "PLAIN DOWN"];
	player sidechat "BOMB DEFUSED, YOU ROCK!";
	DEFUSED = true;
	BOMB = false;
	bombcontainer setdamage 1;
	[bombcontainer] remoteExec ["removeAllActions", 0, true];
	publicVariableServer "DEFUSED";
	publicVariable "BOMB";
	playSound "button_close";
} else {
	cutText ["BOMB ARMED!", "PLAIN DOWN"];
	player sidechat "BOMB ARMED, BETTER LUCK NEXT TIME!";
	ARMED = true;
	publicVariableServer "ARMED";
	playSound "button_wrong";
};

CODEINPUT = [];

_code
