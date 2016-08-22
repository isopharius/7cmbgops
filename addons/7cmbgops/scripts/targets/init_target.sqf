//=====================================================================
//script by Walker
//www.united-nations-army.eu
//=====================================================================
// This script initilizes a new target, collects the positions of the hits.
// The saved positions are passed to check_target.sqf
// Init line: nul = [this] execVM "una_targets\init_target.sqf";
//=====================================================================

_target_name = format["target_%1",time];
_monitor = nil;

_path = "scripts\una_targets\";
_target = _this select 0;
if(count _this > 1) then {_monitor = _this select 1;};
if(count _this > 2) then {_target_name = _this select 2;};

_scoretable = [];

_target setVectorUp [0,0,1];

//Initilize target

//set target texture
_target setObjectTexture [0,_path + 'circular_target.paa'];

WALKTARGETPUBVAR = false;

//get target center position
_offset = [0.00,-1.306];

//calibrated score borders
_borders = [0.460,0.410,0.365,0.320,0.270,0.225,0.175,0.130,0.080,0.035, 0];
_holelist = [];
_score_table_count_before = 0;
_action_cs = 0;
_action_ct = 0;
_action_csm = 0;
_action_ctm = 0;

//how often the the target is checked for new hits (in seconds)
_sweeptime = 0.1;

//target loop
_xb = 0;
_yb = 0;

While {true} do {

  //if there has been new hits to the target -> update check target actions

  if(count _scoretable > _score_table_count_before) then {
	_score_table_count_before = count _scoretable;
    _target removeAction _action_cs;
	_target removeAction _action_ct;
	_action_cs = _target addaction ["Inspect target", _path + "check_target.sqf",[_scoretable,_target_name]];
	_action_ct = _target addaction ["Clear target", _path + "clear_target.sqf",_target];

    //Enable target actions from a monitor object
    if(!isNull _monitor) then {
        _monitor = _this select 1;
        _monitor removeAction _action_csm;
		_monitor removeAction _action_ctm;
        _action_csm = _monitor addaction ["Inspect target", _path + "check_target.sqf",[_scoretable,_target_name]];
        _action_ctm = _monitor addaction ["Clear target", _path + "clear_target.sqf",_target];
    };
  }
  else {
    _score_table_count_before = count _scoretable;
  };

  //if target has been cleared
	if (_target getVariable ["WALKTARGETPUBVAR", false]) then {
		sleep _sweeptime;
		_target setObjectTexture [0,_path + 'circular_target.paa'];
		_scoretable = [];
		_score_table_count_before = 0;
		_target setVariable ["WALKTARGETPUBVAR", false, true];

        _target removeAction _action_cs;
        _target removeAction _action_ct;
        _monitor removeAction _action_csm;
        _monitor removeAction _action_csm;

        //Enable target actions from a monitor object

		if(!isnil _monitor) then {
			_monitor = _this select 1;
			_monitor removeAction _action_cs;
			_monitor removeAction _action_ct;
			_action_cs = _target addaction ["Inspect target", _path + "check_target.sqf",[_scoretable,_target_name]];
			_action_ct = _target addaction ["Clear target", _path + "clear_target.sqf",_target];
		};
	};

  //wait sweeptime
	sleep _sweeptime;

  //get recent hits
	_hits = [(getposATL _target select 0),(getposATL _target select 1),(getposATL _target select 2) -  (_offset select 1)] nearObjects ["#craterOnVehicle",1];

    if(count _hits > 0) then {

      _last_hit = _hits select (count _hits - 1);

        _j = 0;
        //iterate trough all hits since last sweep
        while { !(_last_hit in _holelist) } do {
			_holelist = _holelist + [_last_hit];

			//position of last hit (in world coords)
			_xh = getpos _last_hit select 0;
			_yh = getpos _last_hit select 1;
			_zh = getpos _last_hit select 2;

			//position of target (in world coords)
			_xt = getposATL _target select 0;
			_yt = getposATL _target select 1;
			_zt = getposATL _target select 2;

			//position of last hit (in target coords)
			_xb = sqrt((_xh-_xt)*(_xh-_xt) + (_yh-_yt)*(_yh-_yt)) + (_offset select 0);
			_yb = _zh + (_offset select 1) - _zt;

			if (_xh < _xt) then {
				_xb = -_xb;
			};

			if ((getdir _target) >= 180) then {
				_xb = -_xb;
			};

			//save the hit positions into an array
			_scoretable = _scoretable + [_xb,_yb];

			_j = _j + 1;

			if (count _hits > (_j)) then {
               _last_hit = _hits select (count _hits - (_j + 1));
			};
        };
    };
};


