/*
	Name: Rooftop Static Weapons Script
	Author: MisterGoodson (aka Goodson)
	Version: 1.0

	Description:
		As the name suggests, this script will take a given area (defined by a marker) and spawn static weapons (such as DShKMs or KORDs) on rooftops.
		Taking inspiration from Insurgency for Arma 2, rooftop static weapons add much more variation to battles and make jobs harder for both infantry and air support.

	How it Works:
		When called, the script will first scan a given area for enterable buildings. Positions within each building will then be identified.
		Since there is no command for finding rooftops, this has to be done manually by checking for obstructions above each position and deciding whether or not it is a
		rooftop. A final check is then performed to ensure that there is enough room for the static weapon to spawn and that the rooftop
		position is not obstructed by any nearby walls or other solid objects that may prevent the weapon from manoeuvring properly

	How to Use:
		1. Within your mission, create an ellipse marker (this will define the area that you wish to place static weapons) and give it a name (e.g. "m1").
		2. Place down a "Game Logic" unit and put the following in the unit's init field:

		["m1", 1, 5, false, "CAF_AG_ME_T_RPK74", east] call gdsn_fnc_spawnRooftopStaticWeapons;

		Parameter 1: Name of marker (e.g. "m1").
		Parameter 2: Type of weapon placement. 1 = Light (Anti-infantry), 2 = Medium (AT), 3 = Heavy (AA).
		Parameter 3: Number of static weapons to spawn.
		Parameter 4: Delete marker after use.
		Parameter 5: Classname of gunner unit.
		Parameter 5: Side of gunner (east, west, resistance).
*/

// Run on server only
if (!isServer) exitWith {};

// Get arguments
params ["_marker", "_type", "_amount", "_deleteMarker", "_unit", "_side"];

// Assign variables
_area = getMarkerSize _marker; // Get area under marker
_legalRooftops = [];
_oca = 0; // Obstruction clear area
if (isNil "gdsn_rooftopPositionsUsed") then {gdsn_rooftopPositionsUsed = []};

// Define weapon placement types
_light = ["rhs_DSHKM_ins", "rhs_KORD_high_INS"];
_medium = ["rhs_SPG9_INS", "rhs_Metis_9k115_2_ins"];
_heavy = ["rhs_Igla_AA_pod_ins", "RHS_AGS30_TriPod_INS"];

// Identify which weapon type to use
switch (_type) do {
	case 0:
	{
		// TODO: Random
	};
	case 1: // AP
	{
		_type = _light;
		_oca = 1.5; // Obstruction check area
	};
	case 2: // AT
	{
		_type = _medium;
		_oca = 1.5; // Obstruction check area
	};
	case 3: // AA
	{
		_type = _heavy;
		_oca = 2.5; // Obstruction check area
	};
};

_buildings = nearestObjects [getMarkerPos _marker, ["house"], (_area select 0)];

if (_deleteMarker) then {
	deleteMarker _marker;
};

{
	_buildingPositions = [_x] call BIS_fnc_buildingPositions;
	if ((count _buildingPositions) > 0) then {

		// Find highest point in building (z-axis)
		/*
		_highestPoint = (_buildingPositions select 0) select 2;
		_highestPointXYZ = (_buildingPositions select 0);
		{
			if ((_x select 2) > _highestPoint) then {
				_highestPoint = (_x select 2);
				_highestPointXYZ = _x;
			};
		} forEach _buildingPositions;
		*/

		{
			// Check if building pos is high enough to be a weapon position (also filters out ground-floor positions such as doorways)
			_isHighPoint = ((_x select 2) > 3);

			if (_isHighPoint) then {
				// Check if building pos is a rooftop
				_buildingPositionASL = ATLtoASL(_x);
				_isObstructedZ = lineIntersects [_buildingPositionASL, [(_buildingPositionASL select 0), (_buildingPositionASL select 1), (_buildingPositionASL select 2) + 20]];

				if (!_isObstructedZ) then {
					// Check if area is free from obstruction in X & Y space
					_isObstructedX = lineIntersects [[(_buildingPositionASL select 0) - _oca, (_buildingPositionASL select 1), (_buildingPositionASL select 2)], [(_buildingPositionASL select 0) + _oca, (_buildingPositionASL select 1), (_buildingPositionASL select 2)]];
					_isObstructedY = lineIntersects [[(_buildingPositionASL select 0), (_buildingPositionASL select 1) - _oca, (_buildingPositionASL select 2)], [(_buildingPositionASL select 0), (_buildingPositionASL select 1) + _oca, (_buildingPositionASL select 2)]];

					if (!_isObstructedX && {!_isObstructedY}) then {
						// Perform final check that makes sure the surrounding area has a surface below it (i.e. not a very small point on top of the building)
						// Checks area below obstruction checkers to ensure they have a surface below them
						_hasSurfaceBelowXa = lineIntersects [[(_buildingPositionASL select 0) - _oca, (_buildingPositionASL select 1), (_buildingPositionASL select 2)], [(_buildingPositionASL select 0) - _oca, (_buildingPositionASL select 1), (_buildingPositionASL select 2) - 0.5]];
						_hasSurfaceBelowXb = lineIntersects [[(_buildingPositionASL select 0) + _oca, (_buildingPositionASL select 1), (_buildingPositionASL select 2)], [(_buildingPositionASL select 0) + _oca, (_buildingPositionASL select 1), (_buildingPositionASL select 2) - 0.5]];
						_hasSurfaceBelowYa = lineIntersects [[(_buildingPositionASL select 0), (_buildingPositionASL select 1) - _oca, (_buildingPositionASL select 2)], [(_buildingPositionASL select 0), (_buildingPositionASL select 1) - _oca, (_buildingPositionASL select 2) - 0.5]];
						_hasSurfaceBelowYb = lineIntersects [[(_buildingPositionASL select 0), (_buildingPositionASL select 1) + _oca, (_buildingPositionASL select 2)], [(_buildingPositionASL select 0), (_buildingPositionASL select 1) + _oca, (_buildingPositionASL select 2) - 0.5]];

						if (_hasSurfaceBelowXa && {_hasSurfaceBelowXb} && {_hasSurfaceBelowYa} && {_hasSurfaceBelowYb}) then {
							_legalRooftops pushBack _x;
						};
					};
				};
			};
		} forEach _buildingPositions;
	};
} forEach _buildings;

_countRooftops = count _legalRooftops;
// Exit if no legal rooftops found
if (_countRooftops < 1) exitWith {};

// If requested number of weapon placements is higher than positions available, set _amount to the max available
if (_amount > _countRooftops) then {
	_amount = _countRooftops;
};

for "_x" from 1 to _amount do {
	// Select a legal rooftop at random
	_rooftopPos = selectRandom _legalRooftops;

	if (_rooftopPos in gdsn_rooftopPositionsUsed) then {
		// Keep selecting rooftop positions at until an unused one has been found
		// If no unused positions can be found, skip creating the weapon
		for "_x" from 0 to (_countRooftops - 1) do {
			_rooftopPos = _legalRooftops select _x;
			if !(_rooftopPos in gdsn_rooftopPositionsUsed) exitWith {};
		};
	};

	if !(_rooftopPos in gdsn_rooftopPositionsUsed) then {
		gdsn_rooftopPositionsUsed pushBack _rooftopPos;

		// Create weapon
		_staticWeapon = createVehicle [(selectRandom _type), [0,0,0], [], 0, "CAN_COLLIDE"];
		_staticWeapon setPosATL _rooftopPos;
		_staticWeapon setVectorUp [0,0,1];

		// Create gunner
		_group = createGroup _side;
		_gunner = _group createUnit [_unit, [0,0,0], [], 0, "CAN_COLLIDE"];
		_gunner moveInGunner _staticWeapon;
	};
};
