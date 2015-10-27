if (isDedicated || isHC) exitwith {};

//compile functions and variables for SATCOM
//v1.0 A3

//variables
PXS_SatelliteInitialHeight = 800; //height of camera
PXS_SatelliteFOV = 0.2; //default FOV
PXS_SatelliteZoom = 39.7; //default in zoom range
PXS_SatelliteNorthMovementDelta = 0;
PXS_SatelliteSouthMovementDelta = 0;
PXS_SatelliteEastMovementDelta = 0;
PXS_SatelliteWestMovementDelta = 0;
PXS_ViewDistance = 0; //view distance (storage of old value)
PXS_ViewDistanceNew = 3000; //view distance while SATCOM is launched
PXS_TimeZone = "[UTC+2]"; //time zone
/*
//compile functions
PXS_timeFunction = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\time_function.sqf";
PXS_timeView = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\time_view.sqf";
PXS_coordinatesFunction = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\coordinates_function.sqf";
PXS_coordinatesView = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\coordinates_view.sqf";
PXS_adjustCamera = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\adjustCamera.sqf";
PXS_updateCamera = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\updateCamera.sqf";
PXS_closeCamera = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\closeCamera.sqf";
PXS_viewSatellite = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\view_satellite.sqf";
PXS_keyEventFunction = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\key_function.sqf";
PXS_mouseZChanged = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\mouseZChanged.sqf";
PXS_keyMain = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\key_main.sqf";
PXS_startSatellite = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\start_satellite.sqf";
PXS_switcher = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\switcher.sqf";
PXS_redefineDefaultPos = compile preprocessFileLineNumbers "\7cmbgops\scripts\pxs_satcom_a3\redefine_position.sqf";
*/