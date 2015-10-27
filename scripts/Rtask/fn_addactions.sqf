//////////////////////////////////////////////////////////////////
// Function file for ArmA III
// Created by: M4RT14L
//////////////////////////////////////////////////////////////////
if (isHC) exitwith {};

if (!isDedicated) then {
    if (isnil "disarmaction") then {disarmaction = {_this addaction ["<t color='#FF6600'>Disarm the nuke</t>", seven_fnc_disarm_nuke, [], 1, false, true, "", "(player distance _target < 3)"]}};
    if (isnil "iedblow") then {iedblow = {_this addAction ["<t color='#FF6600'>Blow IED</t>", seven_fnc_iedblow, [], 1, false, true, "", "(player distance _target < 3)"]}};
    if (isnil "escolta") then {escolta = {_this addAction ["<t color='#FF6600'>Follow Me</t>", seven_fnc_capture, nil, 6, true, true, "", "(player distance _target < 3)"]}};
    if (isnil "uavdata") then {uavdata = {_this addAction ["<t color='#FF6600'>Recover Intel</t>", seven_fnc_uavdata, nil, 6, true, true, "", "(player distance _target < 3)"]}};
    if (isnil "dragmat") then {dragmat = {_this addAction ["<t color='#FF6600'>Drag stretcher</t>", seven_fnc_dragmat, nil, 6, true, true, "", "(player distance _target < 3)"]}};
    if (isnil "dropmat") then {dropmat = {_this addAction ["<t color='#FF6600'>Drop stretcher</t>", seven_fnc_dropmat, nil, 6, true, true, "", "(player distance _target < 3)"]}};
    if (isnil "loadmat") then {loadmat = {_this addAction ["<t color='#FF6600'>Load stretcher</t>", seven_fnc_loadmat, nil, 6, true, true, "", "(player distance _target < 3)"]}};
    if (isnil "grab") then {grab = {_this addAction ["<t color='#FF6600'>Grab</t>", seven_fnc_grab, nil, 6, true, true, "", "(player distance _target < 3)"]}};
    if (isnil "getintel") then {getintel = {_this addAction ["<t color='#FF6600'>Take intel</t>", seven_fnc_getintel, nil, 6, true, true, "", "(player distance _target < 3)"]}};
    if (isnil "towvehicle") then {towvehicle = {_this addAction ["<t color='#FF6600'>Tow vehicle</t>", seven_fnc_vehtower, nil, 6, true, true, "", "(player distance _target < 3)"]}};
    if (isnil "untowvehicle") then {untowvehicle = {_this addAction ["<t color='#FF6600'>Release vehicle</t>", seven_fnc_unvehtower, nil, 6, true, true, "", "(player distance _target < 3)"]}};
};

if (!isserver) exitwith {};

mrkSpawnTown = [];
mrkSpawnSite = [];
mrkSpawnPos = [];
{
    if (_x find "town" > -1) exitwith {
        mrkSpawnTown pushback _x;
    };
    if (_x find "aosite" > -1) exitwith {
        mrkSpawnSite pushback _x;
    };
    if (_x find "road" > -1) exitwith {
        mrkSpawnPos pushback _x;
    };
} foreach allmapmarkers;