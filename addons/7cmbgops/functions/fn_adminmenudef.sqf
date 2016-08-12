#include <\x\alive\addons\sys_viewdistance\script_component.hpp>
#include <\x\cba\addons\ui_helper\script_dikCodes.hpp>

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus"];

PARAMS_2(_target,_params);

_menuName = "";
_menuRsc = "popup";

if (typeName _params == typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__];};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};

_menus =
[
	[
		["main", "ALiVE", _menuRsc],
		[
			["7CMBG Admin >",
				"",
				"",
				"",
                ["call seven_fnc_adminMenuDef", "admin", 1],
                -1, 1, call ALIVE_fnc_isServerAdmin
			]
		]
	]
];

if (_menuName == "admin") then {
	_menus set [count _menus,
		[
			["admin", "Admin Menu", "popup"],
				[
					["Neutral friendly to BLUFOR",
						{resistance setFriend [west, 1]; west setfriend [resistance,1]},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["Neutral hostile to BLUFOR",
						{resistance setFriend [west, 0]; west setfriend [resistance,0]},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["Neutral friendly to OPFOR",
						{resistance setFriend [east, 1]; east setfriend [resistance,1]},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["Neutral hostile to OPFOR",
						{resistance setFriend [east, 0]; east setfriend [resistance,0]},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["PAUSE PROFILER",
						{["ALIVE_SYS_PROFILE"] call ALiVE_fnc_pauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["PAUSE CIVS",
						{["ALIVE_AMB_CIV_POPULATION"] call ALiVE_fnc_pauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["PAUSE CQB",
						{["ALIVE_MIL_CQB"] call ALiVE_fnc_pauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["PAUSE IED",
						{["ALIVE_MIL_IED"] call ALiVE_fnc_pauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["PAUSE OPCOM",
						{["ALIVE_MIL_OPCOM","ALIVE_MIL_LOGISTICS"] call ALiVE_fnc_pauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["PAUSE ALL",
						{["ALIVE_MIL_IED","ALIVE_MIL_CQB","ALIVE_AMB_CIV_POPULATION","ALIVE_SYS_PROFILE","ALIVE_MIL_OPCOM","ALIVE_MIL_LOGISTICS"] call ALiVE_fnc_pauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["RESUME PROFILER",
						{["ALIVE_SYS_PROFILE"] call ALiVE_fnc_unpauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["RESUME CIVS",
						{["ALIVE_AMB_CIV_POPULATION"] call ALiVE_fnc_unpauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["RESUME CQB",
						{["ALIVE_MIL_CQB"] call ALiVE_fnc_unpauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["RESUME IED",
						{["ALIVE_MIL_IED"] call ALiVE_fnc_unpauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["RESUME OPCOM",
						{["ALIVE_MIL_OPCOM","ALIVE_MIL_LOGISTICS"] call ALiVE_fnc_unpauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					],
					["RESUME ALL",
						{["ALIVE_MIL_IED","ALIVE_MIL_CQB","ALIVE_AMB_CIV_POPULATION","ALIVE_SYS_PROFILE","ALIVE_MIL_OPCOM","ALIVE_MIL_LOGISTICS"] call ALiVE_fnc_unpauseModule},
						"",
						"",
						"",
						-1,
						1,
						true
					]
				]
			]
		];
};

_menuDef = [];
{
	if (_x select 0 select 0 == _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if (count _menuDef == 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName == "") then {_this}else{""}, __FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};

_menuDef