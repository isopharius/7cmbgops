if(!isDedicated) then { //client admin menu
	["player",[SELF_INTERACTION_KEY],-9905,["call seven_fnc_adminMenuDef","main"]] call ALIVE_fnc_flexiMenu_Add;
};