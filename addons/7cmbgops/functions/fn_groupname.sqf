
_grp = group player;
_dialogResult =
	[
		format ["Change CallSign [%1] (for cTab)", groupId _grp],
		[
			["New CallSign", ""]
		]
	] call Ares_fnc_ShowChooseDialog;

_cancelhint = "CallSign not changed.";
if (count _dialogResult isEqualTo 0) then {
	hint _cancelhint;

} else {
	_callsign = _dialogResult select 0;
	_grp = group player;
	_grp setGroupIdGlobal [_callsign];
	format["New CallSign [%1]", _callsign] remoteExecCall ["hint", _grp, false];
};
