params [["_wire","",[""]],["_cutWire",""[""]]];

//compare wires
private _compare = (_wire isEqualTo _cutWire);

if (_compare) then {
	cutText ["BOMB DEFUSED!", "PLAIN DOWN"];
	DEFUSED = true;
	playSound "button_close";
} else {
	cutText ["BOMB ARMED!", "PLAIN DOWN"];
	ARMED = true;
	playSound "button_wrong";
};

//Return Value
_wire
