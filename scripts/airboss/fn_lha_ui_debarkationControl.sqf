disableSerialization;

//Initate Debarkation Control
	USEC_Dialog_DKC = createDialog USEC_DebarkDialog;

	WaitUntil {USEC_Dialog_DKC};

	//Initialize Display Variables
	_display=(findDisplay USEC_DebarkDisplay);
	_listBox = (_display displayCtrl 1006);
	_TextVehicle = (_display displayCtrl 1004);
	_TextDriver = (_display displayCtrl 1005);
	_IconVehicle = (_display displayCtrl 1002);

	//Set Button states
	_ctrlSpawn = (_display displayCtrl 1007);
	_ctrlReturn = (_display displayCtrl 1008);
	_ctrlService = (_display displayCtrl 1009);
	_ctrlLoad = (_display displayCtrl 1010);
	_ctrlLoadPers = (_display displayCtrl 1011);
	_ctrlSpawn ctrlEnable false;
	_ctrlReturn ctrlEnable false;
	_ctrlService ctrlEnable false;
	_ctrlLoad ctrlEnable false;
	_ctrlLoadPers ctrlEnable false;

	[_listBox] call seven_fnc_lha_UpdateListBox;

//BayWatch
	_radius = LHA_BayRadius;

while {LHAAlive} do {
	_bay = 1;

	//Update Bay Status
	{
		_CheckPos = (lhd modeltoworld _x);
		_bayStatus = LHA_BayStatus select (_bay - 1);
		_NearObjectsAir = (_CheckPos nearObjects ["Air",_radius]);
		_NearObjectsLand = ( nearestObjects [ _CheckPos, ["Land","WeaponHolder","ReammoBox_F","Cargo_base_F","StaticWeapon"],_radius]);
		_NearObjectsSea = (nearestObjects[_CheckPos,["Ship"],_radius]);
		_allObjects = _NearObjectsAir + _NearObjectsLand + _NearObjectsSea;
		_pic = 1100 + _bay;
		_picture = (_display displayCtrl _pic);

		if (count _allObjects > 0) then {
			if (_bayStatus) then {
				[_bay,false] call seven_fnc_lha_BayStatusUpdate;
			};
			if (LHA_SelectedBay == _bay) then {
				LHA_ActiveObject = _allObjects select 0;
			};
			_icon = getText (configfile >> "CfgVehicles" >> (TypeOf (_allObjects select 0)) >> "Picture");
			_picture ctrlSetText format ["%1",_icon];
		} else {
			_picture ctrlSetText "";
			LHA_BayStatus set [(_bay - 1),true];
		};
		_bay = _bay + 1;
	} foreach LHA_BayPositions;

	if(LHA_SelectedBay > 0) then {
		//Update Active Bay details
		if(LHA_ActiveObject != Player) then {
			//Update Details
			_TypeOfV = TypeOf LHA_ActiveObject;
			_vehName = getText (configfile >> "CfgVehicles" >> _TypeOfV >> "displayName");

			_VehID = LHA_ActiveObject getVariable["VehID",''];
			if (_VehID != '') then {
				_vehName = format["%1 (%2)",_vehName,_VehID];
			};

			_TextVehicle ctrlSetText format ["%1",_vehName];
			_icon = getText (configfile >> "CfgVehicles" >> _TypeOfV >> "Picture");
			_IconVehicle ctrlSetText format ["%1",_icon];
			if (format ["%1",driver LHA_ActiveObject] != "<NULL-object>") then {_TextDriver ctrlSetText format ["%1",driver LHA_ActiveObject];} else {_TextDriver ctrlSetText "None";	};
		} else {
			_IconVehicle ctrlSetText "";
			_TextVehicle ctrlSetText "None";
			_TextDriver ctrlSetText "None";
		};

		//Check if Issuing button should be shown

		_baySelected = (LHA_SelectedBay > 0);
		_bayStatus = LHA_BayStatus select (LHA_SelectedBay - 1);

		_vehList = (_display displayCtrl 1006);
		_type = lbCurSel _vehList;

		// ** CHECK SPAWN BUTTON STATUS
		if((_baySelected) and (_bayStatus) and (_type > -1)) then {
			_ctrlSpawn ctrlEnable true;
		} else {
			_ctrlSpawn ctrlEnable false; // Disable Issuing Button
		};

		// ** CHECK RETURN/SERVICE BUTTON STATUS
		if(!_bayStatus) then {
			_ctrlReturn ctrlEnable true;
			_ctrlService ctrlEnable true;
			_ctrlLoad ctrlEnable true;
			_ctrlLoadPers ctrlEnable true;
		} else {
			_ctrlReturn ctrlEnable false;
			_ctrlService ctrlEnable false;
			_ctrlLoad ctrlEnable false;
			_ctrlLoadPers ctrlEnable false;
		};
	};
	sleep 0.5;
};