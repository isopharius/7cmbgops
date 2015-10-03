disableSerialization;
		//Sets visual status of a bay on dialog
		private["_IsSafe","_bay","_ctrl","_pic","_control","_display","_baySelected","_button","_r","_g","_b"];
		_bay = _this select 0;
		_IsSafe = _this select 1;
		_ctrl = 1200 + _bay;
		_pic = 1100 + _bay;
		_display = (findDisplay 50001);
		_control = (_display displayCtrl _ctrl);
		_picture = (_display displayCtrl _pic);
		_button = (_display displayCtrl 1007);
		_baySelected = LHA_SelectedBay > 0;

		if (_IsSafe) then {
			_r = 0.60;
			_g = 0.84;
			_b = 0.47;
		} else {
			_r = 1;
			_g = 0;
			_b = 0;
		};
		_control ctrlSetTextColor [_r,_g,_b,1.0];
		_picture ctrlSetTextColor [_r,_g,_b,1.0];
		LHA_BayStatus set [(_bay - 1),_IsSafe];

		//Check if bay currently selected, if so, disable issuing
		if (_bay == LHA_SelectedBay) then {
			if (_IsSafe) then {
				_control ctrlEnable true;
			} else {
				_control ctrlEnable false;
			};
		};