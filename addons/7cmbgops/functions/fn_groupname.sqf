_dialogResult =
	[
		"Change Callsign",
		[
			["Group Callsign", ""]
		]
	] call Ares_fnc_ShowChooseDialog;
if (count _dialogResult isEqualTo 0) exitWith {hint "User cancelled dialog."; };

_callsign = _dialogResult select 0;
_grp = group player;
_grp setGroupIdGlobal [_callsign];
format["Callsign changed to %1",_callsign] remoteExecCall ["hint", _grp, false];
