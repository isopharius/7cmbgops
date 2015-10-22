private["_event","_keyCode","_return"];

_event = _this;
_keyCode = _event select 1;
_return = true;

#define FACTOR 50

switch (_keyCode) do
{
	case 1://ESC
	{
		call seven_fnc_closeCamera;
	};
	case 2://1 normal view
	{
		[2] call seven_fnc_adjustCamera;
	};
	case 3://2 thermograph
	{
		[3] call seven_fnc_adjustCamera;
	};
	case 4://3 white is hot
	{
		[4] call seven_fnc_adjustCamera;
	};
	case 5://4 black is hot
	{
		[5] call seven_fnc_adjustCamera;
	};
	case 50://M redefine default satellite position
	{
		call seven_fnc_redefine_position;
	};
	default
	{
		_return = false;
	};
};
// key combo handling
if (!(_return)) then
{
	private["_pressedButtonArray"];
	_pressedButtonArray = [_keyCode];
	_return = true;

	// check for key actions
	switch (true) do
	{
		//case 17://W
		case (({_x in _pressedButtonArray} count (actionKeys "MoveForward")) > 0):
		{
			PXS_SatelliteNorthMovementDelta = 2.5;
			PXS_SatelliteTarget setPosworld [((getPosworld PXS_SatelliteTarget) select 0) - PXS_SatelliteNorthMovementDelta,((getPosworld PXS_SatelliteTarget) select 1) + PXS_SatelliteNorthMovementDelta,(getPosworld PXS_SatelliteTarget) select 2];
			call seven_fnc_updateCamera;
		};
		//case 31://S
		case (({_x in _pressedButtonArray} count (actionKeys "MoveBack")) > 0):
		{
			PXS_SatelliteSouthMovementDelta = 2.5;
			PXS_SatelliteTarget setPosworld [((getPosworld PXS_SatelliteTarget) select 0) + PXS_SatelliteSouthMovementDelta,((getPosworld PXS_SatelliteTarget) select 1) - PXS_SatelliteSouthMovementDelta,(getPosworld PXS_SatelliteTarget) select 2];
			call seven_fnc_updateCamera;
		};
		//case 30://A
		case (({_x in _pressedButtonArray} count (actionKeys "TurnLeft")) > 0):
		{
			PXS_SatelliteWestMovementDelta = 2.5;
			PXS_SatelliteTarget setPosworld [((getPosworld PXS_SatelliteTarget) select 0) - PXS_SatelliteWestMovementDelta,((getPosworld PXS_SatelliteTarget) select 1) - PXS_SatelliteWestMovementDelta,(getPosworld PXS_SatelliteTarget) select 2];
			call seven_fnc_updateCamera;
		};
		//case 32://D
		case (({_x in _pressedButtonArray} count (actionKeys "TurnRight")) > 0):
		{
			PXS_SatelliteEastMovementDelta = 2.5;
			PXS_SatelliteTarget setPosworld [((getPosworld PXS_SatelliteTarget) select 0) + PXS_SatelliteEastMovementDelta,((getPosworld PXS_SatelliteTarget) select 1) + PXS_SatelliteEastMovementDelta,(getPosworld PXS_SatelliteTarget) select 2];
			call seven_fnc_updateCamera;
		};
		//case 78://Num +
		case ((({_x in _pressedButtonArray} count (actionKeys "ZoomIn")) > 0) || (({_x in _pressedButtonArray} count (actionKeys "MoveDown")) > 0)):
		{
			if ((PXS_SatelliteZoom + (0.02 * FACTOR)) <= 47) then
			{
				PXS_SatelliteFOV = PXS_SatelliteFOV - (0.0005 * FACTOR);
				PXS_SatelliteZoom = PXS_SatelliteZoom + (0.02 * FACTOR);
				call seven_fnc_updateCamera;
			};
		};
		//case 74://Num -
		case ((({_x in _pressedButtonArray} count (actionKeys "ZoomOut")) > 0) || (({_x in _pressedButtonArray} count (actionKeys "MoveUp")) > 0)):
		{
			if ((PXS_SatelliteZoom - (0.02 * FACTOR)) >= 0.1) then
			{
				PXS_SatelliteFOV = PXS_SatelliteFOV + (0.0005 * FACTOR);
				PXS_SatelliteZoom = PXS_SatelliteZoom - (0.02 * FACTOR);
				call seven_fnc_updateCamera;
			};
		};
		default
		{
			_return = false;
		};
	};
};
_return;