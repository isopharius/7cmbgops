// Called from

if NOT(dialog) then {createDialog "dtaDialogAssets"};
disableSerialization;
_dialog = findDisplay 100;

_list = _dialog displayCtrl 102;
lbClear _list;
_timeStamp = [];
_mission = [];
_count = 0;
_missions = [];
_missions = dtaAllMissions;
_missionType = "";
_mType = "";
_hour = "";
_min = "";
_timeText = "";
_ammoType = "";
_x = 0;
_y = 0;

_xText = "";
_yText = "";

while {((count _missions) > 0)} do {
	_mission = _missions select 0;
	_missions = _missions - [_mission];
	if ((_mission select 0) isEqualTo dtaSelectedAsset) then {
		_timeStamp = _mission select 8;
		_hour = format ["%1",(_timeStamp select 0)];
		_min = format ["%1",(_timeStamp select 1)];
		if ((_timeStamp select 0) < 10) then {_hour = format ["0%1",(_timeStamp select 0)]};
		if ((_timeStamp select 1) < 10) then {_min = format ["0%1",(_timeStamp select 1)]};
		_timeText = format ["%1%2",_hour,_min];
		_missionType = _mission select 5;
		_mType = "";
		if (_missionType isEqualTo "PLOT") then {_mType = "(RDY)"};
		_ammoType = [(_mission select 2)] call dta_fnc_AmmoType;
		_x = (_mission select 13) select 0;
		_y = (_mission select 13) select 1;
		_xText = [_x] call dta_fnc_FormatCoordinates;
		_yText = [_y] call dta_fnc_FormatCoordinates;
		_list lbAdd format["%1: [%2,%3] %4 x %5 %6, %7 angle, %8 sheaf%9%10",_timeText,_xText,_yText,_ammoType,(_mission select 3),(_mission select 11),(_mission select 6),(_mission select 10),(_mission select 12),_mType];
		_list lbSetValue [(lbSize _list)-1,_count];
	};
	_count = _count + 1;
};