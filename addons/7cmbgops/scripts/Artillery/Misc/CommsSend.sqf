// Transmits comms to all clients

params ["_asset", "_messageCode", "_audio"];

//player sideChat format ["%1  %2",_asset,_messageCode];
[[_asset,_messageCode,_audio],"\7cmbgops\scripts\Artillery\Misc\CommsPlay.sqf"] remoteExec ["BIS_fnc_execVM", 0, false];