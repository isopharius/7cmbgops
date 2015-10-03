//HC script
[true,120,false,true,60,10,true,[]] spawn seven_fnc_WerthlesHeadless;

if (isHC) exitwith {};

[] call seven_fnc_init_map;

[] call seven_fnc_init_custom;

[] call seven_fnc_init_alive;

[] call seven_fnc_init_ares;

[] call seven_fnc_init_ace;
