/*
  _____
  \_   \_ __  ___ _   _ _ __ __ _  ___ _ __   ___ _   _
   / /\/ '_ \/ __| | | | '__/ _` |/ _ \ '_ \ / __| | | |
/\/ /_ | | | \__ \ |_| | | | (_| |  __/ | | | (__| |_| |
\____/ |_| |_|___/\__,_|_|  \__, |\___|_| |_|\___|\__, |
                            |___/                 |___/

@filename: fn_handleRegister.sqf

Author:

	Hazey

Last modified:

	2/11/2015

Description:

	CBA magic to call event handler for intel dropping off units.

TODO:

	Add comment lines so people can get a better understand of how and why it works.

______________________________________________________*/

if (isServer) then {
	private["_unit"];

	_unit = _this select 0;

	if ((side _unit == EAST) || (side _unit == RESISTANCE)) then {
		_unit addEventHandler ["Killed", {_this call seven_fnc_intelDrop}];
	};
};