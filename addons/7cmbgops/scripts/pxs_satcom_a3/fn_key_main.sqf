//create UI event keyspressed
disableSerialization;

sleep 0.1;

PXS_keyEventHandler = (findDisplay 1000) displayAddEventHandler ["KeyDown","_this call seven_fnc_key_function"];
PXS_mouseWheelEventHandler = (findDisplay 1000) displayAddEventHandler ["MouseZChanged","_this call seven_fnc_mouseZChanged"];