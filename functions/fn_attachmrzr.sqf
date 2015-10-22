_mrzr = _this;
_bppoints = ["backpack1", "backpack2","backpack3", "backpack4"];
_weppoints = ["weapon1", "weapon2"];
_attached = attachedObjects _mrzr;

{
	detach _x;
	deletevehicle _x;
} foreach _attached;

_bp = backpackCargo _mrzr;
{
	_bpcount = count _bppoints;
	if (_bpcount > 0) then {
		_rnd = floor (random _bpcount);
		_holder = createVehicle ["GroundWeaponHolder",[((getPosworld _mrzr) select 0),((getPosworld _mrzr) select 1),100],[],0, "CAN_COLLIDE"];
		_holder addBackpackCargoGlobal [_x, 1];
		_rndpoint = _bppoints select _rnd;
		_holder attachto [_mrzr, [0, 0, 0], _rndpoint];
		[_holder,[90,-90]] call bis_fnc_setpitchbank;
		_holder enablesimulationglobal false;
		_bppoints deleteat _rnd;
	};
} foreach _bp;

_wep = weaponCargo _mrzr;
{
	_wepcount = count _weppoints;
	if ((_wepcount > 0) && (_x iskindof "Launchers_Base_F")) then {
		_rnd = floor (random _wepcount);
		_holder = createVehicle ["GroundWeaponHolder",[((getPosworld _mrzr) select 0),((getPosworld _mrzr) select 1),100],[],0, "CAN_COLLIDE"];
		_holder addWeaponCargoGlobal [_x, 1];
		_rndpoint = _weppoints select _rnd;
		_holder attachto [_mrzr, [0, 0, 0], _rndpoint];
		[_holder,[90,-90]] call bis_fnc_setpitchbank;
		_holder enablesimulationglobal false;
		_weppoints deleteat _rnd;
	};
} foreach _wep;