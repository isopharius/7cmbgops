// Returns the type of ammo in a short text-friendly form

private["_out"];
disableSerialization;
params ["_ammo"];
_out = "";
if (_ammo isEqualTo "8Rnd_82mm_Mo_shells") then {_out = "HE"};
if (_ammo isEqualTo "8Rnd_82mm_Mo_Flare_white") then {_out = "Flare"};
if (_ammo isEqualTo "8Rnd_82mm_Mo_Smoke_white") then {_out = "Smoke"};
if (_ammo isEqualTo "32Rnd_155mm_Mo_shells") then {_out = "HE"};
if (_ammo isEqualTo "6Rnd_155mm_Mo_smoke") then {_out = "Smoke"};
if (_ammo isEqualTo "2Rnd_155mm_Mo_guided") then {_out = "Guided"};
if (_ammo isEqualTo "2Rnd_155mm_Mo_cluster") then {_out = "Cluster"};
if (_ammo isEqualTo "2Rnd_155mm_Mo_lg") then {_out = "Laser.G"};
if (_ammo isEqualTo "6Rnd_155mm_Mo_mine") then {_out = "Mine"};
if (_ammo isEqualTo "6Rnd_155mm_Mo_AT_mine") then {_out = "AT Mine"};
if (_ammo isEqualTo "12Rnd_230mm_rockets") then {_out = "Rockets"};

if (_ammo isEqualTo "32Rnd_155mm_Mo_wp") then {_out = "WP"};
if (_ammo isEqualTo "1Rnd_155mm_Mo_chem") then {_out = "Chemical"};
if (_ammo isEqualTo "1Rnd_155mm_Mo_nuke") then {_out = "Nuclear"};

if (_ammo isEqualTo "RDS_30Rnd_105mmHE_M119") then {_out = "HE"};
if (_ammo isEqualTo "RDS_30Rnd_105mmWP_M119") then {_out = "WP"};
if (_ammo isEqualTo "RDS_30Rnd_105mmLASER_M119") then {_out = "Laser.G"};
if (_ammo isEqualTo "RDS_30Rnd_105mmSMOKE_M119") then {_out = "Smoke"};
if (_ammo isEqualTo "RDS_30Rnd_105mmILLUM_M119") then {_out = "Flare"};
_out