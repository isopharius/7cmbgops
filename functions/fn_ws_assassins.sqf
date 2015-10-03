private ["_count","_done","_check","_listclose","_listclosealive","_sleep","_ran","_flee","_skillSet","_superclasses",
"_unit","_units","_unitloc","_weaponarr","_weapon","_weaponmag","_target1","_target2","_trg","_trgsize","_chance",
"_grp","_target","_target_type","_victim","_perfomancesleep","_game","_handle"];

// LOCAL VARIABLES - MODIFYABLE
// These variables can freely be defined by the user!

//Modify and de-comment this array for the randomized weapon selection in ArmA2.
//_weaponarr = ["Sa61_EP1","UZI_EP1","revolver_EP1","Makarov"];

 //Modify and de-comment this array for the randomized weapon selection in ArmA3.
_weaponarr = ["SIG_P226","rhsusf_weap_m1911a1","hgun_Rook40_F","hgun_P07_F","hgun_ACPC2_F","hgun_PDW2000_F"];

//can be any value between 0 and 1. if 1 the sleepers flee as long as they are disguised, if 0 they are less prone to (but still might)
_flee = 0.5;

//How long the civilian waits in seconds between being triggered and pulling a gun (default: 1 - 8 seconds)
_sleep =  1+ (round random 7);

//The skill set that will be used to calculate the civilian's skills. Each value can vary by +/- the passed skill modificator.
_skillSet = [
0.25,		// aimingAccuracy
1,		// aimingShake
0.7,		// aimingSpeed
1,		// endurance
0.4,		// spotDistance
0.4,		// spotTime
1,		// courage
1,		// reloadSpeed
1,		// commanding
1		// general
];

//How often the loop checking for nearby target is performed in seconds. Only increase this in mission with tons of civilians or when you notice serverlag.
_perfomancesleep = 10;

//The Superclasses the civilians check for in their vicinity. Has to be an array! By default Infantry and unarmored vehicles
//See http://browser.six-projects.net/cfg_vehicles/tree for all classes.
_superclasses = ["CAManBase","Car"];

//
//NO NEED TO MODIFY CODE BELOW HERE!
//

//Declaring default variables

_chance = 25 + round random 25;
_trgsize = 10;
_target2 = 1;
_skill = 0.2 + random 0.2;

//LOCAL VARIABLES - scriptside
//parsed variables
_unit = _this select 0;
_weapon = _this select 1;
_chance = _this select 2;
_trgsize = _this select 3;
_target1 = _this select 4; //the legit target class (can be a side or a unit name)
if (count _this > 5) then {_target2 = _this select 5;}; //the number of valid targets that have to be in the area
if (count _this > 6) then {_skill = _this select 6};

//LOCAL VARIABLES - helpers
//declaring variables we need later
if (isNil "ws_assassins_firstrun") then {ws_assassins_firstrun = true;};
if (isNil "ws_assassins_array") then {ws_assassins_array = [];};
_unitloc = [];
_listclose = [];
_listclosealive = [];
_weaponmag = "";
_target = "";
_target_side = civilian;
_target_type = false;
_done = false;
_grp = grpNull;
_victim = objNull;
_check = false;
if (typename _unit == "BOOL") then {_check = _unit};

//INITIAL CHECKS
//If _check is set to (true) the script will launch itself again with the given variables.
//It will run on all civilians that haven't yet been turned into sleepers
_civarray = [];
if (_check) exitWith {
	{if (((side _x) == civilian) && !(isplayer _x) ) then {_civarray = _civarray + [_x]}} forEach allUnits;
	{[_x,_weapon,_chance,_trgsize,_target1,_target2,_skill] spawn seven_fnc_ws_assassins} forEach _civarray;
};

//If the unit has already been touched by the script there's no need to execute the script again
_handle = _unit getVariable ["ws_assassin",false];
if (_handle) exitWith {
};
//If the civ fails the chance check there's no need to run anything else; We set the flag to make sure he's not affected again
//Also, women can't be assassins, ARMA is sexist that way. No assassinesses (assassinas? assassinetten?) for us,
//Some AI features are disabled for the civ to save processing power
if (!(_check) && (((round(random 100))> _chance)||(_unit isKindOf "Woman")||(_unit isKindOf "Woman_EP1"))) exitWith {
	_unit setSkill 0; _unit allowFleeing 1; {_unit disableAI _x} forEach ["AUTOTARGET","TARGET","FSM"];
	_unit setVariable ["ws_assassin",true];
};

//If the unit's dead already just exit
if (!alive _unit) exitWith {};

//After passing all checks we flag the unit to make sure the script doesn't run on it again.
_unit setVariable ["ws_assassin",true];

//Set up sleeper
_unit allowfleeing _flee;
{
_skillvalue = (_skillset select _forEachIndex) + (random _skill) - (random _skill);
_unit setSkill [_x,_skillvalue];
} forEach ['aimingAccuracy','aimingShake','aimingSpeed','endurance','spotDistance','spotTime','courage','reloadSpeed','commanding','general'];
//[_unit] joinSilent grpNull;
//{_unit disableAI _x} forEach ["Target","AUTOTARGET","FSM"];

//Weapon selection, Random if set to "ran"
if (_weapon == "") then {
_ran = (floor(random(count _weaponarr)));
_weapon = _weaponarr select _ran;
};
_weaponmag = (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0;

//On the first run we create centers for each possible group, just to be safe
//(see http://community.bistudio.com/wiki/createCenter)
if (ws_assassins_firstrun) then {
_HQWest = createCenter west;
_HQEast = createCenter east;
_HQResistance = createCenter east;
ws_assassins_firstrun = false;};

//GROUP CREATION
//Checking wether a side or an objectname was parsed

switch (typename _target1) do {
	case "SIDE": {
	_target_side = _target1;
	};
	case "OBJECT": {
	_target_side = side _target1;
	};
	default {player globalchat "ws_assassins DBG: ERROR:  wrong type of _target1 (must be side or name of unit).";};
};

//creating a group hostile to the target.
switch (_target_side) do {
	case west: {_grp = createGroup east;};
	case east: {_grp = createGroup west;};
	case resistance: {if ((west getFriend resistance)>0.5)then{_grp = createGroup east;}else{_grp = createGroup west;}; };
	case civilian: {if ((west getFriend civilian)>0.5)then{_grp = createGroup east;}else{_grp = createGroup west;};};
	default {"ws_assassins DBG: ERROR: _target1 is side but not a valid one"};
};

//Wait until 5 seconds in the mission before beginning the loop
waitUntil {time > 5};

//LOOPING
//The magical (and ugly) double loop where it all happens
//Outer loop just waits for the unit to die
//Inner loop waits for the unit to aquire and engage a target (_done = true)
while {alive _unit} do {
	while {!(_done) && (alive _unit)} do {

		//Every _perfomancesleep we update the position of the sleeper (_unitloc)
		//to create an array of all nearby infantry units (_listclose) and all alive infantry units of the target side (_listclosealive)
		_unitloc = getPos _unit;
		_listclose = (nearestObjects [_unitloc,_superclasses,_trgsize]) - [_unit];
		_listclosealive = [];
		{if (((side _x == _target_side) && alive _x)) then {_listclosealive set [(count _listclosealive),_x];};} foreach _listclose;

		//This abomination checks a) if there are enough targets in _listclosealive and b) wether _target1 is close (if _target1 is a side it just checks out)
		if (((count _listclosealive) >= _target2) && ((_target1 in _listclosealive)||(typename _target1 == "SIDE"))) then {
			doStop _unit;
			[_unit] joinSilent grpNull;
			_unit allowFleeing 0;
			sleep _sleep;
			[_unit] joinSilent _grp;
			_unit setCombatMode "RED";
			_unit setBehaviour "AWARE";
			if (_unit knowsAbout _victim <2) then {_unit reveal [_victim,2.5]};
			_unit lookAt _victim;
			sleep 1;
			{_unit addMagazine _weaponmag;} forEach [1,2,3,4];
			_unit addWeapon _weapon;
			_unit selectWeapon _weapon;

				if (typename _target1 == "OBJECT") then {
					_victim = _target1;
				} else {
					_victim = (_listclosealive select (floor(random(count _listclosealive))));
				};

			while {alive _victim && alive _unit} do {
				doStop _unit; _unit doTarget _victim; _unit doFire _victim; sleep 0.5;
			};

			_done = true;
		};
	sleep _perfomancesleep;
	};
sleep (_perfomancesleep*3);
};

//Clean up. After the sleeper has been killed we delete his group
deletegroup _grp;