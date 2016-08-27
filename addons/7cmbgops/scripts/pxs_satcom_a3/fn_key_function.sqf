private["_keyCode","_return"];

_keyCode = _this select 1;
_return = true;

#define FACTOR 50

call {
	if (_keyCode isEqualTo 1) exitWith {//ESC
		call seven_fnc_closeCamera;
	};
	if (_keyCode isEqualTo 2) exitWith {//1 normal view
		[2] call seven_fnc_adjustCamera;
	};
	if (_keyCode isEqualTo 3) exitWith {//2 thermograph
		[3] call seven_fnc_adjustCamera;
	};
	if (_keyCode isEqualTo 4) exitWith {//3 white is hot
		[4] call seven_fnc_adjustCamera;
	};
	if (_keyCode isEqualTo 5) exitWith {//4 black is hot
		[5] call seven_fnc_adjustCamera;
	};
	if (_keyCode isEqualTo 50) then {//M redefine default satellite position
		waitUntil {call seven_fnc_closeCamera};
		call seven_fnc_start_satellite;
	} else {
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
	call
	{
		//case 17://W
		if (({_x in _pressedButtonArray} count (actionKeys "MoveForward")) > 0) exitWith
		{
			PXS_SatelliteNorthMovementDelta = 2.5;
			PXS_SatelliteTarget setPosworld [((getPosworld PXS_SatelliteTarget) select 0) - PXS_SatelliteNorthMovementDelta,((getPosworld PXS_SatelliteTarget) select 1) + PXS_SatelliteNorthMovementDelta,(getPosworld PXS_SatelliteTarget) select 2];
			call seven_fnc_updateCamera;
		};
		//case 31://S
		if (({_x in _pressedButtonArray} count (actionKeys "MoveBack")) > 0) exitWith
		{
			PXS_SatelliteSouthMovementDelta = 2.5;
			PXS_SatelliteTarget setPosworld [((getPosworld PXS_SatelliteTarget) select 0) + PXS_SatelliteSouthMovementDelta,((getPosworld PXS_SatelliteTarget) select 1) - PXS_SatelliteSouthMovementDelta,(getPosworld PXS_SatelliteTarget) select 2];
			call seven_fnc_updateCamera;
		};
		//case 30://A
		if (({_x in _pressedButtonArray} count (actionKeys "TurnLeft")) > 0) exitWith
		{
			PXS_SatelliteWestMovementDelta = 2.5;
			PXS_SatelliteTarget setPosworld [((getPosworld PXS_SatelliteTarget) select 0) - PXS_SatelliteWestMovementDelta,((getPosworld PXS_SatelliteTarget) select 1) - PXS_SatelliteWestMovementDelta,(getPosworld PXS_SatelliteTarget) select 2];
			call seven_fnc_updateCamera;
		};
		//case 32://D
		if (({_x in _pressedButtonArray} count (actionKeys "TurnRight")) > 0) exitWith
		{
			PXS_SatelliteEastMovementDelta = 2.5;
			PXS_SatelliteTarget setPosworld [((getPosworld PXS_SatelliteTarget) select 0) + PXS_SatelliteEastMovementDelta,((getPosworld PXS_SatelliteTarget) select 1) + PXS_SatelliteEastMovementDelta,(getPosworld PXS_SatelliteTarget) select 2];
			call seven_fnc_updateCamera;
		};
		//case 78://Num +
		if ((({_x in _pressedButtonArray} count (actionKeys "ZoomIn")) > 0) || (({_x in _pressedButtonArray} count (actionKeys "MoveDown")) > 0)) exitWith
		{
			if ((PXS_SatelliteZoom + (0.02 * FACTOR)) <= 47) then
			{
				PXS_SatelliteFOV = PXS_SatelliteFOV - (0.0005 * FACTOR);
				PXS_SatelliteZoom = PXS_SatelliteZoom + (0.02 * FACTOR);
				call seven_fnc_updateCamera;
			};
		};
		//case 74://Num -
		if ((({_x in _pressedButtonArray} count (actionKeys "ZoomOut")) > 0) || (({_x in _pressedButtonArray} count (actionKeys "MoveUp")) > 0)) then
		{
			if ((PXS_SatelliteZoom - (0.02 * FACTOR)) >= 0.1) then
			{
				PXS_SatelliteFOV = PXS_SatelliteFOV + (0.0005 * FACTOR);
				PXS_SatelliteZoom = PXS_SatelliteZoom - (0.02 * FACTOR);
				call seven_fnc_updateCamera;
			};
		} else {
			_return = false;
		};
	};
};
_return;