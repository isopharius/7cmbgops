satclick = addMissionEventHandler [
    "MapSingleClick",
    {
        if ((player distance _pos) < 5000) then {
            onMapSingleClick "";
            PXS_SatelliteTarget = "Logic" createVehicleLocal _pos;
            PXS_SatelliteTarget setDir 0;
            [] spawn seven_fnc_PXS_Delay;
            openMap false;
        } else {
            if (true) exitwith {
                hint "Satellite viewrange is limited to a 5 kilometers radius!";
            };
        };
    }
];

hint "Click on the map to insert default satellite coordinates.";
openMap true;