// by ALIAS
// STORM SCRIPT
// Tutorial: https://www.youtube.com/user/aliascartoons

/*
================================================================================================================================
>>>>> MONSOON Parameters =======================
================================================================================================================================

null = [direction_monsoon, duration_monsoon, effect_on_objects] execvm "\7cmbgops\scripts\AL_storm\al_monsoon.sqf";

direction_monsoon	- integer, from 0 to 360, direction towards the wind blows expressed in compass degrees
duration_monsoon	- integer, life time of the monsoon expressed in seconds
effect_on_objects	- boolean, if is true occasionally a random object will be thrown in the air


================================================================================================================================
>>>>> DUST STORM Parameters ====================
================================================================================================================================

null = [direction_duststorm, duration_duststorm, effect_on_objects, wall_of_dust] execvm "\7cmbgops\scripts\AL_storm\al_duststorm.sqf";

direction_monsoon	- integer, from 0 to 360, direction towards the wind blows expressed in compass degrees
duration_monsoon	- integer, life time of the monsoon expressed in seconds
effect_on_objects	- boolean, if is true occasionally a random object will be thrown in the air
wall_of_dust		- boolean, if true a wall of dust is created, make it false if mission is too laggy with this option


================================================================================================================================
>>>>> TORNADO Parameters ======================
================================================================================================================================

null = ["marker_start","marker_end"] execvm "\7cmbgops\scripts\AL_storm\al_tornado.sqf";

"marker_start"	- string, name of the marker where the tornado starts from
"marker_end"	- string, name of the marker towards tornado moves and where will end

================================================================================================================================
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> EXAMPLES <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
================================================================================================================================

// MONSOON
null = [60,120,true] execvm "\7cmbgops\scripts\AL_storm\al_monsoon.sqf";

// DUST STORM
null = [80,180,true,true] execvm "\7cmbgops\scripts\AL_storm\al_duststorm.sqf";

// TORNADO
null = ["p1","p2"] execvm "\7cmbgops\scripts\AL_storm\al_tornado.sqf";

*/