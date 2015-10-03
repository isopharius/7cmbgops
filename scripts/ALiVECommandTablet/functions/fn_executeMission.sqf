private ["_operation"];

if (isNil {uiNamespace getVariable "SpyderCommandTablet_MissionPosition"}) exitWith {hint "Please select a position on the map first"};

_operation = lbCurSel 7239;

switch (str (_operation)) do {
	case "0": {
		["client"] spawn STC_fnc_requestReinforcements;
	};
	case "1": {
		["client"] spawn STC_fnc_requestRecon;
	};
	case "2": {
		["client"] spawn STC_fnc_requestAssault;
	};
};

//-- Disable confirm mission button and de-select item from list
lbClear 7239;
lbSetCurSel [7239, -1];
lbAdd [7239, "Reinforcements"];
lbAdd [7239, "Recon"];
lbAdd [7239, "Assault"];
lbSetTooltip [7239, 0, "Call for nearby friendly troops to come to the location"];
lbSetTooltip [7239, 1, "Call for a friendly recon team to move to the area and mark any visible enemies; Only uses one group regardless of settings"];
lbSetTooltip [7239, 2, "Call for nearby friendly troops to assault a location"];

ctrlEnable [72315, false];