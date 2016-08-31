// Transmits comms to all clients

params ["_asset", "_messageCode", "_audio"];

//player sideChat format ["%1  %2",_asset,_messageCode];
[_asset,_messageCode,_audio] remoteExecCall ["seven_fnc_CommsPlay", 0, false];
