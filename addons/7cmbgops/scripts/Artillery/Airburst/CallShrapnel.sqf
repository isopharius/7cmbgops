/*
//Called by \7cmbgops\scripts\Artillery\Airburst\AirburstHit.sqf
// nul = [Shrapnel start point (Array or (getPosASL OBJECT) ), Concentration (bits per person), 99.9% Lethal range (prior to large dispersion), Maximum range (targets outside this range will never get shrapnel fired at them), Rate of falloff after lethal range (1 is linear, 3 is normal - drops off rapidly after that range, 5 is extreme - drops off very rapidly after that range)] execVM "ZSU_A3Shrapnel\callshrap.sqf"
//
//
*/

params ["_destroyPos", "_conc", "_effRange", "_maxRange", "_falloff"];

if (_falloff < 1) then {_falloff = 1;};
if (_falloff > 5) then {_falloff = 5;};

_listNear = _destroyPos nearEntities _maxRange;

{
for [{_i = 0}, {_i < (_conc)}, {_i = _i + 1}] do{
	[_x, _destroyPos, _effRange, _falloff] execVM "\7cmbgops\scripts\Artillery\Airburst\OriginToTarget.sqf";
	}
}foreach _listNear;