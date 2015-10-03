	(_this select 0);
	_fnc_scriptNameParentTemp = if !(isnil '_fnc_scriptName') then {_fnc_scriptName} else {'BIS_fnc_garage'};
	private ['_fnc_scriptNameParent'];
	_fnc_scriptNameParent = _fnc_scriptNameParentTemp;
	_fnc_scriptNameParentTemp = nil;
	private ['_fnc_scriptName'];
	_fnc_scriptName = 'BIS_fnc_garage';
	scriptname _fnc_scriptName;
	disableserialization;
	_fullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullGarage",false];
	if !(isnull (uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull])) exitwith {"Garage Viewer is already running" call bis_fnc_logFormat;};
	{deleteVehicle _x;}foreach nearestObjects [getMarkerPos (_this select 0), ["AllVehicles"], 10];
	_veh = createVehicle ["Land_HelipadEmpty_F", getMarkerPos (_this select 0), [], 0, "CAN_COLLIDE"];
	missionnamespace setvariable ["BIS_fnc_arsenal_fullGarage",[true,0,false,[false]] call bis_fnc_param];
	with missionnamespace do {BIS_fnc_garage_center = [true,1,_veh,[objnull]] call bis_fnc_param;};
	with uinamespace do {
		_displayMission = [] call (uinamespace getvariable "bis_fnc_displayMission");
		if !(isnull finddisplay 312) then {_displayMission = finddisplay 312;};
		_displayMission createdisplay "RscDisplayGarage";

		[(_this select 0)] spawn {
			waitUntil{(Vehicle player) != player};
			_vehType = typeOf Vehicle player;
			deleteVehicle (Vehicle player);
			sleep 1.0;
			_veh = createVehicle [_vehType, getMarkerPos (_this select 0), [], 0, "CAN_COLLIDE"];
			player moveInDriver _veh;
		};
	};
