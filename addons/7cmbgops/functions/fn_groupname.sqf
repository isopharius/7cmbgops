
_grp = group player;
_dialogResult =
	[
		format ["Change current CallSign [%1] (for cTab)", groupId _grp],
		[
			["New CallSign", ""]
		]
	] call Ares_fnc_ShowChooseDialog;
	
if ((count _dialogResult isEqualTo 0) or ((_dialogResult select 0) isEqualTo "")) then {
	hint "CallSign not changed.";

} else {
	_callsign = _dialogResult select 0;
	_grp = group player;
	_grp setGroupIdGlobal [_callsign];
	format["New CallSign [%1]", _callsign] remoteExecCall ["hint", _grp, false];
};
