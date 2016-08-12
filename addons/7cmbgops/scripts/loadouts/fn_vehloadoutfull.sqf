if(!isserver) exitwith {};

#include "geardefinitions.hpp"

private ["_items","_mags","_weps","_crate"];

_items = [
	[_prc152,2],
	[_rangefinder,1],
	[_bino,1],
	[_toolkit,1],
	[_bp_radio,1],
	[_earplugs,10],
	[_bandage,20],
	[_tourniquet,5],
	[_kestrel,1],
	[_maptools,1],
	[_dagr,1],
	[_sparebarrel,5],
	[_cable,5]
];

_mags = [
	[_rifle_mag,30],
	[_lmg_mag,6],
	[_grenade,24],
	[_smoke,24],
	[_smoke_green,6],
	[_smoke_red,6],
	[_smoke_blue,6],
	[_gl_he,24],
	[_gl_smoke,24],
	[_gl_smoke_green,12],
	[_gl_smoke_red,6],
	[_gl_smoke_blue,6],
	[_gl_flare_white,6]
];

_weps = [
	[_lat,10]
];

_crate = createVehicle ["B_supplyCrate_F",[0,0,0],[],0,"can_collide"];

clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

{
	_crate addItemCargoGlobal _x;
} foreach _items;

{
	_crate addMagazineCargoGlobal _x;
} foreach _mags;

{
	_crate addWeaponCargoGlobal _x;
} foreach _weps;