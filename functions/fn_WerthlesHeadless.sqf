// Werthles Headless Script Parameters
// 1. Repeating - true/Once - false,
// 2. Time between repeats (seconds),
//*3. Debug available for all - true/Just available for admin/host - false,
// 4. Advanced balancing - true/Simple balancing - false,
// 5. Delay before executing (seconds),
// 6. Additional syncing time between groups transferred to try to reduce bad unit transfer caused by desyncs (seconds)
// 7. Display an initial setup report after the first cycle, showing the number of units moved to HCs,
// 8. Addition phrases to look for when checking whether to ignore.
// Unit names, group names, unit's current transport vehicle, modules synced to units and unit class names will all be checked for these phrases
// Format:
// ["UnitName","GroupCallsignName","SupportProviderModule1","TypeOfUnit"]
// E.g. ["BLUE1","AlphaSquad","B_Heli_Transport_01_camo_F"] (including ""s)
// Specifying "B_Heli" would stop all units with that class type from transferring to HCs
// However, if you specify "BLUE1", "NAVYBLUE10" will also be ignored

//private variables
private ["_recurrent", "_timeBetween", "_debug", "_advanced", "_startDelay", "_pause", "_report", "_moreBadNames", "_badNames", "_syncGroup", "_trigSyncs", "_waySyncs", "_objSyncs", "_objs", "_wayPoint", "_localCount", "_groupMoving", "_HCName", "_transfers", "_hintType", "_hintParams", "_lineString", "_breakString", "_debugString", "_hintParams1", "_hintParams2", "_stringInfo1", "_stringInfo2", "_stringInfo3", "_stringInfo4", "_strTransfers", "_strRecurrent", "_arb", "_debugging", "_check", "_hcColour", "_z", "_On", "_counts", "_HCgroups", "_null", "_recurrentCheck", "_ll", "_who", "_amount", "_gg", "_whom", "_inWHKHeadlessArray", "_headlessCount", "_unitsInGroup", "_size", "_lead", "_leadOwner", "_leadHeadless", "_WHKDummyWaypoint", "_moveToHC", "_bad", "_syncTrigArray", "_syncWayArray", "_wayNum", "_syncedTrigs", "_syncedWays", "_syncObjectsArray", "_syncObjects", "_nameOfSync", "_found", "_zz", "_HC", "_fewest", "_local", "_newSum", "_firstWaypoint"];

//Ignored Special Variables: _this, _x, _forEachIndex.
//script parameters
_recurrent = true; //_this select 0; // run repeatedly
_timeBetween = 20; //_this select 1; // time between each check
_debug = false; //_this select 2; // debug available for all or just admin
_advanced = true; //_this select 3; // selects which AI distribution method to use
_startDelay = 30; //_this select 4; // how long to wait before running
_pause = 1; //_this select 5; // how long to wait between each setGroupOwner, longer aids syncing
_report = false; //_this select 6; // turn setup report on or off
_moreBadNames = []; //_this select 7; // check for units, groups, classes, vehicles or modules with these words in their name, then ignore the associated unit's group

//Check the script is run in multiplayer only
if (isMultiplayer) then
{
	WHKDEBUGHC = false;
	_badNames = ["ignore"] + _moreBadNames;

	//default to server only
	if (isServer and hasInterface) then
	{
		WHKDEBUGGER = player;
		publicVariable "WHKDEBUGGER";
	}
	else
	{
		if (serverCommandAvailable "#kick") then
		{
			WHKDEBUGGER = player;
			publicVariable "WHKDEBUGGER";
		};
	};

	//set up arrays
	WHKHeadlessArray = [];
	WHKHeadlessLocalCounts = [];
	WHKHeadlessNames = [];
	WHKHeadlessGroups = [];
	WHKHeadlessGroupOwners = [];

	WHKSyncArrays = compileFinal "
		_syncGroup = _this select 0;
		_trigSyncs = _this select 1;
		_waySyncs = _this select 2;
		_objSyncs = _this select 3;
		{
			_objs = _objSyncs select _forEachIndex;
			_x synchronizeObjectsAdd _objs;
		}forEach units _syncGroup;
		{
			_wayPoint = _x;
			{
				_x synchronizeTrigger [_wayPoint];
			}forEach (_trigSyncs select _forEachIndex);
			{
				_x synchronizeWaypoint [_wayPoint];
			}forEach (_waySyncs select _forEachIndex);
		}forEach waypoints _syncGroup;
	";

	//[[1,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//[[2,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//[[3,[profileName,_localCount]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//[[4,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//[[5,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//[[6,[_groupMoving,_HCName]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//[[8,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;

	if not (isServer or hasInterface) then
	{
		WHKSendInfo = compileFinal "
			sleep (random 1);
			_counts = {local _x} count allUnits;
			_HCgroups = [];
			{
				if (local _x) then
				{
					_HCgroups append [_x];
				};
			}forEach allGroups;
			[[player,_counts,_HCgroups],""WHKAddHeadless"",false,false] call bis_fnc_mp;
		";
	}
	else
	{
		WHKSendInfo = compileFinal "";
	};

	//displays number of units local to each client as a hint, if debug is on
	_null = [] spawn {
		while {true} do
		{
			//make sure hints are not always displayed together
			sleep (7 + random 7);
			if (WHKDEBUGHC) then
			{
				//count local units
				_localCount = {local _x} count allUnits;
				[[3,[profileName,_localCount]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
			};
		};
	};

	//Run only on server
	if (isServer) then
	{
		if (_report) then
		{
			//Inform WHKDEBUGGER WH is running
			[[4,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
		};

		_transfers = -1;
		_recurrentCheck = true;

		//Headless client incrementer
		if not (_advanced) then
		{
			_ll = -1;
		};

		//function to add id and counts to WHKHeadlessArray and WHKHeadlessLocalCounts
		WHKAddHeadless = compileFinal "
			_who = _this select 0;
			_amount = _this select 1;
			_HCgroups = _this select 2;
			WHKHeadlessGroups append _HCgroups;
			_gg = count _HCgroups;
			While {_gg >0} do
			{
				WHKHeadlessGroupOwners append [_who];
				_gg =_gg - 1;
			};
			_whom = owner _who;
			_inWHKHeadlessArray = WHKHeadlessArray find _whom;
			if (_inWHKHeadlessArray > -1) then
			{
				WHKHeadlessLocalCounts set [_inWHKHeadlessArray,_amount];
				WHKHeadlessNames set [_inWHKHeadlessArray,_who];
			}
			else
			{
				WHKHeadlessArray append [_whom];
				_inWHKHeadlessArray = WHKHeadlessArray find _whom;
				WHKHeadlessLocalCounts set [_inWHKHeadlessArray,_amount];
				WHKHeadlessNames set [_inWHKHeadlessArray,_who];
			};
		";

		//sleep for the length of the start delay
		sleep _startDelay;

		//if recurrent, repeat
		while {_recurrentCheck} do
		{
			//reset array
			WHKHeadlessArray = [];
			WHKHeadlessLocalCounts = [];
			WHKHeadlessGroups = [];
			WHKHeadlessGroupOwners = [];
			WHKHeadlessNames = [];

			//end if not recurrent
			if not (_recurrent) then
			{
				_recurrentCheck = false;
			};

			//causes WHKDEBUGGER to receive hints
			if (WHKDEBUGHC) then
			{
				[[5,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
			};

			//tell HCs to send info
			[0,"WHKSendInfo",true,false] call BIS_fnc_MP;

			//wait for replies
			sleep 5;

			//broadcast debug stuff
			if (WHKDEBUGHC) then
			{
				publicVariable "WHKHeadlessGroups";
				publicVariable "WHKHeadlessGroupOwners";
			};

			//Count the number of headless clients connected
			_headlessCount = count WHKHeadlessArray;

			//if there are headless clients connected, split AIs
			if (_headlessCount > 0) then
			{
				//clean up groups
				{
					//check if groups are empty
					_unitsInGroup = count units _x;
					if (_unitsInGroup == 0) then
					{
						deleteGroup _x;
					};
				}forEach allGroups;

				//loop all groups
				{
					//get the group
					_groupMoving = _x;
					_size = count units _groupMoving;
					_lead = leader _groupMoving;
					_leadOwner = owner _lead;
					_leadHeadless = WHKHeadlessArray find _leadOwner;

					//if group leader isn't a human and isn't controlled by a HC
					if (!(isPlayer _lead) and (_leadHeadless == -1)) then
					{
						//add dummy waypoint
						_WHKDummyWaypoint = _groupMoving addWaypoint [position leader _groupMoving, 0, currentWaypoint _groupMoving, "WHKDummyWaypoint"];
						_WHKDummyWaypoint setWaypointTimeout [6,6,6];
						_WHKDummyWaypoint setWaypointCompletionRadius 100;

						_moveToHC = false;
						_bad = false;

						//Remember syncs from waypoints to other waypoints and triggers
						_syncTrigArray = [];
						_syncWayArray = [];
						{
							_wayNum = _forEachIndex;
							_syncedTrigs = synchronizedTriggers _x;
							_syncTrigArray set [_wayNum,_syncedTrigs];
							_syncedWays = synchronizedWaypoints _x;
							_syncWayArray set [_wayNum,_syncedWays];
						}forEach waypoints _groupMoving;

						//remember syncs to objects
						_syncObjectsArray = [];
						{
							_syncObjects = synchronizedObjects _x;
							_syncObjectsArray = _syncObjectsArray + [_syncObjects];
						}forEach units _groupMoving;

						//check for bad modules with ignore
						{
							{
								_nameOfSync = str _x;
								{
									_found = _nameOfSync find _x;
									if (_found>-1) then
									{
										_bad = true;
									};
								}forEach _badNames;
								_nameOfSync = typeOf _x;
								{
									_found = _nameOfSync find _x;
									if (_found>-1) then
									{
										_bad = true;
									};
								}forEach _badNames + ["SupportProvider"];
							}forEach _x;
						}forEach _syncObjectsArray;

						//check for units with ignore
						{
							_nameOfSync = str _x;
							{
								_found = _nameOfSync find _x;
								if (_found>-1) then
								{
									_bad = true;
								};
							}forEach _badNames;
						}forEach units _groupMoving;

						//check for unit type with ignore phrase
						{
							_nameOfSync = typeOf _x;
							{
								_found = _nameOfSync find _x;
								if (_found>-1) then
								{
									_bad = true;
								};
							}forEach _badNames;
						}forEach units _groupMoving;

						//check for unit vehicle type with ignore phrase
						{
							_nameOfSync = typeOf (vehicle _x);
							{
								_found = _nameOfSync find _x;
								if (_found>-1) then
								{
									_bad = true;
								};
							}forEach _badNames;
						}forEach units _groupMoving;

						//check for unit vehicle with ignore phrase
						{
							_nameOfSync = str (vehicle _x);
							{
								_found = _nameOfSync find _x;
								if (_found>-1) then
								{
									_bad = true;
								};
							}forEach _badNames;
						}forEach units _groupMoving;

						//check for groups with ignore
						_nameOfSync = str _x;
						{
							_found = _nameOfSync find _x;
							if (_found>-1) then
							{
								_bad = true;
							};
						}forEach _badNames;

						//move it to HC
						if not (_bad) then
						{

							_zz = 0;
							_HC = 0;
							_HCName = objNull;
							if (_advanced) then
							{
								//find the headless client with the fewest AIs
								_fewest = WHKHeadlessLocalCounts select 0;
								{
									//the total local units for the current HC
									if (_x < _fewest) then
									{
										_zz = _forEachIndex;
										_fewest = _x;
									};
								}forEach WHKHeadlessLocalCounts;

								//add group size to _local arrays
								_fewest = WHKHeadlessLocalCounts select _zz;
								_newSum = _fewest + _size;
								WHKHeadlessLocalCounts set [_zz,_newSum];

								//select the emptiest Headless Client
								_HC = WHKHeadlessArray select _zz;
								_HCName = WHKHeadlessNames select _zz;
							}
							else
							{

								//increment HC
								_ll = _ll + 1;
								if !(_ll < _headlessCount) then
								{
									_ll = 0;
								};

								//select a headless client
								_HC = WHKHeadlessArray select _ll;
								_HCName = WHKHeadlessNames select _ll;

								//update WHKHeadlessLocalCounts
								_newSum = WHKHeadlessLocalCounts select _ll;
								_newSum = _newSum + _size;
								WHKHeadlessLocalCounts set [_ll,_newSum];
							};

							//Move unit to
							_moveToHC = _groupMoving setGroupOwner _HC;

							//reattach triggers and waypoints
							[[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray],"WHKSyncArrays",true,false] call BIS_fnc_MP;

							//broadcast debug stuff
							if (WHKDEBUGHC and _moveToHC) then
							{
								[0,"WHKSendInfo",true,false] call BIS_fnc_MP;
								[[6,[_groupMoving,_HCName]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
								publicVariable "WHKHeadlessGroups";
								publicVariable "WHKHeadlessGroupOwners";
							};

							sleep (_pause/2);

							//reattach triggers and waypoints
							[[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray],"WHKSyncArrays",true,false] call BIS_fnc_MP;

							sleep (_pause/2);
						};

							//_firstWaypoint = (waypoints _groupMoving) select 1;
							{
								if (waypointName _x == "WHKDummyWaypoint") then
								{
									deleteWaypoint _x;
								};
							}forEach waypoints _groupMoving;
					};
				}forEach allGroups;

				//show report only after the first cycle
				if (_transfers == -1 and _report) then
				{
					//count units moved to HCs
					_transfers = 0;
					{
						_transfers = _transfers + _x;
					}forEach WHKHeadlessLocalCounts;

					sleep 2;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					sleep 0.5;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					sleep 0.5;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					sleep 0.5;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					sleep 0.5;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					//broadcast group locations
					publicVariable "WHKHeadlessGroups";
					publicVariable "WHKHeadlessGroupOwners";
					sleep 10;
				};

			};

			//causes WHKDEBUGGER to receive hints
			if (WHKDEBUGHC) then
			{
				sleep 2;
				[0,"WHKSendInfo",true,false] call BIS_fnc_MP;
				[[8,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
				sleep 5;
				//broadcast group locations
				publicVariable "WHKHeadlessGroups";
				publicVariable "WHKHeadlessGroupOwners";
			};

			//time between checks
			sleep _timeBetween;
		};
	};
}
else
{
	//Inform players WH is not running
	hintSilent composeText [
		parseText "<t color='#C5C1AA' align='center'>-------------------------------------------------------</t>",
		parseText "<br/>",
		parseText "<t color='#7D9EC0' align='center'>Headless Clients Can Only Connect To Multiplayer Games, So Werthles Headless Script Has Terminated</t>",
		parseText "<br/>",
		parseText "<t color='#C5C1AA' align='center'>-------------------------------------------------------</t>"
	];
};