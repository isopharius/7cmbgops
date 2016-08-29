params ["_tube"];

_markerName = format ["%1veh",_tube];
_marker = createMarkerLocal [_markerName,(getPos _tube)];
_markerName = format ["%1gun",_tube];
_marker2 = createMarkerLocal [_markerName,(getPos _tube)];

_marker setMarkerSizeLocal [1,1];
_marker setMarkerTypeLocal "n_mortar";
_marker setMarkerColorLocal "ColorGreen";
_marker2 setMarkerSizeLocal [1,1];
_marker2 setMarkerTypeLocal "mil_arrow";
_marker2 setMarkerColorLocal "ColorBlue";

_gunDir = 0;
_v = [];

//systemChat format ["W: %1",(weapons _tube)];
_weapon = (weapons _tube) select 0;
//systemChat format ["W: %1",_weapon];

_go = true;
//while {(alive _tube)} do {
while {_go} do {
	_marker setMarkerPos (getPos _tube);
	_marker setMarkerDir (getDir _tube);
	_marker2 setMarkerPos (getPos _tube);
	_v = (_tube weaponDirection _weapon);
	_gunDir = (_v select 0) atan2 (_v select 1);
	_marker2 setMarkerDir _gunDir;
	//systemChat format ["D: %1",(_tube weaponDirection _weapon)];
	//systemChat format ["D: %1",time];
	sleep 0.1;
};