disableSerialization;
		//Run when player moves mouse over or off a bay
		private["_ctrl","_pic","_isOver","_control","_display","_status","_r","_g","_b"];
		_ctrl = _this select 0;
		_pic = _ctrl - 100;

		if (LHA_SelectedBay != (_ctrl - 1200)) then {
			_isOver = _this select 1;
			_display = (findDisplay 50001);
			_control = (_display displayCtrl _ctrl);
			_picture = (_display displayCtrl _pic);
			_status = (LHA_BayStatus select ((_ctrl - 1200) - 1));
			if (_status) then {
				_r = 0.60;
				_g = 0.84;
				_b = 0.47;
			} else {
				_r = 1;
				_g = 0;
				_b = 0;
			};
			if (_isOver) then {
				//Mouse is over control
				_control ctrlSetTextColor [_r,_g,_b,1.0];
				_picture ctrlSetTextColor [_r,_g,_b,1.0];
			} else {
				_control ctrlSetTextColor [_r,_g,_b,0.7];
				_picture ctrlSetTextColor [_r,_g,_b,0.7];
			};
		};