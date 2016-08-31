private ["_g","_alt","_distance","_v","_highAngle","_highETA","_lowAngle","_lowETA","_angle","_ETA","_weapon","_warheadType","_modes","_ammoSpeed","_artyAlt","_sleepTime","_airburstEH","_doAirburst","_newPos","_scatter","_scatter2","_group","_allTubes","_selectedTube","_tubeIndex","_isLeader","_loaded","_magazineClass","_firstRound","_flightTime","_timeBetweenRounds","_minimumRange","_maximumRange","_distance","_vx","_vy","_vx","_vy","_dx","_dy","_specialEH","_action","_reloadDifference","_trackEH","_tube","_crew","_gunner","_posx","_y","_elevation","_z","_charge","_a","_b","_c","_d","_e","_tube","_rounds","_profile","_pos","_warheadType","_missionType","_sheafSize","_fuse","_assetType","_sheaf","_airburstHeight","_flightTime","_asset","_tubeType"];

params ["_tube","_rounds","_profile","_pos","_warheadType","_missionType","_sheafSize","_fuse","_assetType","_sheaf","_airburstHeight","_flightTime","_asset","_tubeType","_gunAngle","_dtaSelectedTube"];

_gunner = gunner _tube;
_crew = crew _tube;
sleep 1;

if NOT((currentMagazine _tube) isEqualTo _warheadType) then {
	[_tube,_warheadType] call dta_fnc_LoadMagazine;
};

[
	[_tube, _crew, _gunner],
	{
		params ["_tube", "_crew", "_gunner"];
		{
			_x disableAI "TARGET";
			_x disableAI "AUTOTARGET";
		} foreach _crew;
		_tube disableAI "TARGET";
		_tube disableAI "AUTOTARGET";
		_tube setWeaponReloadingTime [_gunner, (currentMuzzle _gunner), 0];
		_gunner setSkill 1;
		_gunner setSkill ["ReloadSpeed",1];
		_gunner setSkill ["aimingSpeed",0.2];
	}
] remoteExecCall ["bis_fnc_call", _tube, false];

// Convert from XXX to XXXXX for BIS map coordinates
_posx = _pos select 0;
_y = _pos select 1;
// Elevation of target position
_z = _pos select 2;
//_elevation = _pos select 2;
_elevation = 0;
_posx = _posx * 10;
_y = _y * 10;
_pos = [_posx,_y];

// Break down firing profile
_charge = _profile select 0;
_timeBetweenRounds = _profile select 1;
_minimumRange = _profile select 2;
_maximumRange = _profile select 3;

//systemChat format ["%1",_timeBetweenRounds];

// Gravity
_g = 9.81;
// Altitude difference between firing position and target position
_alt = 0;
// Distance between firing position and target position
_distance = 0;
// Speed of round
_v = 0;

_highAngle = 0;
_highETA = 0;
_lowAngle = 0;
_lowETA = 0;
_angle = 0;
_ETA = 0;
// Altitude difference
_artyAlt = (getPosASL _tube) select 2;
_alt = _z - _artyAlt;
//systemChat format ["ART: %1  _z: %2  _alt: %3",_artyAlt,_z,_alt];

// Get shell speed
_weapon = weapons _tube select 0;
// Speed
_ammoSpeed = getNumber(configfile >> "CfgMagazines" >> _warheadType >> "initSpeed");
_v = _ammoSpeed * getNumber(configfile >> "CfgWeapons" >> _weapon >> _charge >> "artilleryCharge");

_distance = 0;
_vx = 0;
_vy = 0;
_vx = (getPos _tube) select 0;
_vy = (getPos _tube) select 1;
_dx = 0;
_dy = 0;

// Random delay in loading for each tube
_reloadDifference = 0;
_sleepTime = 0;

// Check if barrel is on target
_tubeDir = 0;
_relative = 0;
_difference = 999;

//systemChat format ["WARHEAD: %1",_warheadType];systemChat format ["GUIDED TYPES: %1",dtaGuidedTypes];

// SPECIAL EFFECTS: airburst, guided, laser-guided, etc)
_specialEH = 0;
// Can not use text for this
_action = 0;
if (_warheadType in dtaLaserTypes) then {
	_fuse = "";
	_action = 1;
	_specialEH = _tube addEventHandler ["fired", compile format ["[_this,%1,%2] call seven_fnc_Fired",_action,_pos]];
};

if (_warheadType in dtaWPTypes) then {
	_fuse = "";
	_action = 2;
	_specialEH = _tube addEventHandler ["fired", compile format ["[_this,%1,%2] call seven_fnc_Fired",_action,_pos]];
};

if (_warheadType in dtaGuidedTypes) then {
	_fuse = "";
	_action = 3;
	_specialEH = _tube addEventHandler ["fired", compile format ["[_this,%1,%2] call seven_fnc_Fired",_action,_pos]];
};

_airburstEH = 0;
_doAirburst = true;
if (_fuse isEqualTo "AIRBURST") then {
	if (_airburstHeight isEqualTo "LOW") then {_airburstEH = _tube addEventHandler ["fired",{_this call seven_fnc_AirburstFireLow}]};
	if (_airburstHeight isEqualTo "MED") then {_airburstEH = _tube addEventHandler ["fired",{_this call seven_fnc_AirburstFireMed}]};
	if (_airburstHeight isEqualTo "HIGH") then {_airburstEH = _tube addEventHandler ["fired",{_this call seven_fnc_AirburstFireHigh}]};
};

_newPos = [];
_scatter = 0;
_scatter2 = 0;
_scatter = _sheafSize select 0;
_scatter2 = _sheafSize select 1;
if (_scatter2 isEqualTo 0) then {_scatter2 = _scatter};
if (_missionType isEqualTo "SPOT") then {_scatter = 0};

if (_sheaf isEqualTo "POINT") then {_scatter = 0};

// Alternate airburst for MIXED missions
_group = group _tube;
_allTubes = [_group] call dta_fnc_GroupVehicles;
_selectedTube = objNull;
_tubeIndex = 0;
while {(_tubeIndex < (count _allTubes))} do {
	_selectedTube = _allTubes select _tubeIndex;
	if (_selectedTube isEqualTo _tube) then {
		if ((_tubeIndex mod 2) > 0) then {_doAirburst = false};
		_allTubes = [];
	};
	_tubeIndex = _tubeIndex + 1;
};

_isLeader = false;
if ((leader _group) in _crew) then {_isLeader = true};
_loaded = false;
_magazineClass = "";
_firstRound = true;

while {(_rounds > 0)} do {
	// Get appropriate sheaf
	if (_scatter > 0) then {
		_newPos = _pos;
		if (_sheaf isEqualTo "CIRC") then {_newPos = [_pos,_scatter] call dta_fnc_CircularSheaf};
		if (_sheaf isEqualTo "BOX") then {_newPos = [_tube,_pos,_scatter,_scatter2] call dta_fnc_BoxSheaf};
		sleep 0.1;
		_posx = _newPos select 0;
		_y = _newPos select 1;
		//[_newPos,60] call dta_fnc_PlaceMarker;
	};

	// Get distance
	_dx = _posx - _vx;
	_dy = _y - _vy;
	_distance = sqrt((_dx*_dx)+(_dy*_dy));

	// Thank you very much to Coding for this code to find the correct angle and _z access
	if (_v^4-_g*(_g*_distance^2+2*_alt*_v^2) < 0) exitWith {[_asset,"Negative, impossible shot.","Negative"] call dta_fnc_SendComms;};
	_highAngle = atan((_v^2+sqrt(_v^4-_g*(_g*_distance^2+2*_alt*_v^2)))/(_g*_distance));
	_highETA = _distance/(_v*cos(_highAngle));
	_lowAngle = atan((_v^2-sqrt(_v^4-_g*(_g*_distance^2+2*_alt*_v^2)))/(_g*_distance));
	_lowETA = _distance/(_v*cos(_lowAngle));
	//systemChat format ["%1 %2 %3 %4 %5",_highAngle,_highETA,_lowAngle,_lowETA,_distance];

	_angle = _lowAngle;
	_ETA = _lowETA;
	if (_gunAngle isEqualTo "HIGH") then {_angle = _highAngle; _ETA = _highETA};
	_ETA = round _ETA;
	_z = _distance * (tan _angle);
	//systemChat format ["A: %1  Z: %2  D: %3",_angle,_z,_distance];

	// Aim tube
	[_gunner, [_posx,_y,_z]] remoteExecCall ["doWatch", _gunner, false];

	if (_firstRound) then {
		if (_gunAngle isEqualTo "LOW") then {
			sleep 5
		} else {
			if (_gunAngle isEqualTo "HIGH") then {
				sleep 10
			};
		};
	};

	_sleepTime = 1;
	if NOT((_assetType isEqualTo "Rockets") OR (_assetType isEqualTo "BM21")) then {_sleepTime = 2};
	if (_sheaf isEqualTo "POINT") then {_sleepTime = 1};
	sleep _sleepTime;

	if (_fuse isEqualTo "MIXED") then {
		if (_doAirburst) then {
			if (_airburstHeight isEqualTo "LOW") then {_airburstEH = _tube addEventHandler ["fired",{_this call seven_fnc_AirburstFireLow}]};
			if (_airburstHeight isEqualTo "MED") then {_airburstEH = _tube addEventHandler ["fired",{_this call seven_fnc_AirburstFireMed}]};
			if (_airburstHeight isEqualTo "HIGH") then {_airburstEH = _tube addEventHandler ["fired",{_this call seven_fnc_AirburstFireHigh}]};
			_doAirburst = false;
		}
		else {
			_tube removeEventHandler ["fired",_airburstEH];
			_doAirburst = true;
		};
	};

	// DO NOT SET THIS UNDER 5 OR ROUNDS WILL START SPRAYING EVERYWHERE
    _sleepTime = 5;
	if (_assetType isEqualTo "BM21") then {_sleepTime = 0.1};
	if (_assetType isEqualTo "Rockets") then {_sleepTime = 0.1};
	sleep _sleepTime;

    // Fire
    //_tube fire [_tubeType,_charge,_warheadType];

	[_tube, [_tubeType, _charge]] remoteExecCall ["fire", _tube, false];
	if (_firstRound) then {
		if (_tube isEqualTo _dtaSelectedTube) then {
			_message = format ["Shot. ETA %1 seconds.",_ETA];
			if (_missionType isEqualTo "FFE") then {_message = format ["Shot. ETA %1 seconds.",_ETA]};
			[_asset,_message,"Shot"] call dta_fnc_SendComms;
			[_ETA,_asset] call seven_fnc_Splash;
		};
	};
	_firstRound = false;
	sleep _sleepTime;

	if (_missionType isEqualTo "SPOT") then {
		dtaAssetsBusy = dtaAssetsBusy - [_asset];
		publicVariable "dtaAssetsBusy";
	};

	_reloadDifference = (random 1.5);
	if ((_assetType isEqualTo "Rockets") OR (_assetType isEqualTo "BM21")) then {_reloadDifference = 0};
	_rounds = _rounds - 1;
	sleep _timeBetweenRounds;
};

if (dtaTrackRounds) then {_tube removeEventHandler ["fired",_trackEH]};

// Remove the airburst EH
if ((_fuse isEqualTo "AIRBURST") OR (_fuse isEqualTo "MIXED")) then {_tube removeEventHandler ["fired",_airburstEH]};
if (_action > 0) then {_tube removeEventHandler ["fired",_specialEH]};

// Release the group from being busy (firing) and allow the controlling player to issue orders again
if ((_tube isEqualTo (vehicle (leader _asset))) AND (_missionType isEqualTo "FFE")) then {
		sleep 2;
		dtaAssetsBusy = dtaAssetsBusy - [_asset];
		publicVariable "dtaAssetsBusy";
		[_asset,"Rounds complete.","RoundsComplete"] call dta_fnc_SendComms;
};

if (_missionType isEqualTo "SPOT") then {
		dtaAssetsBusy = dtaAssetsBusy - [_asset];
		publicVariable "dtaAssetsBusy";
};

[
	[_crew, _gunner],
	{
		{
			_x enableAI "AUTOTARGET";
			_x enableAI "TARGET";
		} foreach (_this select 0);
		(_this select 1) setSkill ["aimingSpeed",1];
	}
] remoteExecCall ["bis_fnc_call", _tube, false];