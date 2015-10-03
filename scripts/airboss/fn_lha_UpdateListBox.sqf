disableSerialization;
		private["_index","_list","_vehName","_listBox","_x"];
		//Run when we need up update the listbox
		_index = 0;
		_listBox = _this select 0;
		lbClear _listBox;

		//Add stuff to list
		_list = LHA_SpawnableVehicles;
		{
			_vehName = getText (configfile >> "CfgVehicles" >> _x >> "displayName");
			_listBox lbAdd _vehName;
			_listBox lbSetData [_index, _x];
			_listBox lbSetValue [_index,0];		//NO ID FOR THIS!
			_index = _index + 1;
		} foreach _list;