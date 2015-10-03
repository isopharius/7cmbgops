disableSerialization;
		//Run when player selects spawning of vehicle
		private["_vehicle","_position","_hdg","_bay","_type","_display","_control","_index"];

		_position = (lhd modeltoworld (LHA_BayPositions select (LHA_SelectedBay - 1)));
		_hdg = (markerdir "controlroom");

		[_position,_hdg] call seven_fnc_lha_object_create;