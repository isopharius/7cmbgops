params ["_wire", "_cutWire"];

//compare wires
private _compare = _wire isEqualTo _cutWire;

if (_compare) then {
	cutText ["BOMB DEFUSED!", "PLAIN DOWN"];
	player sidechat "BOMB DEFUSED, YOU ROCK!";
	DEFUSED = true;
	publicVariable "DEFUSED";
	bombcontainer setdamage 1;
	removeAllActions bombcontainer;
	BOMB = false;
	publicVariable "BOMB";
	playSound "button_close";
} else {
	cutText ["BOMB ARMED!", "PLAIN DOWN"];
	player sidechat "BOMB ARMED, NICE TRY!";
	removeAllActions bombcontainer;
	ARMED = true;
	publicVariable "ARMED";
	playSound "button_wrong";
};

//Return Value
_wire
