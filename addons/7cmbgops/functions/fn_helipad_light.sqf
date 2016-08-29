/*
	Author: JoeJoe (25.12.13) v.4

	Description:
	Creates lights around a helipad

	Parameter(s):
		helipad: helipad object (this or name of helipad)
		innerlightcolor: string innerlight color (red, green, yellow, blue(not recommended), white(not recommended), bir (blufor), oir (blufor), iir (resistance))
		outerlightcolor: string outerlight color (red, green, yellow, blue, white, bir (blufor), oir (blufor), iir (resistance))
		showhint (optional): boolean show a hint after creation
		scriptFolder (optional): string Foldername of Scripts.
									e.G.: missionfolder\scripts\helipad_lights	the parameter would be "scripts"


	Example:

	* 1st way of calling:

		init field of helipad
		null = [this, "yellow", "green", false, "scripts"] execVM "\7cmbgops\scripts\helipad_lights\helipad_light.sqf";

	* 2nd way of calling:

		execute in trigger or script with helipad name
		null = [h1, "yellow", "green", false, "scripts"] execVM "\7cmbgops\scripts\helipad_lights\helipad_light.sqf";

	Returns:
		nothing
*/

private ["_helipadDir","_innerLightTemp","_outerLightTemp","_xPos","_y","_zPos","_vehicle", "_vehiclePos", "_scriptPath", "_scriptFolder"];
params ["_helipad", "_innerLight", "_outerLight", "_showHint"];

_helipadDir = getDir _helipad;

_xPos = getPosworld _helipad select 0;
_yPos = getPosworld _helipad select 1;
_zPos = getPosworld _helipad select 2;

hint format["%1 %2 %3", _xPos, _yPos, _zPos];

call {
	if (_innerLight isEqualTo "red") exitWith {
		_innerLight = "Land_Flush_Light_red_F";
	};
	if (_innerLight isEqualTo "green") exitWith {
		_innerLight = "Land_Flush_Light_green_F";
	};
	if (_innerLight isEqualTo "yellow") exitWith {
		_innerLight = "Land_Flush_Light_yellow_F";
	};
	if (_innerLight isEqualTo "blue") exitWith {
		_innerLight = "Land_runway_edgelight_blue_F";
	};
	if (_innerLight isEqualTo "white") exitWith {
		_innerLight = "Land_runway_edgelight";
	};
	if (_innerLight isEqualTo "bir") exitWith {
		_innerLightTemp = "NVG_TargetW";
		_innerLight = "Land_Flush_Light_yellow_F";
	};
	if (_innerLight isEqualTo "oir") exitWith {
		_innerLightTemp = "NVG_TargetE";
		_innerLight = "Land_Flush_Light_yellow_F";
	};
	if (_innerLight isEqualTo "iir") then {
		_innerLightTemp = "NVG_TargetC";
		_innerLight = "Land_Flush_Light_yellow_F";
	} else {
		_innerLight = "Land_Flush_Light_yellow_F";
	};
};

call {
	if (_outerLight isEqualTo "red") exitWith {
		_outerLight = "Land_Flush_Light_red_F";
	};
	if (_outerLight isEqualTo "green") exitWith {
		_outerLight = "Land_Flush_Light_green_F";
	};
	if (_outerLight isEqualTo "yellow") exitWith {
		_outerLight = "Land_Flush_Light_yellow_F";
	};
	if (_outerLight isEqualTo "blue") exitWith {
		_outerLight = "Land_runway_edgelight_blue_F";
	};
	if (_outerLight isEqualTo "white") exitWith {
		_outerLight = "Land_runway_edgelight";
	};
	if (_outerLight isEqualTo "bir") exitWith {
		_outerLightTemp = "NVG_TargetW";
		_outerLight = "Land_Flush_Light_green_F";
	};
	if (_outerLight isEqualTo "oir") exitWith {
		_outerLightTemp = "NVG_TargetE";
		_outerLight = "Land_Flush_Light_green_F";
	};
	if (_outerLight isEqualTo "iir") then {
		_outerLightTemp = "NVG_TargetC";
		_outerLight = "Land_Flush_Light_green_F";
	} else {
		_outerLight = "Land_Flush_Light_green_F";
	};
};

for "_i" from 0 to 5 do {
	createVehicle [_innerLight, [((_xPos + 1.25) - (_i*.5)),_yPos,_zPos], [],0,"CAN_COLLIDE"];
	// sleep .01;
};

for "_i" from 1 to 4 do {
	 createVehicle [_innerLight, [(_xPos + 1.25),(_yPos + (_i*.5)),_zPos], [],0,"CAN_COLLIDE"];
	 createVehicle [_innerLight, [(_xPos - 1.25),(_yPos + (_i*.5)),_zPos], [],0,"CAN_COLLIDE"];
	 createVehicle [_innerLight, [(_xPos + 1.25),(_yPos - (_i*.5)),_zPos], [],0,"CAN_COLLIDE"];
	 createVehicle [_innerLight, [(_xPos - 1.25),(_yPos - (_i*.5)),_zPos], [],0,"CAN_COLLIDE"];
	// sleep .01;
};

if((typeOf _helipad isEqualTo "Land_HelipadRescue_F") || (typeOf _helipad isEqualTo "Land_HelipadSquare_F") || (typeOf _helipad isEqualTo "Land_HelipadEmpty_F")) then {
	for "_i" from 0 to 10 do {
		createVehicle [_outerLight, [((_xPos - 5) + (_i * 1)),(_yPos + 5),_zPos], [],0,"CAN_COLLIDE"];
		createVehicle [_outerLight, [((_xPos - 5) + (_i * 1)),(_yPos - 5),_zPos], [],0,"CAN_COLLIDE"];
		createVehicle [_outerLight, [(_xPos - 5),((_yPos - 5) + (_i * 1)),_zPos], [],0,"CAN_COLLIDE"];
		createVehicle [_outerLight, [(_xPos + 5),((_yPos - 5) + (_i * 1)),_zPos], [],0,"CAN_COLLIDE"];
		// sleep .01;
	};
} else {
	for "_i" from 0 to 18 do {
		createVehicle [_outerLight, [(_xPos + (5.75 * cos(_i * 20))),(_yPos + (5.75 * sin(_i * 20))),_zPos], [],0,"CAN_COLLIDE"];
	};
};

_handle = [[_xPos, _yPos, _zPos], _helipad, 8, ["Land_Flush_Light_red_F", "Land_Flush_Light_green_F","Land_Flush_Light_yellow_F","Land_runway_edgelight_blue_F","Land_runway_edgelight","B_IRStrobe","O_IRStrobe","I_IRStrobe"], _helipadDir] call seven_fnc_SHK_moveObjects;
waitUntil {scriptDone _handle};

if(!isNil ("_innerLightTemp")) then
{
	_objects = nearestObjects [_helipad, [_innerLight], 5];
	{
		_obj = createVehicle [_innerLightTemp, [0,0,0], [], 0, "CAN_COLLIDE"];
		_obj setPosWorld (getPosworld _x);
		deleteVehicle _x;
	} forEach _objects;
};
if(!isNil ("_outerLightTemp")) then
{
	_objects = nearestObjects [_helipad, [_outerLight], 7.2];
	{
		_obj = createVehicle [_outerLightTemp, [0,0,0], [], 0, "CAN_COLLIDE"];
		_obj setPosWorld (getPosworld _x);
		deleteVehicle _x;
	} forEach _objects;
};


if(!isNil "_showHint") then {
	if(_showHint) then {
		hint parseText "<t size='1.25'>Helipad Lights Created</t>";
	};
};