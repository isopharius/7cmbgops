//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

_intelobj = _this select 0;
_buscador = _this select 1;
_callid = _this select 2;

_intelobj removeAction _callid;

sleep 3;
hint "YOU HAVE FOUND SOME INTEL";

sleep 3;
hint "POSITIVE INTEL, ARREST HELPER AND BRING TO MAIN BASE";

deleteVehicle _intelobj;

if(true) exitWith{};