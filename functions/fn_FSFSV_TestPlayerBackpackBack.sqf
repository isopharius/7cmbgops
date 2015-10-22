	private "_return";
	_return = 0;
	if (isnull(player getVariable ["FSFSV_BACKPACK",objnull]) && (backpack player != "") && (vehicle player == player)) then {
		private ["_pos","_iswater"];
		_pos = getPosworld player;
		_iswater = surfaceIsWater _pos;
		if (!(_iswater) || (_iswater && ((_pos select 2) > 0.5))) then {_return = 1;};
	};
	_return