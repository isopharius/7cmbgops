// Teleports a person to the marker "teleportDestination". You can place this marker anywhere on the map.
//
// To use: Add this script as an action on an item. EG:
//
//this addAction ["Teleport - Location Name Here","teleport.sqf",["Marker_Name_Here"]];
//this addAction ["Teleport - Base","teleport.sqf",["Base"]];
//this addAction ["Teleport - Airfield","teleport.sqf",["Airstrip"]];

// Get the destination.
_dest = (_this select 3) select 0;

// Get a random direction
_dir = random 359;

// Move the person 15 meters away from the destination (in the direction of _dir)

//player setposworld (_dest modelToWorld [-1*sin(_dir),-1*sin(_dir),0]);


player setposworld (_dest modelToWorld [1*cos(_dir),1*cos(_dir),0]);