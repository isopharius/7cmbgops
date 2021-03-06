#define SATFOV 2282 //default satellite FOV to Earth

while {true} do
{
	if (!(PXS_SatelliteActive)) exitWith {};

	private _lon = getPosworld PXS_SatelliteTarget select 1;
	private _lat = getPosworld PXS_SatelliteTarget select 0;

	ctrlSetText [1002,format ["%1 N",[_lon] call seven_fnc_coordinates_function]];
	ctrlSetText [1003,format ["%1 W",[_lat] call seven_fnc_coordinates_function]];
	ctrlSetText [1004,format ["%1km FOV",(round (100 * (SATFOV - PXS_SatelliteFOV)))/100]];

	sleep 0.1;
};