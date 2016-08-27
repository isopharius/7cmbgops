// ------------------ Parse Arguments -----------------

private _mouseWheelTurns = _this select 1;

private _return = false;

#define FACTOR 5

// ----------------------- Main Function ---------------------

private _z = (_mouseWheelTurns * (-1));
if ((_z / (abs _z)) < 0) then
{
	if ((PXS_SatelliteZoom + (0.02 * FACTOR)) <= 47) then
	{
		PXS_SatelliteFOV = PXS_SatelliteFOV - (0.0005 * FACTOR);
		PXS_SatelliteZoom = PXS_SatelliteZoom + (0.02 * FACTOR);
		call seven_fnc_updateCamera;
	};
}
else
{
	if ((PXS_SatelliteZoom - (0.02 * FACTOR)) >= 0.1) then
	{
		PXS_SatelliteFOV = PXS_SatelliteFOV + (0.0005 * FACTOR);
		PXS_SatelliteZoom = PXS_SatelliteZoom - (0.02 * FACTOR);
		call seven_fnc_updateCamera;
	};
};
_return;