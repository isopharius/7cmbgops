//if(!isserver) exitwith {};

#include "geardefinitions.hpp"

//private ["_crate"];

//clear items
clearWeaponCargoGlobal _this;
clearMagazineCargoGlobal _this;
clearItemCargoGlobal _this;
clearBackpackCargoGlobal _this;

//ambulance loadout
_this addItemCargoGlobal [_bandage,30];
_this addItemCargoGlobal [_packing,20];
_this addItemCargoGlobal [_elastic,10];
_this addItemCargoGlobal [_quikclot,10];
_this addItemCargoGlobal [_tourniquet,10];
_this addItemCargoGlobal [_morphine,20];
_this addItemCargoGlobal [_epi,20];
_this addItemCargoGlobal [_atropine,20];
_this addItemCargoGlobal [_plasma,10];
_this addItemCargoGlobal [_bloodbag,10];
_this addItemCargoGlobal [_saline,10];
_this addItemCargoGlobal [_medkit,20];
_this addItemCargoGlobal [_surgical,10];

_this addMagazineCargoGlobal[_rifle_mag,12];
_this addMagazineCargoGlobal[_grenade,12];
_this addMagazineCargoGlobal[_smoke,12];
_this addMagazineCargoGlobal[_smoke_blue,12];

//load medical crate
//_crate =  createVehicle ["cse_medical_supply_crate_cms",[0,0,0],[],0,"CAN_COLLIDE"];
//[_crate, _this select 0] call cse_fnc_loadObject_LOG;
