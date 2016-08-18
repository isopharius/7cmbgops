private _wire    = [_this,0,"",[""]] call BIS_fnc_param;
private _cutWire = [_this,1,"",[""]] call BIS_fnc_param;

//compare wires
private _compare = (_wire isEqualTo _cutWire);

if (_compare) then {
	cutText ["BOMB DEFUSED", "PLAIN DOWN"];
	DEFUSED = true;
	playSound "button_close";
} else {
	cutText ["BOMB ARMED", "PLAIN DOWN"];
	ARMED = true;
	playSound "button_wrong";
};

//Return Value
_wire
