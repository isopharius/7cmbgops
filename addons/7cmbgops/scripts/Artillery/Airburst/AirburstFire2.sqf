private["_pos","_explosionSize","_airburstHeight","_shrapnelConcentration","_tubeType","_airburstHeight","_explosionSize","_explosionShrapnel","_firedClear","_ammoAltitude"];
disableSerialization;
params ["_tube","_projectile","_height"];
_pos = getPosATL _projectile;

// Size of explosion EFFECT used (not actual lethality) 1 = Small, 2 = Large
_explosionSize = 0;
_airburstHeight = 0;
//SHRAPNEL CONCENTRATION
//0 = none, 1 = short range small amount, 2 = med range small amount, 3 = long range small amount
//4 = short range large amount, 5 = med range large amount, 6 = long range large amount
_shrapnelConcentration = 0;
// Maximum range for lethal shrapnel
_effectiveRange = 0;
// Maximum range for shrapnel
_maxRange = 0;
// Falloff of shrapnel lethality over range (1 = Linear, 3 = Standard, 5 = Drastic
_falloff = 0;

_tubeType = "UNKNOWN";
_tubeType = _tube call dta_fnc_TubeType;

if (_tubeType isEqualTo "82mmMortar") then {
	_explosionSize = 1;
	_shrapnelConcentration = 5;
	_effectiveRange = 40;
	_maxRange = 150;
	_falloff = 3;
}
else {
	if (_tubeType isEqualTo "155mmHowitzer") then {
		_explosionSize = 1;
		_shrapnelConcentration = 2;
		_effectiveRange = 80;
		_maxRange = 250;
		_falloff = 3;
	}
	else {
		// Note that 230mm does not have airburst in this system, this is just theoretical
		if (_tubeType isEqualTo "230mmRockets") then {
			_explosionSize = 1;
			_shrapnelConcentration = 6;
			_effectiveRange = 100;
			_maxRange = 350;
			_falloff = 3;
		}
		else {
			// For unrecognized pieces use 155mm
			if (_tubeType isEqualTo "INVALID") then {
				_explosionSize = 1;
				_shrapnelConcentration = 2;
				_effectiveRange = 80;
				_maxRange = 250;
				_falloff = 3;
			};
		};
	};
};

// Real world values
//if (_height == "low") then {_airburstHeight = 0.9};
//if (_height == "med") then {_airburstHeight = 9};
//if (_height == "high") then {_airburstHeight = 18};

// Game values (loops in scripts may not catch the height quickly enough if too low)

if (_height isEqualTo "LOW") then {_airburstHeight = 15};
if (_height isEqualTo "MED") then {_airburstHeight = 20};
if (_height isEqualTo "HIGH") then {_airburstHeight = 30};

_firedClear = false; //Is round clear of the launcher (higher than airburst height)
_ammoAltitude = 0;

//Only run airburst script if our launcher is set to airburst (ie. explosion height above ground level)
if (_airburstHeight > 0) then {
	while {alive _projectile} do {
		sleep 0.01;
		_pos = getPosATL _projectile;
		_ammoAltitude = _pos select 2;
//		player sideChat format ["alt: %1",_ammoAltitude];
		//If projectile clear of airburst height on upwards trajectory
		if (_ammoAltitude > _airburstHeight) then {_firedClear = true};
		//If projectile below airburst height
		if (_ammoAltitude < _airburstHeight) then {
			//And already cleared it once (ie. we are going down, not coming up)
			if (_firedClear) then {
				_projectile  setVelocity [0, 0, 0];
				[_pos,_explosionSize,_shrapnelConcentration,_effectiveRange,_maxRange,_fallOff] execVM "\7cmbgops\scripts\Artillery\Airburst\AirburstHit.sqf";
				deleteVehicle _projectile;
			};
		};
	};
};