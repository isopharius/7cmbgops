// Called from \7cmbgops\scripts\Artillery\Control\Server.sqf

private["_fireMission","_asset","_pos","_warheadType","_rounds","_distance","_missionType","_angle","_sender","_timeStamp","_prePlotted","_sheaf","_fuse","_sheafSize"];
private["_posDisplay","_airburstHeight","_firstRound","_tubes","_tubes","_vehicle","_assetType","_tubeType","_ammoType","_assetCallsign","_displayName","_message"];
private["_timeBetweenRounds","_minimumRange","_maximumRange","_flightTime","_sleepTime","_plottingTime","_tubeArray"];

if (dtaDebug) then {systemChat "Process Fire Mission"};

_fireMission = _this;

_asset = _fireMission select 0;
_pos = _fireMission select 1;
_warheadType = _fireMission select 2;
_rounds = _fireMission select 3;
_distance = _fireMission select 4;
_missionType = _fireMission select 5;
_angle = _fireMission select 6;
_sender = _fireMission select 7;
//_timeStamp = _fireMission select 8;
_prePlotted = _fireMission select 9;
_sheaf = _fireMission select 10;
_fuse = _fireMission select 11;
_sheafSize = _fireMission select 12;
//_posDisplay = _fireMission select 13;
_airburstHeight = _fireMission select 14;
_firstRound = _fireMission select 15;

dtaAssetsBusy pushBack _asset;
publicVariable "dtaAssetsBusy";

_tubes = [];
_tubes = [_asset] call dta_fnc_GroupVehicles;
_type = "";
_tube = objNull;

_vehicle = dtaSelectedTube;
_selectedTube = dtaSelectedTube;
_assetType = _vehicle call dta_fnc_AssetType;
if (_assetType isEqualTo "INVALID") exitWith {
	[_asset,"Invalid asset type.","Negative"] call dta_fnc_SendComms;
	dtaAssetsBusy = dtaAssetsBusy - [_asset];
	publicVariable "dtaAssetsBusy";
};

_profile = [];
if (_assetType isEqualTo "Mortar") then {_profile = [_distance] call dta_fnc_ProfileMortar};
if ((_assetType isEqualTo "Cannon") AND (_angle isEqualTo "LOW")) then {_profile = [_distance] call dta_fnc_ProfileCannonLA};
if ((_assetType isEqualTo "Cannon") AND (_angle isEqualTo "HIGH")) then {_profile = [_distance] call dta_fnc_ProfileCannonHA};
if ((_assetType isEqualTo "Rockets") AND (_angle isEqualTo "LOW")) then {_profile = [_distance] call dta_fnc_ProfileRocketsLA};
if ((_assetType isEqualTo "Rockets") AND (_angle isEqualTo "HIGH")) then {_profile = [_distance] call dta_fnc_ProfileRocketsHA};
if (_assetType isEqualTo "BM21") then {_profile = [_distance] call dta_fnc_ProfileBM21};

_tubeType = weapons _vehicle select 0;
_ammoType = getText (configFile >> "CfgMagazines" >> _warHeadType >> "displayName");
_assetCallsign = [_asset] call dta_fnc_TrimGroupName;
_displayName = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

_message = format ["%1 this is %2. %3 x %4 firing %5, %6 rounds, %7 sheaf, %8 fuse, over.",_sender,_assetCallsign,(count _tubes),_displayName,_ammoType,_rounds,_sheaf,_fuse];
if (_missionType isEqualTo "SPOT") then {_message = format ["%1 this is %2. %3 x %4 firing %5, %6 round, %7 fuse, over.",_sender,_assetCallsign,(count _tubes),_displayName,_ammoType,_rounds,_fuse]};

if (_firstRound) then {[_asset,_message,"MTO"] call dta_fnc_SendComms}
	else
{
	if (_missionType isEqualTo "FFE") then {[_asset,_message,""] call dta_fnc_SendComms}
};

_timeBetweenRounds = _profile select 1;
_minimumRange = _profile select 2;
_maximumRange = _profile select 3;

// Obsolete
_flightTime = 0;

_sleepTime = 6 + (random 5);

if (dtaNoDelay) then {_sleepTime = 0};
if (dtaDebug) then {_sleepTime = 0};

if (_distance < _minimumRange) exitWith {
	sleep _sleepTime;
	[_asset,"Negative, under minimum range.","Negative"] call dta_fnc_SendComms;
	dtaAssetsBusy = dtaAssetsBusy - [_asset];
	publicVariable "dtaAssetsBusy";
};
if (_distance > _maximumRange) exitWith {
	sleep _sleepTime;
	[_asset,"Negative, out of range.","Negative"] call dta_fnc_SendComms;
	dtaAssetsBusy = dtaAssetsBusy - [_asset];
	publicVariable "dtaAssetsBusy";
};

if ((_missionType isEqualTo "SPOT") OR {(_missionType isEqualTo "FFE")}) then {
	[_asset,_warheadType] call dta_fnc_LoadMagazineGroup;
	if (dtaDebug) then {sleep 10};
	//[_asset,_warheadType,_pos] call dta_fnc_LoadMagazineGroup;
	//systemChat "Loading group";
};

// Wait for plotting time
_plottingTime = 0;
// Basic value, balancing a semi-realistic and gameplay-friendly delay of 60 to 90 seconds
//_plottingTime = (20 + (random 10));
_plottingTime = (5 + (random 10));

// Old value
//if (_firstRound) then {_plottingTime = (60 + (random 30))};
// New value (less realistic, but more fun ingame)
if (_firstRound) then {_plottingTime = (30 + (random 30))};

if (NOT(_firstRound) AND (_missionType isEqualTo "FFE")) then {_plottingTime = (10 + (random 5))};
// Realistic value, a delay of 3 to 5 minutes
//if ((dtaRealisticTimes) AND NOT(_firstRound)) then {_plottingTime = (90 + (random 60))};
if (dtaRealisticTimes) then {_plottingTime = (45 + (random 20))};
if ((dtaRealisticTimes) AND (_firstRound)) then {_plottingTime = (120 + (random 120))};
// Pre-plotted missions have no meaningful delay
if (_prePlotted) then {_plottingTime = 5};
// For testing purposes
if (dtaNoDelay) then {_plottingTime = 0};
if (dtaDebug) then {_plottingTime = 0};
//_plottingTime = 0;
sleep _plottingTime;

if (_warheadType in dtaGuidedTypes) then {_angle = "HIGH"; systemChat "Guided shell, forcing HIGH angle"};
if (_warheadType in dtaLaserTypes) then {_angle = "HIGH"; systemChat "Laser guided shell, forcing HIGH angle"};

// PERFORM MISSIONS //
if (_missionType isEqualTo "PLOT") exitWith {
	[_asset,"Fire mission registered.","FireMissionReady"] call dta_fnc_SendComms;
	dtaAllMissions pushBack _fireMission;
	publicVariable "dtaAllMissions";
	dtaAssetsBusy = dtaAssetsBusy - [_asset];
	publicVariable "dtaAssetsBusy";
};

// All tubes for FFE missions
_tubes = [_asset] call dta_fnc_GroupVehicles;
// Only selected tube for SPOT missions
if (_missionType isEqualTo "SPOT") then {_tubes = [dtaSelectedTube]};

_tubeArray = [];
while {((count _tubes) > 0)} do {
	_tube = _tubes select 0;
	_tubes = _tubes - [_tube];

	[_tube,_rounds,_profile,_pos,_warheadType,_missionType,_sheafSize,_fuse,_assetType,_sheaf,_airburstHeight,_flightTime,_asset,_tubeType,_angle,_selectedTube] remoteExec ["seven_fnc_Tube", _tube, false];

	if (_missionType isEqualTo "SPOT") then {_tubes = []};
};

// This sleep is for the initial processing for the fire mission at the tube level and waiting for the first shot to be fired
if (_missionType isEqualTo "FFE") then {
	dtaAllMissions pushBack _fireMission;
	publicVariable "dtaAllMissions";
};
