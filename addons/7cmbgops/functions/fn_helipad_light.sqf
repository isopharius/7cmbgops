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

private ["_helipad","_helipadDir","_innerLight","_innerLightTemp","_outerLight","_outerLightTemp","_showHint","_xPos","_y","_zPos","_vehicle", "_vehiclePos", "_scriptPath", "_scriptFolder"];

_helipad = _this select 0;
_innerLight = _this select 1;
_outerLight = _this select 2;
_showHint = _this select 3;

_helipadDir = getDir _helipad;

_xPos = getPosworld _helipad select 0;
_yPos = getPosworld _helipad select 1;
_zPos = getPosworld _helipad select 2;

hint format["%1 %2 %3", _xPos, _yPos, _zPos];

switch (_innerLight) do
{
	case "red":	{
					_innerLight = "Land_Flush_Light_red_F";
				};
	case "green": {
						_innerLight = "Land_Flush_Light_green_F";
					};
	case "yellow": {
						_innerLight = "Land_Flush_Light_yellow_F";
					};
	case "blue": {
					_innerLight = "Land_runway_edgelight_blue_F";
				};
	case "white": {
					_innerLight = "Land_runway_edgelight";
				};
	case "bir": {
					_innerLightTemp = "NVG_TargetW";
					_innerLight = "Land_Flush_Light_yellow_F";
				};
	case "oir": {
					_innerLightTemp = "NVG_TargetE";
					_innerLight = "Land_Flush_Light_yellow_F";
				};
	case "iir": {
					_innerLightTemp = "NVG_TargetC";
					_innerLight = "Land_Flush_Light_yellow_F";
				};
	default {
				_innerLight = "Land_Flush_Light_yellow_F";
			};
};

switch (_outerLight) do
{
	case "red":	{
					_outerLight = "Land_Flush_Light_red_F"
				};
	case "green": {
					_outerLight = "Land_Flush_Light_green_F"
				  };
	case "yellow": {
						_outerLight = "Land_Flush_Light_yellow_F"
					};
	case "blue": {
					_outerLight = "Land_runway_edgelight_blue_F"
				};
	case "white": {
					_outerLight = "Land_runway_edgelight"
				  };
	case "bir": {
					_outerLightTemp = "NVG_TargetW";
					_outerLight = "Land_Flush_Light_green_F";
				};
	case "oir": {
					_outerLightTemp = "NVG_TargetE";
					_outerLight = "Land_Flush_Light_green_F";
				};
	case "iir": {
					_outerLightTemp = "NVG_TargetC";
					_outerLight = "Land_Flush_Light_green_F";
				};
	default {
				_outerLight = "Land_Flush_Light_green_F"
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

if((typeOf _helipad == "Land_HelipadRescue_F") || (typeOf _helipad == "Land_HelipadSquare_F") || (typeOf _helipad == "Land_HelipadEmpty_F")) then {
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
		createVehicle [_innerLightTemp, [(getPosworld _x select 0),(getPosworld _x select 1),(getPosworld _x select 2)], [],0,"CAN_COLLIDE"];
		deleteVehicle _x;
	} forEach _objects;
};
if(!isNil ("_outerLightTemp")) then
{
	_objects = nearestObjects [_helipad, [_outerLight], 7.2];
	{
		createVehicle [_outerLightTemp, [(getPosworld _x select 0),(getPosworld _x select 1),(getPosworld _x select 2)], [],0,"CAN_COLLIDE"];
		deleteVehicle _x;
	} forEach _objects;
};


if(!isNil "_showHint") then {
	if(_showHint) then {
		hint parseText "<t size='1.25'>Helipad Lights Created</t>";
	};
};