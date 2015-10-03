while {true} do
{
	if (!(PXS_SatelliteActive)) exitWith {};

	ctrlSetText [1001,format ["%1 %2",call seven_fnc_time_function,PXS_TimeZone]];

	sleep 0.1;
};