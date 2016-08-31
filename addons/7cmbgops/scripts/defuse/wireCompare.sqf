params ["_wire", "_cutWire"];

//compare wires
private _compare = _wire isEqualTo _cutWire;

if (_compare) then {
	cutText ["BOMB DEFUSED!", "PLAIN DOWN"];
	player sidechat "BOMB DEFUSED, YOU ROCK!";
	DEFUSED = true;
	BOMB = false;
	bombcontainer setdamage 1;
	[bombcontainer] remoteExecCall ["removeAllActions", 0, true];
	publicVariable "BOMB";
	publicVariableServer "DEFUSED";
	playSound "button_close";
} else {
	cutText ["BOMB ARMED!", "PLAIN DOWN"];
	player sidechat "BOMB ARMED, NICE TRY!";
	[bombcontainer] remoteExecCall ["removeAllActions", 0, true];
	ARMED = true;
	publicVariableServer "ARMED";
	playSound "button_wrong";
};
