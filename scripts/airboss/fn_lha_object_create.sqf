disableSerialization;
	_position = _this select 0;
	_hdg = _this select 1;
	_display = (findDisplay 50001);
	_control = (_display displayCtrl 1006);
	_index = lbCurSel _control;
	_type = _control lbData _index;

	_vehicle = createVehicle [_type, _position, [], 0, "can_collide"];
	_vehicle setposworld [(_position select 0), (_position select 1), 17];
	_vehicle setdir _hdg;

	player reveal _vehicle;
	_vehicle allowdamage true;