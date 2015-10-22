onMapSingleClick {
    onMapSingleClick "";
    openMap false;
    [_pos] spawn {
    	_pos = _this select 0;
		["mkr_halo", _pos, "ICON", [1,1], "COLOR:", "ColorGreen", "TEXT:", "Jump", "TYPE:", "hd_dot"] call CBA_fnc_createMarker;

		_loadout = [player] call seven_fnc_getloadout;

		player setposworld [(_pos select 0),(_pos select 1),((_pos select 2)+8000)];

		removeBackpack player;
		player addBackpack "B_Parachute";

		waituntil {!alive player || ((isTouchingGround player || underwater player) && player == vehicle player)};
		[player,_loadout] call seven_fnc_setloadout;

		deletemarker "mkr_halo";
	};
};

hint "Choose HALO position";
openMap true;

