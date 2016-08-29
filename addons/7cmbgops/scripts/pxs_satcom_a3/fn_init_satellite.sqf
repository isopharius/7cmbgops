if (hasInterface) then {
	//variables for SATCOM
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
};