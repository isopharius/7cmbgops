	private ["_pos","_backpack","_size","_array","_FSFSV_SacADosGwh"];
	_pos = [player,1,(getDir player)] call BIS_fnc_relPos;
	_backpack = backpack player;
	_size = sizeof _backpack;
	_array = _pos isFlatEmpty [(_size / 2),0,0.7,_size,0,false,player];
	if (count _array == 0) then {_pos = getPosworld player;};
	if (count _pos > 0) then {

		_FSFSV_SacADosGwh = createVehicle ["GroundWeaponHolder", _pos, [], 0, "can_collide"];
		_FSFSV_SacADosGwh setPosworld _pos;
		player reveal _FSFSV_SacADosGwh;
		player action ["DropBag",_FSFSV_SacADosGwh,_backpack];
		player forceWalk true;
		sleep 2;

		if ((backpack player == "") && !(isNull _FSFSV_SacADosGwh)) then {//anti Action::Process - No target [action: DropBag]
			private ["_positionMemorisee","_positionActualisee","_vehicle"];
			_FSFSV_SacADosGwh attachTo [player,[-0.1,0.8,-0.05],"pelvis"];
			_FSFSV_SacADosGwh setVectorDirAndUp [[0,0,-1],[0,1,0]];
			_positionMemorisee = "vertical";

			player setVariable ["FSFSV_BACKPACK",_FSFSV_SacADosGwh];
			while {!(isNull _FSFSV_SacADosGwh)} do {
				_positionActualisee = (animationState player) call seven_fnc_FSFSV_QuellePosition;

				if ((_positionMemorisee != _positionActualisee) && (_positionActualisee != "")) then {
					switch (_positionActualisee) do {
						case "vertical" : {
							_FSFSV_SacADosGwh attachTo [player,[-0.1,0.8,-0.05],"pelvis"];
							_FSFSV_SacADosGwh setVectorDirAndUp [[0,0,-1],[0,1,0]];
						};
						case "horizontallower" : {
							_FSFSV_SacADosGwh attachTo [player,[-0.1,0,-0.72],"pelvis"];
							_FSFSV_SacADosGwh setVectorDirAndUp [[0,-1,-0.15],[0,0,-1]];
						};
						case "horizontalupper" : {
							_FSFSV_SacADosGwh attachTo [player,[-0.1,0.4,0.75],"pelvis"];
							_FSFSV_SacADosGwh setVectorDirAndUp [[0,0.75,-0.25],[0,0.25,0.75]];
						};
					};
					_positionMemorisee = _positionActualisee;
				};

				if (player != vehicle player) then {
					private "_para";
					_vehicle = vehicle player;
					_para = if (_vehicle isKindOf "ParachuteBase") then {true;} else {false;};

					if (_para) then {
						_FSFSV_SacADosGwh attachTo [_vehicle,[-0.12,0.65,-0.15]];
						_FSFSV_SacADosGwh setVectorDirAndUp [[0,-0.2,-1],[0,1,0]];
						//anti-bug Lino, addAction temporarily removed
						player setVariable ["FSFSV_BACKPACK",objnull];
					} else {
						detach _FSFSV_SacADosGwh;
						_FSFSV_SacADosGwh setposworld [random 50,random 50,(10000 + (random 50))];
						[[_FSFSV_SacADosGwh,true],"FSFSV_cacheObjet"] call BIS_fnc_MP;
					};

					waitUntil {sleep 0.1;((player == vehicle player) || !(alive player))};

					if (_para) then {
						[[_FSFSV_SacADosGwh,true],"FSFSV_cacheObjet"] call BIS_fnc_MP;
						sleep 5;
						if (alive player) then {player setVariable ["FSFSV_BACKPACK",_FSFSV_SacADosGwh];};
					};
					[[_FSFSV_SacADosGwh,false],"FSFSV_cacheObjet"] call BIS_fnc_MP;
					_positionMemorisee = "out";
				};

				if !(alive player) exitWith {
					private ["_delay","_falling","_speed"];
					//anti-bug collision, shock or other... tempo 100s, if he died in freefall (~3000m)
					_delay = time + 100;
					waitUntil {
						sleep 0.2;
						_vehicle = vehicle player;
						_speed = speed _vehicle;
						_falling = (velocity _vehicle) select 2;
						(((_speed > -1) && (_speed < 1) && (_falling < 0.5) && (_falling > -0.5)) || (time > _delay))
					};
					if !(isNull (attachedTo _FSFSV_SacADosGwh)) then {detach _FSFSV_SacADosGwh;};
					_FSFSV_SacADosGwh setPosworld (getPosworld player);
					player setVariable ["FSFSV_BACKPACK",objnull];
				};
				sleep 0.1;
			};
		} else {
			player forceWalk false;
		};
	};