
_grp = group player;
_dialogResult =
	[
		format ["Change Callsign %1 (for cTab)", groupId _grp],
		[
			["New Callsign", ""]
		]
	] call Ares_fnc_ShowChooseDialog;

_cancelhint = "Callsign not changed.";
if (count _dialogResult isEqualTo 0) then {
	hint _cancelhint;

} else {
	_callsign = _dialogResult select 0;
	_grp = group player;
	_grp setGroupIdGlobal [_callsign];
	format["Callsign changed to %1", _callsign] remoteExecCall ["hint", _grp, false];
};
