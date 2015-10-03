if(!isDedicated) then { //client

	["player",[SELF_INTERACTION_KEY],-9905,["call seven_fnc_adminMenuDef","main"]] call ALIVE_fnc_flexiMenu_Add;

} else { //dedi

	["connect", "onPlayerConnected", {
	if (({isPlayer _x} count playableUnits) > 0) then { ["ALIVE_MIL_OPCOM"] call ALiVE_fnc_unPauseModule;};
	}] call BIS_fnc_addStackedEventHandler;

	["disconnect", "onPlayerDisconnected", {
	if ( ({isPlayer _x} count playableUnits) == 0) then { ["ALIVE_MIL_OPCOM"] call ALiVE_fnc_pauseModule;};
	}] call BIS_fnc_addStackedEventHandler;
};