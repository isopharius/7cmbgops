disableSerialization;
		//Run when a player selects a bay
		private["_bay","_ctrl","_pic","_control","_display","_baytext","_status","_r","_g","_b","_TextVehicle","_TextDriver","_baySelected","_bayStatus","_vehList","_type","_ctrlSpawn","_ctrlReturn","_ctrlService"];
		_bay = _this select 0;
		if (LHA_SelectedBay > 0) then {
			_status = (LHA_BayStatus select (LHA_SelectedBay - 1));
		} else {
			_status = false;
		};

		if (_status) then {
			_r = 0.60;
			_g = 0.84;
			_b = 0.47;
		} else {
			_r = 1;
			_g = 0;
			_b = 0;
		};

		//Set New Control White
		_ctrl = 1200 + _bay;
		_pic = 1100 + _bay;
		_display = (findDisplay 50001);
		_control = (_display displayCtrl _ctrl);
		_ctrlSpawn = (_display displayCtrl 1007);
		_ctrlReturn = (_display displayCtrl 1008);
		_ctrlService = (_display displayCtrl 1009);
		_ctrlLoad = (_display displayCtrl 1010);
		_picture = (_display displayCtrl _pic);
		_control ctrlSetTextColor [1,1,1,1];
		_picture ctrlSetTextColor [1,1,1,1];

		//Set Old Control Normal
		_ctrl = 1200 + LHA_SelectedBay;
		_pic = 1100 + LHA_SelectedBay;
		_control = (_display displayCtrl _ctrl);
		_picture = (_display displayCtrl _pic);
		_control ctrlSetTextColor [_r,_g,_b,0.7];
		_picture ctrlSetTextColor [_r,_g,_b,0.7];

		//Set Bay Selected
		LHA_SelectedBay = _bay;
		_baytext = (_display displayCtrl 1003);
		_baytext ctrlSetText format ["Bay #%1",_bay];
		_TextVehicle = (_display displayCtrl 1004);
		_TextDriver = (_display displayCtrl 1005);
		_TextVehicle ctrlSetText "None";
		_TextDriver ctrlSetText "None";
		LHA_ActiveObject = player;