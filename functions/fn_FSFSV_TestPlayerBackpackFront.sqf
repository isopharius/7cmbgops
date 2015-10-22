	private "_return";
	_return = 0;
	if (!isnull(player getVariable ["FSFSV_BACKPACK",objnull]) && (backpack player == "") && (isNull objectParent player)) then {
		_return = 1;
	};
	_return