disableSerialization;
params ["_menu"];	//-- params ["_menu","_display"];

switch (toLower (_menu)) do {

	//-- Main
	case "main": {
		{
			_x call STC_fnc_buildList;
		} forEach ["battlefieldanalysis","missions"];

		//-- Disable confirm mission buttons until an option is chosen
		ctrlEnable [72315, false];
		ctrlEnable [72314, false];

		//-- Add eventHandler to map
		(findDisplay 723 displayCtrl 7232) ctrlAddEventHandler ["MouseButtonClick","_this spawn STC_fnc_createMarker"];
			
		//-- Track group list selection
		(findDisplay 723 displayCtrl 7237)  ctrlAddEventHandler ["LBSelChanged","
			ctrlEnable [72314, true];
		"];

		//-- Track group list selection
		(findDisplay 723 displayCtrl 7239)  ctrlAddEventHandler ["LBSelChanged","
			ctrlEnable [72315, true];
		"];
	};

	//-- Group manager
	case "groupmanager": {

		//-- Build lists 
		{
			_x call STC_fnc_buildList;
		} forEach ["squadlist","groupformation","groupbehavior"];
	
		//-- Track group list selection

		(findDisplay 724 displayCtrl 7245)  ctrlAddEventHandler ["LBSelChanged","
			_index = lbCurSel 7245;
			_units = player getVariable 'STCcurrentGroup';
			_unit = _units select _index;
			[_unit] call STC_fnc_updateGearList;
		"];

	};

	//-- High command
	case "highcommand": {

		//-- Initialize variables
		STCGroupWaypoints = [];
		STCPlannedWaypoints = [];
		STCArrowMarkers = [];


		//-- Create waypoint default settings
		STCWaypointType = "MOVE";
		STCWaypointSpeed = "UNCHANGED";
		STCWaypointFormation = "WEDGE";
		STCWaypointBehavior = "SAFE";

		["grouplister"] call STC_fnc_buildList;

		//-- Keep track of currently selected group
		(findDisplay 725 displayCtrl 7254)  ctrlAddEventHandler ["LBSelChanged","['client'] spawn STC_fnc_onGroupSwitch"];

		STCHighCommandMode = "GroupSelect";
		//-- Select nearest unit when you map is clicked
		(findDisplay 725 displayCtrl 7252) ctrlAddEventHandler ["MouseButtonClick","_this spawn STC_fnc_HighCommandMapClick"];

		//-- Disable Ambient Commands Button - WIP
		ctrlEnable [72510, false];
	};

	//-- Waypoint Settings
	case "waypointsettings": {

		//-- Build lists
		{
			_x call STC_fnc_buildList;
		} forEach ["waypointtype","waypointspeed","waypointformation","waypointbehavior"];

	};
};