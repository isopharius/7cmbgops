    //Custom delay
    PAPABEAR = [West,"HQ"];
    PAPABEAR sideChat format ["%1, this is PAPA BEAR! Your request has been transmitted!", group player];
    sleep 3 + random 4;
    PAPABEAR sideChat format ["%1, CANSTAR-42 NORAD-ID 385818353 is aligning. This will take about 30 seconds. PAPA BEAR over!", group player];
    sleep 20;
    PAPABEAR sideChat format ["%1, this is PAPA BEAR! CANSTAR-42 Alignment process is nearly finished. PAPA BEAR over and out!", group player];
    sleep random 5;
    for "_i" from 0 to 4 do {
        _cnt = 5 - _i;
        hintSilent format ["CANSTAR-42 is ready in %1 seconds!",_cnt];
        sleep 1;
        if (_cnt isEqualTo 1) then {hint format ["CANSTAR-42 is ready!",_cnt]};
    };
    sleep 1;

//script for launch the SATCOM camera

PXS_SatelliteActive = true; //SATCOM is activated

//set view distance
PXS_ViewDistance = viewDistance;
setViewDistance PXS_ViewDistanceNew;

//view dialog interface
PXS_SatelliteDialog = createDialog "PXS_RscSatellite";

//spawn info functions
[] spawn seven_fnc_key_main;
[] spawn seven_fnc_time_view;
[] spawn seven_fnc_coordinates_view;

//create satellite camera
PXS_SatelliteCamera = "camera" camCreate [0,0,0];
PXS_SatelliteCamera cameraEffect ["internal","back"];
call seven_fnc_updateCamera;

showCinemaBorder false;

PXS_ppGrain = ppEffectCreate ["filmGrain",2005];
PXS_ppGrain ppEffectEnable true;
PXS_ppGrain ppEffectAdjust [0.02,1,1,0,1];
PXS_ppGrain ppEffectCommit 0;