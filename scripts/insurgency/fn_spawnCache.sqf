/*
  _____
  \_   \_ __  ___ _   _ _ __ __ _  ___ _ __   ___ _   _
   / /\/ '_ \/ __| | | | '__/ _` |/ _ \ '_ \ / __| | | |
/\/ /_ | | | \__ \ |_| | | | (_| |  __/ | | | (__| |_| |
\____/ |_| |_|___/\__,_|_|  \__, |\___|_| |_|\___|\__, |
                            |___/                 |___/

@filename: fn_spawnCache.sqf

Author:

	Hazey

Last modified:

	2/11/2015

Description:

	This is where the magic happens. Spawns the cache at random locations.
	1 cache at a time the way the good insurgency lords intended.

README BEFORE EDITING:

	This function.... It was written on 1/15/2014 and has since been put through the ringer so many times.
	Lets be honest here, it looks like crap and needs to be re-written...
	That's for another day, right now its doing the job.

	I Hazey, Promise to re-write this function with all my new knowlage very soon.

	Right now, if you feel that the cache is REALLY STUCK or missing... Have your admin use the following code.

	[] spawn seven_fnc_spawnCache;

	If you want to kill the cache and get the point.

	[] spawn seven_fnc_cacheKilled;

	Simple... Effective... Move along...

______________________________________________________*/

private ["_mkr","_bldgpos","_targetLocation","_cacheHouses","_cities","_cacheTown","_cityPos","_cityRadA",
"_cityRadB","_cacheHouse","_cachePosition","_helipad","_findHelipad","_findBases","_players","_findPlayers"];

//--- Delete Marker Array
if (count INS_marker_array > 0) then {
	{deleteMarker _x} forEach INS_marker_array};
publicVariable "INS_marker_array";

//--- Delete Cache if still alive at this point!
if (!isNull CACHE) then {
	deleteVehicle cache;
};

//--- Cache Created Debug

//--- Initial buffer - and respawn buffer time.
sleep 15;

//--- Players call.
_players = [] call BIS_fnc_listPlayers;

//--- Call to get urbanAreas.
_cities = call seven_fnc_urbanAreas;

sleep 1;

//--- Get random town from urban areas array.
_cacheTown = _cities call BIS_fnc_selectRandom;

_cityPos = _cacheTown select 1;
_cityRadA = _cacheTown select 2;
_cityRadB = _cacheTown select 3;

if(_cityRadB > _cityRadA) then {
	_cityRadA = _cityRadB;
};

sleep 1;

//--- Call list of all Enter-able Houses -- Might cause bad performance on Altis or large maps.
_cacheHouses = [_cityPos, _cityRadA] call ALIVE_fnc_getEnterableHouses;

sleep 1;

if (isNil "_cacheHouses") exitWith {

	[] spawn seven_fnc_spawnCache;
};

if (count _cacheHouses == 0) exitWith {

	[] spawn seven_fnc_spawnCache;
};

//--- Select random house from the generated list.
_cacheHouse = _cacheHouses call BIS_fnc_selectRandom;

sleep 1;

//--- Find indoor house position for spawning of the cache.
_bldgpos = [_cacheHouse, 50] call ALIVE_fnc_findIndoorHousePositions;

sleep 1;

//--- Pull the array and select a random position from it.
_targetLocation = _bldgpos call BIS_fnc_selectRandom;

//--- Create the cache at the random building position.
CACHE = createVehicle ["Box_FIA_Wps_F", _targetLocation, [], 0, "None"];

//--- Cache Created Debug

//--- Empty the cache so no items can be found in it.
clearMagazineCargoGlobal CACHE;
clearWeaponCargoGlobal CACHE;

//--- Add event handlers to the cache
//--- Handle damage for only Satchel and Demo charge.
CACHE addEventHandler ["handledamage", {
	if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","SatchelCharge_Remote_Ammo_Scripted","DemoCharge_Remote_Ammo_Scripted"]) then {

		(_this select 0) setdamage 1;
		//--- Event handler to call explosion effect and score.
		(_this select 0) spawn seven_fnc_cacheKilled;

	} else {

		(_this select 0) setdamage 0;

	}}];
//--- End of event handlers

//--- Disable simulation of the cache.
CACHE enableSimulationGlobal false;

//--- Move the Cache to the above select position
//--- TODO: Verify we even need this.
CACHE setPos _targetLocation;
publicVariable "CACHE";

sleep 1;

//--- Check to see if cache has already spawned near that location.
//--- TODO: Pass cache into array and check distance of new cache to the array of old caches.
_findHelipad = count nearestObjects [_targetLocation, ["Land_HelipadEmpty_F"], 1200];
_findBases = count nearestObjects [_targetLocation, ["Flag_US_F"], 800];
_findPlayers = count nearestObjects [_targetLocation, ["_players"], 800];

if ((_findHelipad > 0) || (_findBases > 0) || (_findPlayers > 0)) exitWith {

	[] spawn seven_fnc_spawnCache;
};

sleep 1;

//--- Create the invisible helipad for the above.
_helipad = createVehicle ["Land_HelipadEmpty_F", _targetLocation, [], 0, "None"];
_helipad enableSimulationGlobal false;

//--- Make final check to end mission if cache score complete.
if (INS_west_score == 16) then {
	[nil, "seven_fnc_endMission", true, false] call BIS_fnc_MP;
};