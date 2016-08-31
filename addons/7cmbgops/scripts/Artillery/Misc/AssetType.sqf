// Returns the type of assset (eg. "mortar","cannon","Rockets")

private["_vehicleType","_parents","_assetType","_magazines","_magazinesT","_magazine"];

_vehicleType = typeOf _this;
_assetType = "INVALID";
_magazines = [];
_magazinesT = [];
_magazine = "";

_parents = [(configfile >> "CfgVehicles" >> _vehicleType),true] call BIS_fnc_returnParents;
//systemChat format ["P: %1",_parents];
if ("StaticMortar" in _parents) then {_assetType = "Mortar"};
if ("StaticCannon" in _parents) then {_assetType = "Cannon"};
if ("MBT_01_mlrs_base_F" in _parents) then {_assetType = "Rockets"};
if ("B_MBT_01_mlrs_base_F" in _parents) then {_assetType = "Rockets"};
if ("MBT_01_arty_base_F" in _parents) then {_assetType = "Cannon"};
if ("B_MBT_01_arty_base_F" in _parents) then {_assetType = "Cannon"};
if ("O_MBT_02_arty_base_F" in _parents) then {_assetType = "Cannon"};
if ("O_MBT_02_arty_F" in _parents) then {_assetType = "Cannon"};
if ("I_MBT_01_arty_F" in _parents) then {_assetType = "Cannon"};
if ("I_MBT_01_mlrs_F" in _parents) then {_assetType = "Rockets"};
if ("rhs_2s3_tv" in _parents) then {_assetType = "Cannon"};

// Second attempt to detect. Assumes unit is a howitzer unless it has some magazines that contain the word "rocket"
if (_assetType isEqualTo "INVALID") then {
	_assetType = "Cannon";
	_magazines = getArray (configFile >> "CfgVehicles" >> _vehicleType >> "magazines");
	_magazinesT= getArray (configFile >> "CfgVehicles" >> _vehicleType >> "turrets" >> "mainturret" >> "magazines");
	_magazines = _magazines + _magazinesT;
	if ((_magazines find "rocket") >= 0) then {_assetType = "Rockets"};
	if ((_magazines find "Rocket") >= 0) then {_assetType = "Rockets"};
	if ((_magazines find "ROCKET") >= 0) then {_assetType = "Rockets"};
	_magazine = _magazines select 0;
	_magazine = toLower _magazine;
	if ((_magazine find "rocket") >= 0) then {_assetType = "Rockets"};
};

if ("rhs_bm21_msv_01" in _parents) then {_assetType = "BM21"};
if ("RHS_BM21_MSV_01" in _parents) then {_assetType = "BM21"};

_assetType