    //Custom delay
    PAPABEAR = [West,"HQ"];
    PAPABEAR sideChat format ["%1, this is PAPA BEAR! Your request has been transmitted!", group player];
    sleep 3 + random 4;
    PAPABEAR sideChat format ["%1, NAVSTAR-67 NORAD-ID 38833 is aligning. This will take about 30 seconds. PAPA BEAR over!", group player];
    sleep 20;
    PAPABEAR sideChat format ["%1, this is PAPA BEAR! NAVSTAR-67 Alignment process is nearly finished. PAPA BEAR over and out!", group player];
    sleep random 5;
    for "_i" from 0 to 4 do {
        _cnt = 5 - _i;
        hint format ["NAVSTAR-67 is ready in %1 seconds!",_cnt];
        sleep 1;
        if (_cnt == 1) then {hint format ["NAVSTAR-67 is ready!",_cnt]};
    };
    sleep 1;

    call seven_fnc_view_satellite;